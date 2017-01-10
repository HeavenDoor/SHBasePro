//
//  NSObject+RunTime.h
//  SHBasePro
//
//  Created by shenghai on 2017/1/6.
//  Copyright © 2017年 ren. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^addBlockType)(void);
@interface NSObject (RunTime)

@property (nonatomic, copy) NSString* addString;
@property (nonatomic, copy) addBlockType addBlock;
@end
