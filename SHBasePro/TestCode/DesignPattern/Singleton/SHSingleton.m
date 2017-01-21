//
//  SHSingleton.m
//  SHBasePro
//
//  Created by shenghai on 2017/1/17.
//  Copyright © 2017年 ren. All rights reserved.
//

#import "SHSingleton.h"

static SHSingleton *instance = nil;
@implementation SHSingleton


+ (id)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SHSingleton alloc] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            NSLog(@"allocWithZone");
        }
    });
    return instance;
}
@end
