//
//  UIImageView+GIF.m
//  SHBasePro
//
//  Created by shenghai on 2017/3/31.
//  Copyright © 2017年 ren. All rights reserved.
//

#import "UIImageView+GIF.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (GIF)

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder failedImage:(UIImage *)faliedImage options:(SDWebImageOptions)options {
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (error != nil) {
            [self setImage:faliedImage];
        }
    }];
}


//     sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock {
//    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
//}
//
//
//[_loadingImg sd_setImageWithURL:[NSURL URLWithString:@"http://192.168.11.112/aa.png"] placeholderImage:[UIImage sd_animatedGIFWithData:imageData] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
@end
