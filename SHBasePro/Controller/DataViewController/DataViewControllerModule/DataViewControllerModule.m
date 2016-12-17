//
//  DataViewControllerModule.m
//  SHBasePro
//
//  Created by shenghai on 2016/12/15.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "DataViewControllerModule.h"
#import "DataViewController.h"
@implementation DataViewControllerModule

+ (void) load {
    JSObjectionInjector *injector = [JSObjection defaultInjector]; // [1]
    injector = injector ? : [JSObjection createInjector]; // [2]
    injector = [injector withModule:[[self alloc] init]]; // [3]
    [JSObjection setDefaultInjector:injector];
}

- (void)configure
{
    [self bindClass:[DataViewController class] toProtocol:@protocol(DataViewControllerProtocol)];
}
@end
