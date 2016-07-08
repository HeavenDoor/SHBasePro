//
//  UINavigationController+Push.m
//  UUHaoFang
//
//  Created by 郑好 on 15/6/16.
//  Copyright © 2016年 Haofangtong Inc. All rights reserved.
//

#import "UINavigationController+Push.h"
#import <objc/runtime.h>

static void *nodeArrayKey = &nodeArrayKey;

@implementation UINavigationController (Push)

- (void)setNodeArray:(NSMutableArray<__kindof UIViewController *> *)nodeArray {
    objc_setAssociatedObject(self, &nodeArrayKey, nodeArray, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray<__kindof UIViewController *> *)nodeArray {
    NSMutableArray<__kindof UIViewController *> *arr = objc_getAssociatedObject(self, &nodeArrayKey);
    if (arr == nil) {
        arr = [[NSMutableArray alloc] init];
        self.nodeArray = arr;
    }
    return arr;
}

#pragma mark -
- (void)setNodeViewController:(nonnull UIViewController *)viewController {
    if (viewController == nil || ![self.viewControllers containsObject:viewController]) {
        return;
    }
    if ([self.nodeArray containsObject:viewController]) {
        return;
    }
    [self.nodeArray addObject:viewController];
}

#pragma mark -
- (nullable NSArray<__kindof UIViewController *> *)popToNodeViewControllerAnimated:(BOOL)animated {
    if (self.nodeArray.count == 0) {
        return @[[self popViewControllerAnimated:animated]];
    }
    UIViewController *lastOne = [self.nodeArray lastObject];
    [self.nodeArray removeLastObject];
    return [self popToViewController:lastOne animated:animated];
}

@end
