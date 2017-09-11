/*******************************************************************************
 # File        : GModel.h
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/5/22
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

@interface GModel : NSObject <NSCopying>

@property (nonatomic, copy) NSString *aPro;
@property (nonatomic, copy) NSString *bPro;

- (void)test;
@end
