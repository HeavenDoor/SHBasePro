//
//  UIWindow +Category.m
//  TakeVideo
//
//  Created by heyk on 4/5/16.
//  Copyright © 2016年 成都好房通股份科技有限公司. All rights reserved.
//

#import "UIWindow+Category.h"

@implementation UIWindow(Category)


- (UIViewController*)topMostController
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)currentViewController;
{
    UIViewController *currentViewController = [self topMostController];
    
//    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
//        currentViewController = [(UINavigationController*)currentViewController topViewController];
//    
//    if([currentViewController isKindOfClass:[MainTabBarController class]]) {
//        UINavigationController *vc = ((MainTabBarController*)currentViewController).selectedViewController;
//        currentViewController = [vc.viewControllers lastObject];
//    }
    return currentViewController;
}


@end
