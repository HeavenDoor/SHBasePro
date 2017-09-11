/*******************************************************************************
 # File        : PayCenter.m
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/3/27
 # Corporation : 成都好房通科技股份有限公司
 # Description : 支付中心  处理支付宝微信支付流程
 Description Logs
 -------------------------------------------------------------------------------
 # Date        : Change Date
 # Author      : Change Author
 # Notes       :
 Change Logs
 ******************************************************************************/

#import "PayCenter.h"
//#import "WXApi.h"
//#import "AlipayRequestConfig.h"
#import "AppDelegate.h"

#import <objc/runtime.h>
#import "PayResultReverter.h"

NSString * const kAliPayOutTradeNo  = @"kAliPayOutTradeNo";
NSString * const kAliPayProductName = @"kAliPayProductName";
NSString * const kAliPayPayAmount   = @"kAliPayPayAmount";
NSString * const kAliPayNotifyURL   = @"kAliPayNotifyURL";
NSString * const kAliPayBody        = @"kAliPayBody";
NSString * const kAliPayParamCheckFaile        = @"kAliPayParamCheckFaile";

NSString * const kWeChatPayPayAmount   = @"kWeChatPayPayAmount";
NSString * const kWeChatPayParamCheckFaile        = @"kWeChatPayParamCheckFaile";

NSString * const kRequestedOutTradeNo = @"kRequestedOutTradeNo";

@interface PayCenter ()

//@property (nonatomic, strong) NSPointerArray *delegates;  //<id<PayCenterProtocol>> 这中写法貌似没用
@property (nonatomic, weak) id<PayCenterProtocol> delegate;

@end

@implementation PayCenter

#pragma mark - PayCenterInterfaceProtocol 支付模块通用接口

/**获取全局PayCenter实例*/
+ (instancetype)sharedPayCenter {
    return (PayCenter*)[[AppDelegate sharedInstance] payCenter];
}

- (void)setPayCenterDelegate:(id<PayCenterProtocol>)delegate {
    _delegate = delegate;
}

/**接口测试代码*/
- (void)testGgwp {
//    [self maintainDeletes];
//    for (id<PayCenterProtocol> item in _delegates) {
//        if (item != nil) {
//            [item test];
//        }
//    }
    if (_delegate != nil) {
        [_delegate test];
    }
}

///**添加代理*/
//- (void)addDelegate:(id<PayCenterProtocol>)delegate {
//    if (_delegates == nil) {
//        _delegates = [NSPointerArray weakObjectsPointerArray];
//    }
//    
//    [_delegates addPointer:(__bridge void * _Nullable)(delegate)];
//}
//
///**移除代理 在调用者dealloc中调用这个函数貌似没用  没找到原因*/
//- (void)removeDelegate:(id<PayCenterProtocol>)delegate {
//    if (_delegates.count == 0) {
//        return;
//    }
//
//    NSInteger index = 0;
//    for (id<PayCenterProtocol> item in _delegates) {
//        if (item == delegate) {
//            [_delegates removePointerAtIndex:index];
//            break;
//        }
//        index++;
//    }
//}

/**调用支付宝支付*/
- (void)callAliPay:(NSDictionary *)payParam Generator:(id<PayRequester>)generator{
    if (generator == nil || ![generator respondsToSelector:@selector(requestWeChatPayParam:)]) {
        [self callWeChatPayCallBackFaile:@"支付宝支付失败，缺少必要参数"];
        return;
    }
    [generator requestAliPayParam:payParam];
}

/**调用微信支付*/
- (void)callWeChatPay:(NSDictionary *)payParam Generator:(id<PayRequester>)generator{
//    if( [WXApi isWXAppInstalled] == NO ){
//        [self callWeChatPayCallBackFaile:@"请安装微信客户端"];
//        return;
//    }
    if (generator == nil || ![generator respondsToSelector:@selector(requestWeChatPayParam:)]) {
        [self callWeChatPayCallBackFaile:@"微信支付失败，缺少必要参数"];
        return;
    }
    [generator requestWeChatPayParam:payParam];
}

/**微信支付结果没有回调 还原现场*/
- (void)restoreSceneOfWeChatPay {
//    for (id<PayCenterProtocol> item in _delegates) {
//        if (item != nil && [item respondsToSelector:@selector(restoreWeChatPay:)]) {
//            NSString *outTradeNo = objc_getAssociatedObject(item, (__bridge const void *)(kRequestedOutTradeNo));
//            if (outTradeNo.length != 0) {
//                [item restoreWeChatPay:outTradeNo];
//            }
//        }
//    }
//    [self restoreSceneOfWeChatPay];

    if (_delegate != nil/* && [_delegate respondsToSelector:@selector(restoreWeChatPay:)]*/) {
        NSString *outTradeNo = objc_getAssociatedObject(_delegate, (__bridge const void *)(kRequestedOutTradeNo));
        if (outTradeNo.length != 0) {
            PayResultReverter *reverter = [[PayResultReverter alloc] initWithOutTradeNumber:outTradeNo Observer:self];
            [reverter requestPayResult];
        }
    }
    [self removeRequestOutTradeNo];
}

#pragma mark end



#pragma mark - PayCenterParamsProtocol 请求支付参数回调
/**支付宝参数请求回调*/
- (void)requestAliPayParamsResult:(NSDictionary *)payParam {
    [self paramRequstFinish];
    
    NSString *checkResult = [payParam objectForKey:kAliPayParamCheckFaile];
    if (checkResult.length != 0) {
        [self callAliPayFaile:checkResult];
        return;
    }
    NSString *outTradeNumber = [payParam objectForKey:kAliPayOutTradeNo];
    NSString *productName = [payParam objectForKey:kAliPayProductName];
    NSString *payAmount= [payParam objectForKey:kAliPayPayAmount];
    NSString *notifyUrl = [payParam objectForKey:kAliPayNotifyURL];
    NSString *payBody = [payParam objectForKey:kAliPayBody];
    
//    [AlipayRequestConfig alipayWithTradeNO:outTradeNumber productName:productName amount:payAmount notifyURL:notifyUrl body:payBody complete:^(NSDictionary *dictionary) {
//        
//    }];
}

/**微信支付参数请求回调*/
- (void)requestWeChatPayParamsResult:(NSDictionary *)payParam {
    [self paramRequstFinish];
    NSString *checkResult = [payParam objectForKey:kWeChatPayParamCheckFaile];
    if (checkResult.length != 0) {
        [self callWeChatPayCallBackFaile:checkResult];
        return;
    }
    // 用于支付没有回调情况 得到支付外部编号请求服务器用
    [self setRequestOutTradeNo:[payParam objectForKey:@"outTradeNo"]];
    // 正常情况 retcode不存在 也就是nil
    NSMutableString *retcode = [payParam objectForKey:@"retcode"];
    if (retcode.intValue == 0){
//        //调起微信支付
//        PayReq* req             = [[PayReq alloc] init];
//        req.partnerId           = [payParam objectForKey:@"partnerId"];
//        req.prepayId            = [payParam objectForKey:@"prepayId"];
//        req.nonceStr            = [payParam objectForKey:@"nonceStr"];
//        req.timeStamp           = [[payParam objectForKey:@"timeStamp"] integerValue];
//        req.package             = [payParam objectForKey:@"package"];
//        req.sign                = [payParam objectForKey:@"sign"];
//
//        [WXApi sendReq:req];
        //日志输出
        //NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[payParam objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
    } else {
        NSString *errorMsg = [payParam objectForKey:@"retmsg"];
        if (errorMsg.length == 0) {
            errorMsg = [NSString stringWithFormat:@"请求微信订单失败 retcode %@", retcode];
        }
        [self callWeChatPayCallBackFaile:errorMsg];
    }
}
#pragma mark end




#pragma mark - PayCenterCallBackProtocol 支付成功失败回调
/**支付宝支付回调 aliPayResult*/
- (void)aliPayCallBack:(NSDictionary *)aliPayResult {
    if (![aliPayResult[@"resultStatus"] isEqualToString:@"9000"]) {
        [self callAliPayFaile:@"支付失败"];
        return;
    }

    // 切割字符串
    NSString *resultStr = [aliPayResult objectForKey:@"result"];
    NSArray *resultArray = [resultStr componentsSeparatedByString:@"&"];
    
    NSString* succeedString = @"";
    for (NSString* value in resultArray) {
        if ([value rangeOfString:@"success="].location != NSNotFound) {
            succeedString = value;
        }
    }
    // 没有找到成功标记
    if (succeedString.length == 0) {
        [self callAliPayFaile:@"支付失败"];
        return;
    }
    
    resultArray = [succeedString componentsSeparatedByString:@"="];
    NSLog(@"%@",resultArray);
    resultStr = resultArray[1];
    if ([resultStr isEqualToString:@"\"true\""]) {
        [self callAliPaySuccess];
    }
    else {
        [self callAliPayFaile:@"支付失败"];
    }
}

/**私有方法 aliPay Success*/
- (void)callAliPaySuccess {
    [self callBack:@selector(aliPaySuccess) withObject:nil];
}

/**私有方法aliPay Faile*/
- (void)callAliPayFaile:(NSString *)reason {
    [self callBack:@selector(aliPayFaile:) withObject:reason];
}

/**微信支付成功回调 weChatPay Success*/
- (void)WeChatPayCallBackSuccess {
    [self callBack:@selector(weChatPaySuccess) withObject:nil];
}

/**微信支付失败回调 weChatPay Faile*/
- (void)callWeChatPayCallBackFaile:(NSString *)reason {
    if (reason.length == 0) {
        reason = @"";
    }
    [self callBack:@selector(weChatPayFaile:) withObject:reason];
}
#pragma mark end


/**回调到支付发起者*/
- (void)callBack:(SEL)selector withObject:(id)object{
//    [self maintainDeletes];
//    for (id<PayCenterProtocol> item in _delegates) {
//        if (item != nil && [item respondsToSelector:selector]) {
//            [self removeRequestOutTradeNo];
//            [item performSelector:selector withObject:object];
//        }
//    }
    if (_delegate != nil && [_delegate respondsToSelector:selector]) {
        [self removeRequestOutTradeNo];
        [_delegate performSelector:selector withObject:object];
    }
}

/**用于支付没有回调情况 得到支付外部编号请求服务器用*/
- (void)setRequestOutTradeNo:(NSString *)outTrateNO {
//    for (id<PayCenterProtocol> item in _delegates) {
//        if (item != nil && [item respondsToSelector:@selector(restoreWeChatPay:)]) {
//            objc_setAssociatedObject(item, (__bridge const void *)(kRequestedOutTradeNo), outTrateNO, OBJC_ASSOCIATION_COPY);
//        }
//    }
    if (_delegate != nil && [_delegate respondsToSelector:@selector(restoreWeChatPay:)]) {
        objc_setAssociatedObject(_delegate, (__bridge const void *)(kRequestedOutTradeNo), outTrateNO, OBJC_ASSOCIATION_COPY);
    }
    
}

/**移除未处理的 微信支付外部交易编号*/
- (void)removeRequestOutTradeNo {
//    for (id<PayCenterProtocol> item in _delegates) {
//        if (item != nil && [item respondsToSelector:@selector(restoreWeChatPay:)]) {
//            objc_setAssociatedObject(item, (__bridge const void *)(kRequestedOutTradeNo), nil, OBJC_ASSOCIATION_COPY);
//        }
//    }
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(restoreWeChatPay:)]) {
        objc_setAssociatedObject(_delegate, (__bridge const void *)(kRequestedOutTradeNo), nil, OBJC_ASSOCIATION_COPY);
    }
}

/**支付请求完成，停止转菊花*/
- (void)paramRequstFinish {
//    for (id<PayCenterProtocol> item in _delegates) {
//        if (item != nil && [item respondsToSelector:@selector(paramRequstFinish)]) {
//            [item performSelector:@selector(paramRequstFinish)];
//        }
//    }
    
    if (_delegate != nil && [_delegate respondsToSelector:@selector(paramRequstFinish)]) {
        [_delegate performSelector:@selector(paramRequstFinish)];
    }
}

///**维护delegates数据，将空的代理移除*/
//- (void)maintainDeletes {
//    NSMutableArray *indexArray = [NSMutableArray array];
//    int arrayIndex = 0;
//    for (id<PayCenterProtocol> item in _delegates) {
//        if (item == nil) {
//            [indexArray addObject:[NSNumber numberWithInt:arrayIndex]];
//        }
//        arrayIndex++;
//    }
//    
//    if (indexArray.count == 0) {
//        return;
//    }
//    NSInteger index = indexArray.count - 1;
//    for (; index >= 0; index--) {
//        [_delegates removePointerAtIndex:index];
//    }
//}
@end
