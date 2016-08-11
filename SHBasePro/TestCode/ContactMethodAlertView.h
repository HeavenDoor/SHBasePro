//
//  ContactMethodAlertView.h
//  UUHaoFang
//
//  Created by 正合适 on 16/7/2.
//  Copyright © 2016年 heyk. All rights reserved.
//
/**
 *  选择联系方式弹框View
 */
#import <UIKit/UIKit.h>

@protocol ContactMethodAlertViewDelegate <NSObject>
@optional
/**
 *  点击按钮Action
 *
 *  @param index 0代表第一个按钮，依次增加
 */
- (void)contactButtonTapedWithIndex:(NSInteger)index;

@end
@interface ContactMethodAlertView : UIView
@property (nonatomic, strong) UIColor *backgroundViewColor;// 背景颜色
@property (nonatomic, assign) BOOL canTapBG;// 背景是否可以点击，默认为yes
@property (nonatomic, weak) id<ContactMethodAlertViewDelegate> delegate;
/**
 *  弹框初始化
 *
 *  @param frame      随便填，都没用
 *  @param imageArray 图片名字，nsstring，不能为空
 *  @param titleArray 按钮标题，nsstring，不能为空
 *
 *  @return 对象
 */
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)imageArray titles:(NSArray *)titleArray;

/**
 *  弹框
 */
- (void)show;
@end
