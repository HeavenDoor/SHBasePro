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
    JSObjectionInjector *injector = [JSObjection defaultInjector];
    injector = injector ? : [JSObjection createInjector];
    injector = [injector withModule:[[self alloc] init]];
    [JSObjection setDefaultInjector:injector];
}

- (void)configure
{
    [self bindClass:[DataViewController class] toProtocol:@protocol(DataViewControllerProtocol)];
}
@end
