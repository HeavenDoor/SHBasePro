//
//  AppHelper.m
//  SHBasePro
//
//  Created by shenghai on 16/9/23.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "AppHelper.h"
//#import "JSPatch/JSPatch.h"
//#import "Jspatch/JPEngine.h"

@implementation AppHelper

- (void) startJSPatch {
    WEAK_TYPES(self);
    /*[[HttpManager instance] post:@"http://192.168.0.184/hftMobileWeb/main.js" Params:nil SuccessfulBlock:^(id model) {
        if (model != nil && [model isKindOfClass:[NSString class]] && ![model isEqualToString:@""]) {
            [weakself syncJSPatch: model];
        }
        NSLog(@"%@", [NSThread currentThread]);
    } FailBlock:^(id model) {
        
    }];*/
}

- (void) syncJSPatch: (NSString*) jsValue {
    //[JPEngine evaluateScript:jsValue];
}


@end
