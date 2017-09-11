//
//  CommonDefine.h
//  SHBasePro
//
//  Created by mac on 16/9/4.
//  Copyright © 2016年 ren. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

#define LAZY_WEAK_SELF __weak typeof(self) weakSelf = self
#define LazyWeakSelf LAZY_WEAK_SELF

#define WEAK_TYPES(instance) __weak typeof(instance) weak##instance = instance;
#define WEAK_SELF __weak typeof(self) weakSelf = self;
//IOS7以上或以下版本判断
#define bIsiOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define kColor(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

//---------------------- int型转换为string ----------------------
#define INT_To_STRING(intValue) ([NSString stringWithFormat:@"%d",(int)intValue])
//---------------------- float型转换为string ----------------------
#define FLOAT_To_STRING(floatValue) ([NSString stringWithFormat:@"%.4f",floatValue])

#define kScaleHeight ([UIScreen mainScreen].bounds.size.width / 375.f)

#define kScaleWidth ([UIScreen mainScreen].bounds.size.width / 320.f)

#define kScaleHeights ([UIScreen mainScreen].bounds.size.height / 667.f)

//---------------------- 适配界面时frame缩放比例 ----------------------
#define kUIScaleSize(ScaleSize) ((ScaleSize)*(kScaleWidth>1.0?1.05:(kScaleWidth<1.0?0.95:1.0)))

//---------------------- 适配界面时字体缩放比例 ----------------------
#define kFontScaleSize(ScaleSize) ((ScaleSize)+(kScaleWidth>1.0?1:(kScaleWidth<1.0?-1:0)))

/** 是否为iOS7 */
#define IOS_VER_7 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? YES : NO)

/** 是否为iOS8 */
#define IOS_VER_8 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? YES : NO)

/** 是否为iOS9 */
#define IOS_VER_9 (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? YES : NO)

#define WeChatID @"wxdf8a143ad890459f"
#endif /* CommonDefine_h */
