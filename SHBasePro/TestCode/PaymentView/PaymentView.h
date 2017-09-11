//
//  PaymentView.h
//  HaofangLinkage
//
//  Created by shenghai on 2017/2/6.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//  支付宝和微信选择界面

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PaymentType) {
    PaymentTypeAliPay = 0,  // 支付宝支付
    PaymentTypeWeChat = 1, // 微信支付
};

@interface PaymentView : UIView

@property(nonatomic, copy) void(^payMentSelectBlock)(PaymentType type);

@end
