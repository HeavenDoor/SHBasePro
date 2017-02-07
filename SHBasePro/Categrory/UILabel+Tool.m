//
//  UILabel+Tool.m
//  ToucanHealthPlatform
//
//  Created by Mi on 14/12/17.
//  Copyright (c) 2014年 KSCloud.Co.,Ltd. All rights reserved.
//

#import "UILabel+Tool.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>

@implementation UILabel(Tool)

-(CGFloat)characterSpace{
    return [objc_getAssociatedObject(self,_cmd) floatValue];
}

-(void)setCharacterSpace:(CGFloat)characterSpace{
    objc_setAssociatedObject(self, @selector(characterSpace), @(characterSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(CGFloat)lineSpace{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setLineSpace:(CGFloat)lineSpace{
    objc_setAssociatedObject(self, @selector(lineSpace), @(lineSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)keywords{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setKeywords:(NSString *)keywords{
    objc_setAssociatedObject(self, @selector(keywords), keywords, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIFont *)keywordsFont{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setKeywordsFont:(UIFont *)keywordsFont{
    objc_setAssociatedObject(self, @selector(keywordsFont), keywordsFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor *)keywordsColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setKeywordsColor:(UIColor *)keywordsColor{
    objc_setAssociatedObject(self, @selector(keywordsColor), keywordsColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)underlineStr{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setUnderlineStr:(NSString *)underlineStr{
    objc_setAssociatedObject(self, @selector(underlineStr), underlineStr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

-(UIColor *)underlineColor{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setUnderlineColor:(UIColor *)underlineColor{
    objc_setAssociatedObject(self, @selector(underlineColor), underlineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

/**
 *  根据最大宽度计算label宽，高
 *
 *  @param maxWidth 最大宽度
 *
 *  @return size
 */
- (CGSize)getLableSizeWithMaxWidth:(CGFloat)maxWidth{
    
    if (self.text.length != 0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
        [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0,self.text.length)];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.alignment=self.textAlignment;
        paragraphStyle.lineBreakMode=self.lineBreakMode;
        // 行间距
        if(self.lineSpace > 0){
            [paragraphStyle setLineSpacing:self.lineSpace];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,self.text.length)];
        }
        
        // 字间距
        if(self.characterSpace > 0){
            long number = self.characterSpace;
            CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
            [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
            
            CFRelease(num);
        }
        
        //关键字
        if (self.keywords) {
            NSRange itemRange = [self.text rangeOfString:self.keywords];
            if (self.keywordsFont) {
                [attributedString addAttribute:NSFontAttributeName value:self.keywordsFont range:itemRange];
                
            }
            
            if (self.keywordsColor) {
                [attributedString addAttribute:NSForegroundColorAttributeName value:self.keywordsColor range:itemRange];
                
            }
        }
        
        //下划线
        if (self.underlineStr) {
            NSRange itemRange = [self.text rangeOfString:self.underlineStr];
            [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:itemRange];
            if (self.underlineColor) {
                [attributedString addAttribute:NSUnderlineColorAttributeName value:self.underlineColor range:itemRange];
            }
        }
        
        
        
        self.attributedText = attributedString;
        
        //计算方法一
        //计算文本rect，但是发现设置paragraphStyle.lineBreakMode=NSLineBreakByTruncatingTail;后高度计算不准确
        //CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
        
        //计算方法二
        CGSize maximumLabelSize = CGSizeMake(maxWidth, MAXFLOAT);//labelsize的最大值
        CGSize expectSize = [self sizeThatFits:maximumLabelSize];
        
        return expectSize;
    } else {
        return CGSizeZero;
    }
    
}

- (void)setAttrText:(NSString*)text scaleText:(NSArray*)scaleTexts scaleSize:(CGFloat)scaleSize diffColorText:(NSArray*)diffColorTexts diffColors:(NSArray*)diffColors
{
    if (!text) return;
    
    self.text = text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    for (NSString *scaleText in scaleTexts) {
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:scaleSize] range:[text rangeOfString:scaleText]];
    }
    
    for (NSInteger i=0, j  = diffColorTexts.count;i<j;i++) {
        NSString *subStr = [diffColorTexts objectAtIndex:i];
        UIColor *color = [diffColors objectAtIndex:i];
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:[self.text rangeOfString:subStr]];
    }
    
    self.attributedText = attributedString;
}


- (void)setAttrText:(NSString*)text scaleText:(NSArray*)scaleTexts scaleSize:(CGFloat)scaleSize
{
    if (!text) return;
    
    self.text = text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    for (NSString *scaleText in scaleTexts) {
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:scaleSize] range:[text rangeOfString:scaleText]];
    }
    self.attributedText = attributedString;
}

- (void)setAttributedColor:(NSString*)text scaleText:(NSArray*)scaleTexts color:(UIColor*)color
{
    if (!text) return;
    
    self.text = text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    for (NSString *scaleText in scaleTexts) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:[text rangeOfString:scaleText]];
    }
    self.attributedText = attributedString;
}

- (void)setAttr:(CGFloat)lineSpacing scaleColorText:(NSArray*)scaleColorTexts color:(UIColor*)color scaleText:(NSArray*)scaleTexts scaleSize:(CGFloat)scaleSize
{
    if (!self.text) return;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    for (NSString *scaleText in scaleColorTexts) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:[self.text rangeOfString:scaleText]];
    }
    self.attributedText = attributedString;
    
    for (NSString *scaleText in scaleTexts) {
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:scaleSize] range:[self.text rangeOfString:scaleText]];
    }
    self.attributedText = attributedString;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0,attributedString.length)];
    self.attributedText = attributedString;
    
    
}

- (void)setAttrText:(NSString*)text diffColorText:(NSArray*)diffColorTexts diffColors:(NSArray*)diffColors
{
    if (!text) return;
    self.text = text;
    if (diffColorTexts.count != diffColors.count || diffColorTexts.count <= 0 || diffColors.count <= 0) {
        return;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    for (int i=0,j=(int)diffColorTexts.count;i<j;i++) {
        NSString *subStr = [diffColorTexts objectAtIndex:i];
        UIColor *color = [diffColors objectAtIndex:i];
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:[self.text rangeOfString:subStr]];
    }
    self.attributedText = attributedString;
}


- (void)setAttributedColor:(NSString*)text scaleText:(NSArray*)scaleTexts color:(UIColor*)color scaleSize:(CGFloat)scaleSize
{
    if (!text) return;
    
    self.text = text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    for (NSString *scaleText in scaleTexts) {
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:[text rangeOfString:scaleText]];
    }
    self.attributedText = attributedString;
    
    for (NSString *scaleText in scaleTexts) {
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:scaleSize] range:[self.text rangeOfString:scaleText]];
    }
    self.attributedText = attributedString;
}


@end

@implementation UIImage(Tool)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
