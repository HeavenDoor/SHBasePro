//
//  ObjectionProtocol.h
//  SHBasePro
//
//  Created by shenghai on 2016/12/17.
//  Copyright © 2016年 ren. All rights reserved.
//

#ifndef ObjectionProtocol_h
#define ObjectionProtocol_h

@protocol ApiServiceProtocol <NSObject>

- (void) requestNetWithUrl: (NSURL*) url Param: (NSDictionary*) param;

@end

@protocol ApiService <ApiServiceProtocol>

@end


#endif /* ObjectionProtocol_h */
