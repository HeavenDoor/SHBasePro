//
//  NSObject+RunTime.m
//  SHBasePro
//
//  Created by shenghai on 2017/1/6.
//  Copyright © 2017年 ren. All rights reserved.
//

#import "NSObject+RunTime.h"
#import <objc/runtime.h>

const static NSString* strKey = @"addStringKEY";
const static NSString* blockKey = @"addBlockKEY";

@implementation NSObject (RunTime)

- (NSString*) addString {
    return objc_getAssociatedObject(self, &strKey);
}

- (void) setAddString:(NSString *)addString {
    objc_setAssociatedObject(self, &strKey, addString, OBJC_ASSOCIATION_COPY);
}

- (void) setAddBlock:(addBlockType)addBlock {
    objc_setAssociatedObject(self, &blockKey, addBlock, OBJC_ASSOCIATION_COPY);
}

- (addBlockType) addBlock {
    return objc_getAssociatedObject(self, &blockKey);
}
@end
