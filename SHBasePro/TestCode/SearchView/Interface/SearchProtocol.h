//
//  SearchProtocol.h
//  SHBasePro
//
//  Created by shenghai on 2017/1/10.
//  Copyright © 2017年 ren. All rights reserved.
//

#ifndef SearchProtocol_h
#define SearchProtocol_h

@protocol SearchProtocol <NSObject>

@required
- (void)searchWithKey:(NSString*) key;

@end
#endif /* SearchProtocol_h */
