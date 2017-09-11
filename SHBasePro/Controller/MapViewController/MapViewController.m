//
//  MapViewController.m
//  Tencent_Map_Demo_Raster
//
//  Created by WangXiaokun on 15/12/28.
//  Copyright © 2015年 WangXiaokun. All rights reserved.
//

#import "MapViewController.h"
#import <QMapKit/QMapKit.h>
#import <QMapSearchKit/QMapSearchKit.h>
#import <TencentLBS/TencentLBS.h>
#import "UIImage-Extensions.h"
#import <math.h>
#import "PayCenterProtocol.h"
#import "AppDelegate.h"
#import "PayParams.h"

#define MathUtils_SignBit(x) (((signed char*) &x)[sizeof(x) - 1] >> 7 & 1)

#define radiansToDegrees(x) (180.0 * x / M_PI)
#define toDeg(X) (X*180.0/M_PI)
static CGFloat ffffolatro = 40.0;

@interface MapViewController ()<UIGestureRecognizerDelegate, QMapViewDelegate, QMSSearchDelegate, TencentLBSLocationManagerDelegate, PayCenterProtocol>

@property(nonatomic, strong) UIView* navigationView;
@property(nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) NSArray *annotations;
@property (nonatomic, strong) QMapView *mapView;
@property (nonatomic, strong) UIImageView *pointerView;

@property (nonatomic, strong) QMSSearcher *mapSearcher;
@property (nonatomic, strong) QMSSuggestionResult *suggestionResut;
@property (nonatomic, strong) QMSGeoCodeSearchResult *geoResult;

@property (nonatomic, strong) UIImageView *smallpointerView;

@property (nonatomic, strong) UIButton *loactionButton;

@property (nonatomic, strong) QMSDrivingRouteSearchOption *drivingRouteSearchOption;
@property (nonatomic, strong) QMSRoutePlan *routePlanToDetail;

@property(nonatomic, strong) TencentLBSLocationManager *locationManager;


@property(nonatomic, assign) CLLocationCoordinate2D startPos;

@property(nonatomic, assign) CGFloat carAngel;
@property(nonatomic, strong) CLHeading *curHeading;
@end

@implementation MapViewController

- (void)test {
    NSLog(@"=====%@ Test... =====", [self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAK_SELF;
    

    [[[AppDelegate sharedInstance] payCenter] setPayCenterDelegate:self];
    _carAngel = 0.0;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self initAnnotations];
    self.navigationView = [[UIView alloc] init];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(@64);
    }];
    
    UIImageView* imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:@"navi_bg_64.png"]];
    [self.navigationView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.navigationView);
    }];
    
    UIButton *backBtn = [[UIButton alloc] init];
    [self.navigationView addSubview: backBtn];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_btn_ios7"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnPre:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navigationView);
        make.left.equalTo(self.navigationView.mas_left).offset(10);
        make.top.equalTo(self.navigationView.mas_top).offset(20);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@44);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor whiteColor];
    [_navigationView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_navigationView.mas_centerX);
        make.centerY.equalTo(_navigationView.mas_centerY).offset(20);
    }];
    
    
    // Do any additional setup after loading the view.
    [self initMap];
    [self addPointerView];
}

- (void)viewWillAppear:(BOOL)animated {
    [_mapView setUserTrackingMode:QUserTrackingModeFollowWithHeading animated:YES];
}

- (void)dealloc {
    NSLog(@"=====%@被销毁了=====", [self class]);
    [[[AppDelegate sharedInstance] payCenter] testGgwp];
    [self.locationManager stopUpdatingLocation];
    [self.locationManager stopUpdatingHeading];
}

- (void) backBtnPre: (UIButton*) btn {
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addPointerView {

//    UIImage *img = [UIImage imageNamed:@"pin"];
//    _pointerView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - img.size.width/2, ([UIScreen mainScreen].bounds.size.height - 64 )/2 - img.size.height, img.size.width, img.size.height)];
//    [_pointerView setImage:img];
//    [self.mapView addSubview:_pointerView];
//    [self.mapView bringSubviewToFront:_pointerView];

    
//    UIImage *imgSmall = [UIImage imageNamed:@"aa"];
//    _smallpointerView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - imgSmall.size.width/2, ([UIScreen mainScreen].bounds.size.height - 64)/2 - imgSmall.size.height/2, imgSmall.size.width, imgSmall.size.height)];
//    _smallpointerView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 150, 150, 150)];
//    [self.mapView addSubview:_smallpointerView];
//    [_smallpointerView setImage:imgSmall];
//    [self.mapView addSubview:_smallpointerView];
//    [self.mapView bringSubviewToFront:_smallpointerView];
    
    _loactionButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 64 - 20 - 30, 30, 30)];
    [_mapView addSubview:_loactionButton];
    [_loactionButton setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [_loactionButton addTarget:self action:@selector(loactionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) initAnnotations {
    QPointAnnotation *yinke = [[QPointAnnotation alloc] init];
    //yinke.title = @"软件园";
    yinke.coordinate = CLLocationCoordinate2DMake(30.539714,104.075519);
    
    
    QPointAnnotation *shiwei = [[QPointAnnotation alloc] init];
    //shiwei.coordinate = CLLocationCoordinate2DMake(30.572523, 104.066414);
    shiwei.coordinate = CLLocationCoordinate2DMake(29.827223, 121.582414);
    
    _annotations = [NSArray arrayWithObjects:yinke,shiwei, nil];
    
    
//
//    QPointAnnotation *bowuyuan = [[QPointAnnotation alloc] init];
//    bowuyuan.title = @"四川博物院";
//    bowuyuan.coordinate = CLLocationCoordinate2DMake(30.661116, 104.033981);
//    
//    QPointAnnotation *scdx = [[QPointAnnotation alloc] init];
//    scdx.title = @"四川大学";
//    scdx.coordinate = CLLocationCoordinate2DMake(30.630886, 104.084038);
//    
//    QPointAnnotation *cdnz = [[QPointAnnotation alloc] init];
//    cdnz.title = @"成都南站";
//    cdnz.coordinate = CLLocationCoordinate2DMake(30.606649, 104.067879);
//    
//    QPointAnnotation *caijing = [[QPointAnnotation alloc] init];
//    caijing.title = @"西南财经大学";
//    caijing.coordinate = CLLocationCoordinate2DMake(30.666584, 104.015282);
//    
//    QPointAnnotation *slz= [[QPointAnnotation alloc] init];
//    slz.title = @"双流站";
//    slz.coordinate = CLLocationCoordinate2DMake(30.550880, 104.025810);
//    
//
//    _annotations = [NSArray arrayWithObjects:shiwei, bowuyuan, scdx, cdnz, caijing, slz, nil];
}


- (void)initMap {
    
    _startPos = CLLocationCoordinate2DMake(30.572523, 104.066414);
    [self initAnnotations];
    _mapView = [[QMapView alloc] initWithFrame: CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
    [self.view addSubview:self.mapView];
    //初始化设置地图中心点坐标需要异步加入到主队列
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(30.539714,104.075519)
                            zoomLevel:10.01
                             animated:YES];
    });
    //由于zoomLevel的调用区间是左闭右开的，在调用某一级别的图片时，
    //实际调用的是上级的最大缩放级别，底图有可能会看到锯齿，
    //此时可以在缩放级别上加上0.01使用高级别底图
    [_mapView setZoomLevel:10.01];
    
    _mapView.showsUserLocation = YES;
    _mapView.keepCenterEnabled = YES;
    _mapView.forceUpdatingHeading = YES;
    _mapView.keepCenterEnabled =YES;
    
    //[_mapView viewForAnnotation:[_annotations objectAtIndex:0]].selected = YES;
    
    _mapView.delegate = self;
    //_mapView.isan
    [_mapView setUserTrackingMode:QUserTrackingModeFollowWithHeading animated:YES];
    //_mapView.userTrackingMode = QUserTrackingModeFollowWithHeading;
    
    // search
    _mapSearcher = [[QMSSearcher alloc] initWithDelegate:self];
    
    [self.view bringSubviewToFront: self.navigationView];
    
    [_mapView addAnnotations:_annotations];
    [_mapView showAnnotations:_annotations animated:YES];
    
    
    //[self setupSearchOptions];
    
    self.locationManager = [[TencentLBSLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    [self.locationManager setApiKey:@"QHGBZ-OYPLD-2RB4R-PEE3A-MGPJ2-UKBA4"];
    [self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingHeading]; //定位更新朝向 这个暂时不需要
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    [gestureRecognizer setDelegate:self];
    [_mapView addGestureRecognizer:gestureRecognizer];

}

#pragma mark 路径规划覆盖到地图
- (void)setupSearchOptions {
    [_mapView removeOverlays:_mapView.overlays];
    self.drivingRouteSearchOption = [[QMSDrivingRouteSearchOption alloc] init];
    [self.drivingRouteSearchOption setFromCoordinate:CLLocationCoordinate2DMake(30.539714,104.075519)]; // 软件园
    [self.drivingRouteSearchOption setToCoordinate:CLLocationCoordinate2DMake(30.666584, 104.015282)]; // 财经大学
    [self.drivingRouteSearchOption setPolicyWithType:QMSDrivingRoutePolicyTypeLeastDistance];
    [self.mapSearcher searchWithDrivingRouteSearchOption:self.drivingRouteSearchOption];
}

- (void)searchWithDrivingRouteSearchOption:(QMSDrivingRouteSearchOption *)drivingRouteSearchOption didRecevieResult:(QMSDrivingRouteSearchResult *)drivingRouteSearchResult {
    NSLog(@"Driving result:%@", drivingRouteSearchResult);
    [self dealDrivingRoute:drivingRouteSearchResult];
}

- (QOverlayView *)mapView:(QMapView *)mapView viewForOverlay:(id<QOverlay>)overlay {
    QPolyline *polyline = (QPolyline *)overlay;
    QPolylineView *polylineView = [[QPolylineView alloc] initWithPolyline:overlay];
    polylineView.lineWidth = 5;
    if (polyline.dash) {
        polylineView.lineDashPattern = @[@3, @9];
        polylineView.strokeColor = [UIColor colorWithRed:0x55/255.f green:0x79/255.f blue:0xff/255.f alpha:1];
    } else {
        polylineView.lineDashPattern = nil;
        polylineView.strokeColor = [UIColor colorWithRed:0x00/255.f green:0x79/255.f blue:0xff/255.f alpha:1];
    }
    return polylineView;
}

- (void)dealDrivingRoute:(QMSDrivingRouteSearchResult *)drivingRouteResult {
    QMSRoutePlan *drivingRoutePlan = [[drivingRouteResult routes] firstObject];
    self.routePlanToDetail = drivingRoutePlan;
    
    [self.mapView removeOverlays:self.mapView.overlays];
    NSUInteger count = drivingRoutePlan.polyline.count;
    CLLocationCoordinate2D coordinateArray[count];
    for (int i = 0; i < count; ++i) {
        [[drivingRoutePlan.polyline objectAtIndex:i] getValue:&coordinateArray[i]];
    }
    
    QPolyline *drivePolyline = [QPolyline polylineWithCoordinates:coordinateArray count:count];
    [self.mapView addOverlay:drivePolyline];
}


#pragma mark mapViewDelegate
- (void)mapView:(QMapView *)mapView annotationView:(QAnnotationView *)view didChangeDragState:(QAnnotationViewDragState)newState
   fromOldState:(QAnnotationViewDragState)oldState{
}

- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {

}

- (void)mapView:(QMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    //NSLog(@"位置改变了");
    QMSReverseGeoCodeSearchOption *opetion = [[QMSReverseGeoCodeSearchOption alloc] init];
    UIImage *imgSmall = [UIImage imageNamed:@"aa"];
    CLLocationCoordinate2D location = [mapView convertPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/2 - imgSmall.size.width/2, ([UIScreen mainScreen].bounds.size.height - 64)/2 - imgSmall.size.height) toCoordinateFromView:mapView];
    [opetion setLocationWithCenterCoordinate:location];
    [_mapSearcher searchWithReverseGeoCodeSearchOption: opetion];
    
}

- (void)searchWithReverseGeoCodeSearchOption:(QMSReverseGeoCodeSearchOption *)reverseGeoCodeSearchOption didReceiveResult:(QMSReverseGeoCodeSearchResult *)reverseGeoCodeSearchResult
{
    QMSReverseGeoCodeSearchResult* result = reverseGeoCodeSearchResult;
    self.titleLabel.text = result.formatted_addresses.recommend;
    //NSLog(@"%@", result);
}

- (void)mapView:(QMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    CLLocationCoordinate2D location = [mapView convertPoint:mapView.center toCoordinateFromView:mapView];
}

- (void)loactionButtonClicked:(UIButton*)sender {
    ffffolatro += 15.0;
//    UIImage* img = [[UIImage imageNamed:@"jiaoche_car_"] imageRotatedByDegrees: ffffolatro];
//    QAnnotationView *annotationView = [self mapView:_mapView viewForAnnotation:_annotations[0]];
//    if (annotationView != nil) {
//        annotationView.image = img;
//    }
//    [_smallpointerView setImage:img];
    [_mapView removeAnnotations:_annotations];
    [_mapView addAnnotations:_annotations];
    NSLog(@"Say Hello Clicked");
    
    //_mapView.userTrackingMode = QUserTrackingModeFollowWithHeading;
    //[_mapView setZoomLevel:15.01];
}

- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id <QAnnotation>)annotation {
    if ([annotation isKindOfClass:[QPointAnnotation class]]) {
        //添加默认pinAnnotation
        if ([annotation isEqual:[_annotations objectAtIndex:0]]) {
            
            //QAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"AAA"];
            //if (annotationView == nil) {
               QAnnotationView *annotationView = [[QAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AAA"];
                
                annotationView.canShowCallout = NO;
                //annotationView.selected = YES;
                
            //}
            UIImage* img = [[UIImage imageNamed:@"jiaoche_car_"] imageRotatedByDegrees: 90 - _carAngel];
            annotationView.image = img;
            //annotationView.pinColor = QPinAnnotationColorPurple;
//            UIView *btn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
//            btn.backgroundColor = [UIColor greenColor];
//            annotationView.leftCalloutAccessoryView = btn;
//            annotationView.draggable = YES;
//            [annotationView setSelected:YES animated:YES];
            return annotationView;
        } else {
            QPinAnnotationView *annotationView = (QPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"TTTTT"];
            if (nil == annotationView) {
                annotationView = [[QPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"TTTTT"];
            }
            annotationView.pinColor = QPinAnnotationColorPurple;
            annotationView.canShowCallout = NO;
            return annotationView;
        }
    } else if ([annotation isKindOfClass:[QUserLocation class]]) {
        QAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"GGGGGGG"];
        if (nil == annotationView) {
            annotationView = [[QAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"GGGGGGG"];
        }
        annotationView.image = [UIImage imageNamed:@""];
        annotationView.canShowCallout = NO;
        return annotationView;
    }
    return nil;
}

-(void)gestureAction:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationOfTouch:0 inView:_mapView];
    //NSLog(@"Tap at:%f,%f", point.x, point.y);
    CLLocationCoordinate2D location = [_mapView convertPoint:point toCoordinateFromView:_mapView];
    _carAngel = [self getAngle:_startPos.latitude latitude1:_startPos.longitude longitude2:location.latitude latitude2:location.longitude];
    
    [_mapView removeAnnotations:_annotations];
    [_mapView addAnnotations:_annotations];
    
    
    
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    return YES;
}


- (CGFloat)getCarAngel {
    CGPoint sPos = CGPointMake(0, 0);
    CGPoint ePos = CGPointMake(-17.32, -10);
    
    CGFloat height = ePos.y - sPos.y;
    CGFloat width = ePos.x - sPos.x;
    CGFloat rads = atan(height/width);
    CGFloat angel = radiansToDegrees(rads);

    if(sPos.x < ePos.x && sPos.y < ePos.y) { // 第一象限
        // 不动
    } else if (sPos.x > ePos.x && sPos.y < ePos.y){ // 第二象限
        angel = angel - 180;
    } else if (sPos.x > ePos.x && sPos.y > ePos.y){ // 三象限
        angel = angel + 180;
    } else if (sPos.x < ePos.x && sPos.y > ePos.y){ // 四象限
        // 不动
    }
    if (angel == 0) {
        int flag = MathUtils_SignBit(angel);
        if (flag == 1) {
            angel = -180;
        }
    }
    
    return angel;
}


- (CGFloat)getAngle:(double)longitude1 latitude1:(double)latitude1 longitude2:(double)longitude2 latitude2:(double)latitude2 {
    
    double cos_c = cos(90 - latitude2)*cos(90 - latitude1) + sin(90 - latitude2)*sin(90 - latitude1)*cos(longitude2-longitude1);
    
    
    
    double sin_c = sqrt(1 - pow(cos_c, 2));
    
    
    
    double z = asin(sin(90 - latitude2)*sin(longitude2 - longitude1)/sin_c);
    
    z = toDeg(z);
    
    
    
    
    
    // A（起始点）为原点B目标点
    
    if(longitude1 < longitude2 && latitude1 < latitude2) { // 第一象限
        
        
        if (z<0) {
            z = -z;
        }
    } else if (longitude1 < longitude2 && latitude1 > latitude2){ // 第二象限
        
        z += 360;
        
    } else { // 三四象限
        
        z = 180 - z;
        
    }
    
    //cityHeading = z;
    
    
    
    NSLog(@"城市夹角:%f",z);
    return z;
}



- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
   // NSLog(@"朝向改变 === %@", newHeading);
    _curHeading = newHeading;
    _carAngel = [self getCarAngel];
    
    int xx = MathUtils_SignBit(_carAngel);
    if(_carAngel == -0.0) {
        NSLog(@"-0");
    }
    if (_carAngel == 0.0) {
        NSLog(@"0");
    }
    [_mapView removeAnnotations:_annotations];
    [_mapView addAnnotations:_annotations];
}

- (void)mapView:(QMapView *)mapView annotationView:(QAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    /*QMSBaseResult *poi = [(PoiAnnotation *)view.annotation poiData];
    PoiDetailViewController *vc = [[PoiDetailViewController alloc] initWithQMSResult:poi];
    [vc setTitle:self.title];
    [self.navigationController pushViewController:vc animated:YES];*/
}


#pragma mark LBSLocation
- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager didUpdateLocation:(TencentLBSLocation *)location {
    //NSLog(@"%@", [NSString stringWithFormat:@"定位回来 %lf", location.location.course]);

}

- (BOOL)tencentLBSLocationManagerShouldDisplayHeadingCalibration:(TencentLBSLocationManager *)manager {
    return NO;
}

@end


static char *QMSPolylineDashKey = "kQMSPolylineDashKey";

@implementation QPolyline (RouteExtention)

- (void)setDash:(BOOL)dash {
    objc_setAssociatedObject(self, QMSPolylineDashKey, [NSNumber numberWithBool:dash], OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)dash {
    NSNumber *dashNum = objc_getAssociatedObject(self, QMSPolylineDashKey);
    return [dashNum boolValue];
}

@end
