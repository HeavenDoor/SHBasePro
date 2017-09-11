/*******************************************************************************
 # File        : ParamsGenerator.h
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/3/27
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

@interface ParamsGenerator : NSObject <PayRequester>

- (instancetype)initWithObserver:(id<PayCenterParamsProtocol>)observer;

@end

