//
//  UIImageView+Tool.h
//  UUHaoFang
//
//  Created by 正合适 on 16/6/5.
//  Copyright © 2016年 heyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Tool)
/**
 *  图片适应view，防止拉伸压缩
 *
 *  @param origionImageView 原始的ImageView
 */
+ (void)scaleImageToFitWithImageView:(UIImageView *)origionImageView;
@end
