//
//  TestViewController+BT.m
//  SHBasePro
//
//  Created by shenghai on 2017/5/25.
//  Copyright © 2017年 ren. All rights reserved.
//

#import "TestViewController+BT.h"
#import "HFTNavigationProtocol.h"

@implementation TestViewController (BT)


+ (BOOL)Bgl_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),
                                   class_getInstanceMethod(self, altSel));
    return YES;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self Bgl_swizzleMethod:@selector(test) withMethod:@selector(gl_BTTest)];
    });
}

- (void)gl_BTTest {
    NSLog(@"gl_BTTest test ...");
    if ([self conformsToProtocol:@protocol(HFTNavigationProtocol)]) {
        //NSLog(@"gl_BTTest test ...");
    }
    //[self gl_BTTest];
}

- (void)backLastView {
    if ([self respondsToSelector:@selector(backAction)]) {
        [self performSelector:@selector(backAction)];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
