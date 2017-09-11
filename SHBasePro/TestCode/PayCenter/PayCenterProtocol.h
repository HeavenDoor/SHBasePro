//
//  PayCenterProtocol.h
//  SHBasePro
//
//  Created by shenghai on 2017/3/27.
//  Copyright © 2017年 ren. All rights reserved.
//

#ifndef PayCenterProtocol_h
#define PayCenterProtocol_h

@protocol PayRequester, PayCenterProtocol, PayCenterParamsProtocol;


///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 支付模块通用接口
@protocol PayCenterInterfaceProtocol <NSObject>

@optional

/**获取全局PayCenter实例*/
+ (id<PayCenterProtocol, PayCenterInterfaceProtocol, PayCenterParamsProtocol>)sharedPayCenter;

/**测试*/
- (void)testGgwp;

/**调用支付宝支付*/
- (void)callAliPay:(NSDictionary *)payParam Generator:(id<PayRequester>)generator;

/**调用微信支付*/
- (void)callWeChatPay:(NSDictionary *)payParam Generator:(id<PayRequester>)generator;

/**微信支付结果没有回调 还原现场*/
- (void)restoreSceneOfWeChatPay;

/**设置代理*/
- (void)setPayCenterDelegate:(id<PayCenterProtocol>)delegate;

///**添加代理*/
//- (void)addDelegate:(id<PayCenterProtocol>)delegate;
//
///**移除代理*/
//- (void)removeDelegate:(id<PayCenterProtocol>)delegate;

@end

///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 支付结果处理
@protocol PayCenterProtocol <NSObject>

@optional

- (void)test;

/**参数请求完成菊花残*/
- (void)paramRequstFinish;

/**支付宝支付成功回调*/
- (void)aliPaySuccess;

/**支付宝支付失败回调*/
- (void)aliPayFaile:(NSString *)reason;

/**微信支付成功回调*/
- (void)weChatPaySuccess;

/**微信支付失败回调*/
- (void)weChatPayFaile:(NSString *)reason;

///**微信支付结果没有回调 根据outTradeNumber还原现场*/
//- (void)restoreWeChatPay:(NSString *)outTradeNumber;

@end


///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark 支付成功失败回调
@protocol PayCenterCallBackProtocol <NSObject>

//支付宝支付结果回调
/**aliPay CallBack Result*/
- (void)aliPayCallBack:(NSDictionary *)aliPayResult;

//微信支付成功回调
/**weChatPay CallBack Success*/
- (void)WeChatPayCallBackSuccess;

//微信支付失败回调
/**weChatPay CallBack Faile*/
- (void)callWeChatPayCallBackFaile:(NSString *)reason;

@end
#pragma mark end


///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 请求支付参数完成
@protocol PayCenterParamsProtocol <NSObject>

@optional

/**请求支付宝支付参数回调*/
- (void)requestAliPayParamsResult:(NSDictionary *)payParam;

/**请求微信支付参数回调*/
- (void)requestWeChatPayParamsResult:(NSDictionary *)payParam;

@end


///////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 参数请求生成器
@protocol PayRequester <NSObject>

@optional

/**请求支付宝支付参数*/
- (void)requestAliPayParam:(NSDictionary *)payParam;

/**请求微信支付参数*/
- (void)requestWeChatPayParam:(NSDictionary *)payParam;

@end
#endif /* PayCenterProtocol_h */
