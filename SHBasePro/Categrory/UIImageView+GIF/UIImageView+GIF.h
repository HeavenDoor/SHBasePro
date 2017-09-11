//
//  UIImageView+GIF.h
//  SHBasePro
//
//  Created by shenghai on 2017/3/31.
//  Copyright © 2017年 ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GIF)

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder failedImage:(UIImage *)faliedImage options:(SDWebImageOptions)options;

@end
