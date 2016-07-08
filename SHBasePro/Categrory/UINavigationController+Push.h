//
//  UINavigationController+Push.h
//  UUHaoFang
//
//  Created by heyk on 15/6/16.
//  Copyright © 2016年 heyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Push)

#pragma mark -
@property (nonatomic, strong)  NSMutableArray<__kindof UIViewController *> * _Nullable nodeArray;

#pragma mark -
- (void)setNodeViewController:(nonnull UIViewController *)viewController;

#pragma mark -
- (nullable NSArray<__kindof UIViewController *> *)popToNodeViewControllerAnimated:(BOOL)animated;

@end
