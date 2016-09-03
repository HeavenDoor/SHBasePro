//
//  DataModelRequest.h
//  SHBasePro
//
//  Created by shenghai on 16/9/3.
//  Copyright © 2016年 ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModelRequest : NSObject
+ (void) requestVMovieList: (NSString*) startPage succeedBlock: (SuccessfulBlock) succeedBlock failerBlock: (FalieBlock) faileBlock;
@end
