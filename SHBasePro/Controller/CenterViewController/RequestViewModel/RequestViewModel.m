/*******************************************************************************
 # File        : RequestViewModel.m
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

#import "RequestViewModel.h"
#import <AFNetworking.h>

@interface RequestViewModel ()




@end

@implementation RequestViewModel


- (instancetype)init
{
    if (self = [super init]) {
        
        [self initialBind];
    }
    return self;
}


- (void)initialBind {
    _reuqesCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *requestSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            parameters[@"q"] = @"基础";
            
            // 发送请求
            [[AFHTTPSessionManager manager] POST:@"https://api.douban.com/v2/book/search" parameters:parameters  progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [subscriber sendNext:responseObject];
                
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
            }];
            return nil;
        }];
        // 在返回数据信号时，把数据中的字典映射成模型信号，传递出去
        return [requestSignal map:^id(NSDictionary *value) {
            NSMutableArray *dictArr = value[@"books"];
            // 字典转模型，遍历字典中的所有元素，全部映射成模型，并且生成数组
            NSArray *modelArr = [[dictArr.rac_sequence map:^id(id value) {
                Book *book = [Book new];
                book.title = [value objectForKey:@"title"];
                book.subtitle = [value objectForKey:@"summary"];
                return book;//[Book bookWithDict:value];
            }] array];
            
            return modelArr;
        }];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    Book *book = self.models[indexPath.row];
    cell.detailTextLabel.text = book.subtitle;
    cell.textLabel.text = book.title;
    
    return cell;
}

@end


@implementation Book

@end
