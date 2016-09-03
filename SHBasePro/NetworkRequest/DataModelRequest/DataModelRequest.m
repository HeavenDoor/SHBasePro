//
//  DataModelRequest.m
//  SHBasePro
//
//  Created by shenghai on 16/9/3.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "DataModelRequest.h"
#import "MovieModel.h"

@implementation DataModelRequest
+ (void) requestVMovieList: (NSString*) startPage succeedBlock: (SuccessfulBlock) succeedBlock failerBlock: (FalieBlock) failerBlock
{
    NSString* url = @"http://app.vmoiver.com/apiv3/post/getPostByTab";
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    [params setObject:startPage forKey:@"p"];
    [params setObject:@"latest" forKey:@"tab"];
    
    [[HttpManager instance] post:url Params:params SuccessfulBlock:^(id model) {
        MovieDatasModel* responseModel = [model mj_objectWithKeyValues: model];
        EXECUTE_BLOCK(succeedBlock, responseModel.data);
    } FailBlock:^(id model) {
        EXECUTE_BLOCK(failerBlock, @"出错了");
    }];
}
@end
