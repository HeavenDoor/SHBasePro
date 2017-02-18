//
//  NSTimer+Block.m
//  NSTimer+Block
//
//  Created by develop on 18/2/17.
//  Copyright (c) 2017年 shenghai. All rights reserved.
//

#import "NSTimer+Block.h"

@implementation NSTimer (Block)

static char eventKey;


+ (instancetype)handleTimerInterval:(NSTimeInterval)ti repeats:(BOOL)repeat withBlock:(void (^)())action {
    
    NSTimer *timer = [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(callActionBlock:) userInfo:nil repeats:repeat];
    objc_setAssociatedObject(self, &eventKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return timer;
}

+ (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &eventKey);
    if (block) {
        block();
    }
}

@end
