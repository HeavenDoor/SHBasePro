//
//  UIWindow +Category.h
//  TakeVideo
//
//  Created by heyk on 4/5/16.
//  Copyright © 2016年 成都好房通股份科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow(Category)

@property (nullable, nonatomic, readonly, strong) UIViewController *topMostController;

@property (nullable, nonatomic, readonly, strong) UIViewController *currentViewController;

@end
