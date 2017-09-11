/*******************************************************************************
 # File        : PayResultReverter.m
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/3/28
 # Corporation : 成都好房通科技股份有限公司
 # Description :
 Description Logs
 -------------------------------------------------------------------------------
 # Date        : Change Date
 # Author      : Change Author
 # Notes       :
 Change Logs
 ******************************************************************************/

#import "PayResultReverter.h"

@interface PayResultReverter ()

@property (nonatomic, copy) NSString *outTradeNumber;
@property (nonatomic, weak) id<PayCenterCallBackProtocol> observer;
@property (nonatomic, assign) NSInteger requestCount;
@end

@implementation PayResultReverter

- (instancetype)initWithOutTradeNumber:(NSString *)outTradeNumber Observer:(id<PayCenterCallBackProtocol>)observer {
    self = [super init];
    _observer = observer;
    _requestCount = 0;
    _outTradeNumber = outTradeNumber;
    [self requestPayResult];
    return self;
}

/**
 * 根据outTradeNumber查询支付结果
 * 失败重试5次返回结果
 */
- (void)requestPayResult {
    //[request: outTradeNumber]
    // success
    if (1) {
        [_observer WeChatPayCallBackSuccess];
    } else {
        [_observer callWeChatPayCallBackFaile:@"微信支付失败"];
    }
    
    // faile
    if (_requestCount == 5) {
        [_observer callWeChatPayCallBackFaile:@"微信支付失败"];
    } else {
        _requestCount++;
        [self callRequestPayResult];
    }
}

- (void)callRequestPayResult {
    [self performSelector:@selector(requestPayResult) withObject:nil afterDelay:1];
}

@end
