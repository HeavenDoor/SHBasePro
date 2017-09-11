//
//  PayParams.h
//  SHBasePro
//
//  Created by shenghai on 2017/3/27.
//  Copyright © 2017年 ren. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef PayParams_h
#define PayParams_h

extern NSString * const kAliPayOutTradeNo;  // 支付宝外部交易号
extern NSString * const kAliPayProductName; // 支付宝商品名称
extern NSString * const kAliPayPayAmount;   // 支付宝金额
extern NSString * const kAliPayNotifyURL;   // 支付宝回调地址
extern NSString * const kAliPayBody;        // 支付宝body 一般不需要 和商品名称一致即可
extern NSString * const kAliPayParamCheckFaile;  // 支付宝支付传入参数缺失

extern NSString * const kWeChatPayPayAmount;        // 微信支付金额
extern NSString * const kWeChatPayParamCheckFaile;  // 微信支付传入参数缺失
#endif /* PayParams_h */
