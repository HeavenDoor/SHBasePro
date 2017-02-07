//
//  UILabel+Tool.h
//  ToucanHealthPlatform
//
//  Created by Mi on 14/12/17.
//  Copyright (c) 2014年 KSCloud.Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(Tool)

/**
 *  字间距
 */
@property (nonatomic, assign)CGFloat characterSpace;

/**
 *  行间距
 */
@property (nonatomic, assign)CGFloat lineSpace;

/**
 *  关键字
 */
@property (nonatomic, copy)NSString *keywords;
@property (nonatomic, strong)UIFont *keywordsFont;
@property (nonatomic, strong)UIColor *keywordsColor;

/**
 *  下划线
 */
@property (nonatomic,copy)NSString *underlineStr;
@property (nonatomic,strong)UIColor *underlineColor;

/**
 *  计算label宽高，必须调用
 *
 *  @param maxWidth 最大宽度
 *
 *  @return label的size
 */
- (CGSize)getLableSizeWithMaxWidth:(CGFloat)maxWidth;

/**
 *  文字颜色字体设置
 *
 *  @param text           需要处理的文字
 *  @param scaleTexts     需要处理字体的文字
 *  @param scaleSize      文字字体大小
 *  @param diffColorTexts 需要处理颜色的文字
 *  @param diffColors     颜色
 */
- (void)setAttrText:(NSString*)text scaleText:(NSArray*)scaleTexts scaleSize:(CGFloat)scaleSize diffColorText:(NSArray*)diffColorTexts diffColors:(NSArray*)diffColors;
/**
 *  文字字体设置
 *
 *  @param text       需要处理的文字
 *  @param scaleTexts 需要处理字体的文字
 *  @param scaleSize  文字字体大小
 */
- (void)setAttrText:(NSString*)text scaleText:(NSArray*)scaleTexts scaleSize:(CGFloat)scaleSize;

/**
 *  文字颜色设置
 *
 *  @param text       需要处理的文字
 *  @param scaleTexts 需要处理颜色的文字
 *  @param color      文字颜色
 */
- (void)setAttributedColor:(NSString*)text scaleText:(NSArray*)scaleTexts color:(UIColor*)color;

/**
 *  文字颜色设置
 *
 *  @param text       需要处理的文字
 *  @param scaleTexts 需要处理颜色的文字
 *  @param color      文字颜色
 */
- (void)setAttributedColor:(NSString*)text scaleText:(NSArray*)scaleTexts color:(UIColor*)color scaleSize:(CGFloat)scaleSize;

@end

@interface UIImage(Tool)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
