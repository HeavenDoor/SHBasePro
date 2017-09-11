/*******************************************************************************
 # File        : PayResultReverter.h
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

#import <Foundation/Foundation.h>
#import "PayCenterProtocol.h"

@interface PayResultReverter : NSObject

- (instancetype)initWithOutTradeNumber:(NSString *)outTradeNumber Observer:(id<PayCenterCallBackProtocol>)observer;

/**
 * 根据outTradeNumber查询支付结果
 * 失败重试5次返回结果
 */
- (void)requestPayResult;

@end
