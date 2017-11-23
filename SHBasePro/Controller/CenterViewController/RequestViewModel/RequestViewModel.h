/*******************************************************************************
 # File        : RequestViewModel.h
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/9/12
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
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RequestViewModel : NSObject <UITableViewDataSource>

// 请求命令
@property (nonatomic, strong, readonly) RACCommand *reuqesCommand;

//模型数组
@property (nonatomic, strong) NSArray *models;

@end

@interface Book : NSObject

@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *title;


@end
