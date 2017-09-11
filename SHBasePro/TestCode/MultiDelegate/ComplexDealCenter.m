/*******************************************************************************
 # File        : ComplexDealCenter.m
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/8/15
 # Corporation : 成都好房通科技股份有限公司
 # Description :
 <#Description Logs#>
 -------------------------------------------------------------------------------
 # Date        : <#Change Date#>
 # Author      : <#Change Author#>
 # Notes       :
 <#Change Logs#>
 ******************************************************************************/

#import "ComplexDealCenter.h"
#import "MultiDelegate.h"

static ComplexDealCenter *instance = nil;

@interface ComplexDealCenter ()

@property (nonatomic, strong)  MultiDelegate *dealProtocolDelegate;  // dealProtocol类型协议委托

@property (nonatomic, strong)  MultiDelegate *otherProtocolDelegate;  // 其他类型协议委托
@end

@implementation ComplexDealCenter

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ComplexDealCenter alloc] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            NSLog(@"allocWithZone");
        }
    });
    return instance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        _dealProtocolDelegate = [[MultiDelegate alloc] init];
        _otherProtocolDelegate = [[MultiDelegate alloc] init];
    }
    return self;
}

- (void)addDelegate:(id<ComplexDealProtocol>)delegate {
    [_dealProtocolDelegate addDelegate:delegate];
}

- (void)removeDelegate:(id<ComplexDealProtocol>)delegate {
    [_dealProtocolDelegate removeDelegate:delegate];
}

- (void)triggerd:(NSString *)value {
    for (id<ComplexDealProtocol> item in _dealProtocolDelegate.delegates) {
        if (item != nil && [item respondsToSelector:@selector(onComplexEventDealt:)]) {
            [item onComplexEventDealt:value];
        }
    }
}

@end
