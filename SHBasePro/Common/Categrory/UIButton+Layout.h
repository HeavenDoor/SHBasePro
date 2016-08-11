//
//  UIButton+Layout.h
//  ChooseCollectionView
//
//  Created by Mi on 16/5/15.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Layout)

-(void)layoutButtonForTitle:(NSString *)title
                  titleFont:(UIFont *)titleFont
                      image:(UIImage *)image
                 gapBetween:(CGFloat)gap
                    layType:(NSInteger)layType;
@end
