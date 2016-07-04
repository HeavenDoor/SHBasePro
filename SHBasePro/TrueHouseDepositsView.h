//
//  TrueHouseDepositsView.h
//  Erp4iOS
//  点亮真房源 弹出提示交保证金界面
//  Created by shenghai on 16/6/20.
//  Copyright © 2016年 成都好房通科技有限公司. All rights reserved.
//


#import <UIKit/UIKit.h>

#define kColor(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]


// 关闭按钮
typedef void(^closeBlock)(void);
// 点亮按钮
typedef void(^lightBlock)(void);

@interface TrueHouseDepositsView : UIView


//关闭按钮block
@property (nonatomic, copy) closeBlock closeButtonBlock;
//点亮按钮block
@property (nonatomic, copy) lightBlock lightButtonBlock;

// 关闭block
- (void) perFormCloseAction: (closeBlock) block;

// 点亮block
- (void) perFormLightAction: (lightBlock) block;
@end
