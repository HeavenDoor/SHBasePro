/*******************************************************************************
 # File        : PayCenter.h
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

#import <Foundation/Foundation.h>
#import "PayCenterProtocol.h"

@interface PayCenter : NSObject <PayCenterInterfaceProtocol, PayCenterCallBackProtocol, PayCenterParamsProtocol>

// to call PayCenterInterfaceProtocol interface

@end

