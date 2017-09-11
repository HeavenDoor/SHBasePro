//
//  UIImageView+Tool.m
//  UUHaoFang
//
//  Created by 正合适 on 16/6/5.
//  Copyright © 2016年 heyk. All rights reserved.
//

#import "UIImageView+Tool.h"


@implementation UIImageView (Tool)
+ (void)scaleImageToFitWithImageView:(UIImageView *)origionImageView {
    [origionImageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
    origionImageView.contentMode = UIViewContentModeScaleAspectFill;
}

@end
