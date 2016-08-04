//
//  AppDelegate.h
//  Test_Suteng3
//
//  Created by  suteng on 16/2/17.
//  Copyright © 2016年 suteng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDVTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RDVTabBarController* tabbarController;

- (void) setRDVTabBarRootViewController;
@end

