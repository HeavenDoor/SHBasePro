//
//  NSTimer+Block.h
//  NSTimer+Block
//
//  Created by develop on 18/2/17.
//  Copyright (c) 2017年 shenghai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^ActionBlock)();

@interface NSTimer (Block)

/**
 *  Timert添加block
 *
 *  @param ti 时间
 *  @param repeat 重复
 *  @param action block代码
 */
+ (instancetype)handleTimerInterval:(NSTimeInterval)ti repeats:(BOOL)repeat withBlock:(ActionBlock)action;


@end
