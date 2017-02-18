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

@interface MapViewController ()<UIGestureRecognizerDelegate, QMapViewDelegate, QMSSearchDelegate>

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
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void) backBtnPre: (UIButton*) btn {
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addPointerView {
    UIImage *img = [UIImage imageNamed:@"pin"];
    _pointerView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - img.size.width/2, ([UIScreen mainScreen].bounds.size.height - 64 )/2 - img.size.height, img.size.width, img.size.height)];
    [_pointerView setImage:img];
    [self.mapView addSubview:_pointerView];
    [self.mapView bringSubviewToFront:_pointerView];
    //_pointerView.backgroundColor = [UIColor greenColor];
    //_pointerView;
    
    UIImage *imgSmall = [UIImage imageNamed:@"aa"];
    _smallpointerView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2 - imgSmall.size.width/2, ([UIScreen mainScreen].bounds.size.height - 64)/2 - imgSmall.size.height/2, imgSmall.size.width, imgSmall.size.height)];
    
    [_smallpointerView setImage:imgSmall];
    [self.mapView addSubview:_smallpointerView];
    [self.mapView bringSubviewToFront:_smallpointerView];
    
    _loactionButton = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 40, [UIScreen mainScreen].bounds.size.height - 64 - 20 - 30, 30, 30)];
    [_mapView addSubview:_loactionButton];
    [_loactionButton setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [_loactionButton addTarget:self action:@selector(loactionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loactionButtonClicked:(UIButton*)sender {
    _mapView.userTrackingMode = QUserTrackingModeFollowWithHeading;
    [_mapView setZoomLevel:15.01];
}

- (void) initAnnotations {
    
    QPointAnnotation *shiwei = [[QPointAnnotation alloc] init];
    shiwei.title = @"成都市委";
    shiwei.coordinate = CLLocationCoordinate2DMake(30.572523, 104.066414);
    
    QPointAnnotation *bowuyuan = [[QPointAnnotation alloc] init];
    bowuyuan.title = @"四川博物院";
    bowuyuan.coordinate = CLLocationCoordinate2DMake(30.661116, 104.033981);
    
    QPointAnnotation *scdx = [[QPointAnnotation alloc] init];
    scdx.title = @"四川大学";
    scdx.coordinate = CLLocationCoordinate2DMake(30.630886, 104.084038);
    
    QPointAnnotation *cdnz = [[QPointAnnotation alloc] init];
    cdnz.title = @"成都南站";
    cdnz.coordinate = CLLocationCoordinate2DMake(30.606649, 104.067879);
    
    QPointAnnotation *caijing = [[QPointAnnotation alloc] init];
    caijing.title = @"西南财经大学";
    caijing.coordinate = CLLocationCoordinate2DMake(30.666584, 104.015282);
    
    QPointAnnotation *slz= [[QPointAnnotation alloc] init];
    slz.title = @"双流站";
    slz.coordinate = CLLocationCoordinate2DMake(30.550880, 104.025810);
    

    _annotations = [NSArray arrayWithObjects:shiwei, bowuyuan, scdx, cdnz, caijing, slz, nil];
}



- (void)initMap {
    [self initAnnotations];
    _mapView = [[QMapView alloc] initWithFrame: CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
    [self.view addSubview:self.mapView];
    //初始化设置地图中心点坐标需要异步加入到主队列
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.963438, 116.316376)
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
    //[_mapView setUserTrackingMode:QUserTrackingModeFollowWithHeading animated:YES];
    _mapView.userTrackingMode = QUserTrackingModeFollowWithHeading;
    //添加手势识别
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureAction:)];
    [gestureRecognizer setDelegate:self];
    [_mapView addGestureRecognizer:gestureRecognizer];
    
    // search
    _mapSearcher = [[QMSSearcher alloc] initWithDelegate:self];
    
    [self.view bringSubviewToFront: self.navigationView];
    
    [_mapView addAnnotations:_annotations];
    [_mapView showAnnotations:_annotations animated:YES];
}

-(void)gestureAction:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationOfTouch:0 inView:_mapView];
    NSLog(@"Tap at:%f,%f", point.x, point.y);
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    
    
    return YES;
}

#pragma mark mapViewDelegate

- (void)mapView:(QMapView *)mapView annotationView:(QAnnotationView *)view didChangeDragState:(QAnnotationViewDragState)newState
   fromOldState:(QAnnotationViewDragState)oldState{
}

- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {

}

- (void)mapView:(QMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"位置改变了");
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
    NSLog(@"%@", result);
}

- (void)mapView:(QMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    CLLocationCoordinate2D location = [mapView convertPoint:mapView.center toCoordinateFromView:mapView];
    
    float x =location.latitude;
    float y =location.longitude;
}



- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id <QAnnotation>)annotation {
    static NSString *reuseID = @"ReuseId";
    QPinAnnotationView *view = (QPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:reuseID];
    if (view == nil)
    {
        view = [[QPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseID];
    }
    
    view.canShowCallout   = YES;
    view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return view;
}

- (void)mapView:(QMapView *)mapView annotationView:(QAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    /*QMSBaseResult *poi = [(PoiAnnotation *)view.annotation poiData];
    PoiDetailViewController *vc = [[PoiDetailViewController alloc] initWithQMSResult:poi];
    [vc setTitle:self.title];
    [self.navigationController pushViewController:vc animated:YES];*/
}



@end
