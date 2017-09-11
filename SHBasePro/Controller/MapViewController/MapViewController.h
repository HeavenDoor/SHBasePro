//
//  MapViewController.h
//  Tencent_Map_Demo_Raster
//
//  Created by WangXiaokun on 15/12/28.
//  Copyright © 2015年 WangXiaokun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QMapKit/QPolyline.h>
@interface MapViewController : UIViewController

@end


@interface QPolyline (RouteExtention)

- (void)setDash:(BOOL)dash;

- (BOOL)dash;

@end
