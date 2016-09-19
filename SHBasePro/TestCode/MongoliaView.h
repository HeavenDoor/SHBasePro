//
//  MongoliaView.h
//  SHBasePro
//
//  Created by shenghai on 16/9/5.
//  Copyright © 2016年 ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MongoliaView : UIView

#pragma mark 透明度背景
- (instancetype) initWithAlpha: (CGFloat) alpha;

#pragma mark 高斯模糊背景
- (instancetype) initWithGaussFuzzy;

@end
