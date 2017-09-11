//
//  GModel+ATest.m
//  SHBasePro
//
//  Created by shenghai on 2017/5/25.
//  Copyright © 2017年 ren. All rights reserved.
//

#import "GModel+ATest.h"

@implementation GModel (ATest)


+ (BOOL)gl_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel {
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
        [self gl_swizzleMethod:@selector(test) withMethod:@selector(gl_ATest)];
    });
}

- (void)gl_ATest {
    NSLog(@"GModel+ATest");
}


@end
