/*******************************************************************************
 # File        : MapParamsGenerator.m
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/3/27
 # Corporation : 成都好房通科技股份有限公司
 # Description : MAP XXX 页面 支付参数生成器
 Description Logs
 -------------------------------------------------------------------------------
 # Date        : Change Date
 # Author      : Change Author
 # Notes       :
 Change Logs
 ******************************************************************************/

#import "MapParamsGenerator.h"

@interface MapParamsGenerator ()

@property (nonatomic, weak) id<PayCenterParamsProtocol> observer;

@end

@implementation MapParamsGenerator

- (void)dealloc {
    NSLog(@"=====%@被销毁了=====", [self class]);
}

- (instancetype)initWithObserver:(id<PayCenterParamsProtocol>)observer {
    self = [super init];
    _observer = observer;
    return self;
}

- (void)requestAliPayParam:(NSDictionary *)payParam {
    
}

- (void)requestWeChatPayParam:(NSDictionary *)payParam {
    
}

- (BOOL)checkAliPayParams:(NSDictionary *)payParam {
    
    return YES;
}

- (BOOL)checkWeChatPayParams:(NSDictionary *)payParam {
    
    return YES;
}

@end
