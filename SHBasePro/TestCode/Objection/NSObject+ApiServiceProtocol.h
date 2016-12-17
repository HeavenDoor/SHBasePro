//
//  NSObject+ApiServiceProtocol.h
//  SHBasePro
//
//  Created by shenghai on 2016/12/17.
//  Copyright © 2016年 ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectionProtocol.h"



@interface NSObject (ApiServiceProtocol)

- (void) requestGetNetWithUrl: (NSURL*) url Param: (NSDictionary*) param;

- (void) requestPostNetWithUrl: (NSURL*) url Param: (NSDictionary*) param;

@end
