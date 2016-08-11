//
//  NSString+XTAttributionSize.h
//  DDGoodRoom
//
//  Created by heyk on 22/4/16.
//  Copyright © 2016年 Mi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(XTSize)

- (CGSize)sizeWithFont:(UIFont *)font byWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font byHeight:(CGFloat)height;

/**
 *  判断字符A是否在字符B中
 *
 *  @param stringA 字符A
 *  @param stringB 字符B
 *
 *  @return Yes：存在；No：不存在。
 */
+ (BOOL)isStringA:(NSString *)stringA InStringB:(NSString *)stringB;
@end
