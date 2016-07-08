//
//  NSAttributedString+XTAttributionSize.m
//  DDGoodRoom
//
//  Created by heyk on 22/4/16.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "NSAttributedString+XTAttributionSize.h"

@implementation NSAttributedString(XTAttributionSize)

- (CGSize)sizeWithWidth:(CGFloat)width {
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size;
}
- (CGSize)sizeWithHeight:(CGFloat)height {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size;
}

@end
