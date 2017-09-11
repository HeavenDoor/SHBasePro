/*******************************************************************************
 # File        : MultiDelegate.h
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

#import <Foundation/Foundation.h>

@interface MultiDelegate : NSObject

@property (nonatomic, readonly) NSPointerArray *delegates;

- (void)addDelegate:(id)delegate;

- (void)removeDelegate:(id)delegate;

@end
