//
//  BaseViewController.m
//  SHBasePro
//
//  Created by shenghai on 16/9/2.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "BaseViewController.h"
#import "RDVTabBarController.h"
#include <objc/runtime.h>

@interface BaseViewController() <UIGestureRecognizerDelegate>

@end

@implementation BaseViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_btn_ios7"] forState:UIControlStateNormal];
    [backBtn setFrame:CGRectMake(0, 0, 44, 44)];
    [backBtn addTarget:self action:@selector(backBtnPre:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_bg_64.png"]forBarMetrics:UIBarMetricsDefault];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //自动判断如果是第一次导航栏隐藏否则显示，联动的标签控制栏要另外处理
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        [self.rdv_tabBarController setTabBarHidden:NO animated:NO];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [self.rdv_tabBarController setTabBarHidden:YES animated:NO];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.navigationController.viewControllers count] > 1) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    } else {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    //自动判断如果是第一次导航栏隐藏否则显示，联动的标签控制栏要另外处理
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        [self.rdv_tabBarController setTabBarHidden:NO animated:NO];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
        
}

- (void) backBtnPre : (UIButton*) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
