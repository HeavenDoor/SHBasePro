//
//  MongoliaView.m
//  SHBasePro
//  通用蒙层
//  Created by shenghai on 16/9/5.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "MongoliaView.h"

@interface MongoliaView()

@end

@implementation MongoliaView

#pragma mark 透明度背景
- (instancetype) initWithAlpha: (CGFloat) alpha
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = RGBA(0, 0, 0, alpha);
    }
    return self;
}

#pragma mark 高斯模糊背景
- (instancetype) initWithGaussFuzzy
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return self;
}

@end
