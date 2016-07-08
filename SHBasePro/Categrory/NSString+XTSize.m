//
//  NSString+XTAttributionSize.m
//  DDGoodRoom
//
//  Created by heyk on 22/4/16.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import "NSString+XTSize.h"

@implementation NSString(XTSize)

- (CGSize)sizeWithFont:(UIFont *)font byWidth:(CGFloat)width {
    NSStringDrawingOptions optional = NSStringDrawingUsesLineFragmentOrigin;
    
    CGSize size = CGSizeMake(width,CGFLOAT_MAX);
    
    NSDictionary *dic=@{NSFontAttributeName: font};
    
    CGRect labelsize =  [self boundingRectWithSize:size
                                           options:optional
                                        attributes:dic
                                           context:nil];
    
    return labelsize.size;
}

- (CGSize)sizeWithFont:(UIFont *)font byHeight:(CGFloat)height {
    NSStringDrawingOptions optional = NSStringDrawingUsesLineFragmentOrigin;
    
    CGSize size = CGSizeMake(CGFLOAT_MAX,height);
    NSDictionary *dic=@{NSFontAttributeName:font};
    
    CGRect labelsize =  [self boundingRectWithSize:size
                                           options:optional
                                        attributes:dic
                                           context:nil];
    
    return labelsize.size;
}

+ (BOOL)isStringA:(NSString *)stringA InStringB:(NSString *)stringB {
    NSRange kRange = [stringB rangeOfString:stringA];
    if (kRange.location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}


@end
