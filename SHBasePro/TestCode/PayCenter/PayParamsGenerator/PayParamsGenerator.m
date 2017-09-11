/*******************************************************************************
 # File        : PayParamsGenerator.m
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/3/27
 # Corporation : 成都好房通科技股份有限公司
 # Description : 通用支付参数生成器
 Description Logs
 -------------------------------------------------------------------------------
 # Date        : Change Date
 # Author      : Change Author
 # Notes       :
 Change Logs
 ******************************************************************************/

#import "PayParamsGenerator.h"
#import "PayParams.h"
#import "XMLDictionary.h"

@interface PayParamsGenerator ()
@property (nonatomic, weak) id<PayCenterParamsProtocol> observer;
@end

@implementation PayParamsGenerator

- (void)dealloc {
    NSLog(@"=====%@被销毁了=====", [self class]);
}

- (instancetype)initWithObserver:(id<PayCenterParamsProtocol>)observer {
    self = [super init];
    _observer = observer;
    return self;
}

- (void)requestAliPayParam:(NSDictionary *)payParam {
    if (![self checkAliPayParams:payParam]) {
        [self.observer requestAliPayParamsResult:@{kAliPayParamCheckFaile : @"支付宝传入参数缺失"}];
        return;
    }
    sleep(3);
    LazyWeakSelf;
    //[requestData:data]
    NSString *outTradeNo = @"outTradeNossadss";//[data objectForKey:@"OUT_TRADE_NO"];
    //success:
    NSMutableDictionary *payParams = [NSMutableDictionary dictionary];
    [payParams addEntriesFromDictionary:payParam];
    [payParams setObject:outTradeNo forKey:kAliPayOutTradeNo];
    if (outTradeNo.length == 0) {
        [weakSelf.observer requestAliPayParamsResult:@{kAliPayParamCheckFaile : @"支付宝交易编号请求失败"}];
        return;
    }
    [weakSelf.observer requestAliPayParamsResult:payParams];
    return;
    
    //faile:
    [weakSelf.observer requestAliPayParamsResult:@{kAliPayParamCheckFaile : @"支付宝交易编号请求失败"}];
}

- (void)requestWeChatPayParam:(NSDictionary *)payParam {
    if (![self checkWeChatPayParams:payParam]) {
        [self.observer requestWeChatPayParamsResult:@{kWeChatPayParamCheckFaile : @"微信传入参数缺失"}];
        return;
    }
    sleep(3);
    LazyWeakSelf;
    //[requestData:data]
    //success:
    NSString *responseString = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?><bizdata><timeStamp>1490693560</timeStamp><package>Sign=WXPay</package><outTradeNo>live_10142</outTradeNo><sign>B34CC09D42F67AC24732DBA3E35ACE66</sign><prepayId>wx20170328172946c8fedfcf9e0104172226</prepayId><partnerId>1442024502</partnerId><nonceStr>eU6rU3PBjPzbaXc4lXdRw228ZBTqmLik</nonceStr></bizdata>";
    NSDictionary* dict = [NSDictionary dictionaryWithXMLString:responseString];
    if (dict != nil) {
        [weakSelf.observer requestWeChatPayParamsResult:dict];
        return;
    } else {
        [weakSelf.observer requestWeChatPayParamsResult:@{kWeChatPayParamCheckFaile : @"请求微信订单失败"}];
        return;
    }
    
    //faile:
    [weakSelf.observer requestWeChatPayParamsResult:@{kWeChatPayParamCheckFaile : @"请求微信订单失败"}];
    return;
}

- (BOOL)checkAliPayParams:(NSDictionary *)payParam {
    return YES;
}

- (BOOL)checkWeChatPayParams:(NSDictionary *)payParam {
    return YES;
}


@end
