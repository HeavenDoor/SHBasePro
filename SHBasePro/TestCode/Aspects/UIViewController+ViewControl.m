//
//  UIViewController+ViewControl.m
//  SHBasePro
//
//  Created by shenghai on 2017/1/5.
//  Copyright © 2017年 ren. All rights reserved.
//

#import "UIViewController+ViewControl.h"
#import "Aspects.h"
@implementation UIViewController (ViewControl)

+ (void) load {
    [UIViewController aspect_hookSelector:@selector(viewDidAppear:) withOptions:AspectPositionAfter usingBlock:^(id aspectInfo) {
        NSString *className = NSStringFromClass([[aspectInfo instance] class]);
        NSLog(@"%@", [className stringByAppendingString:@" aspect Method"]);
    } error:nil];
}

@end
