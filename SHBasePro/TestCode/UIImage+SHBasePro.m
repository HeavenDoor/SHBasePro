//
//  UIImage+SHBasePro.m
//  SHBasePro
//
//  Created by shenghai on 2016/12/31.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "UIImage+SHBasePro.h"
#import <objc/runtime.h>

@implementation UIImage (SHBasePro)

+ (void) load {
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        BOOL isAdd;
        Method origMethod = class_getInstanceMethod([self class], @selector(initWithContentsOfFile:));
        Method newMethod = class_getInstanceMethod([self class], @selector(newInitWithContentsOfFile:));
        
        isAdd = class_addMethod(self, @selector(initWithContentsOfFile:), method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, @selector(newInitWithContentsOfFile:), method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
        }else{
            //否则，交换两个方法的实现
            method_exchangeImplementations(origMethod, newMethod);
        }
        
        method_exchangeImplementations(origMethod, newMethod);
        
        
        Class clazz = object_getClass((id)self);
        
        SEL origSel = @selector(imageNamed:);
        SEL newSel = @selector(newImageNamed:);
        Method origMethod1 = class_getClassMethod(clazz, origSel);
        Method newMethod1 = class_getClassMethod(clazz, newSel);
        
        isAdd = class_addMethod(clazz, origSel, method_getImplementation(newMethod1), method_getTypeEncoding(newMethod1));
        if (isAdd) {
            class_replaceMethod(clazz, newSel, method_getImplementation(origMethod1), method_getTypeEncoding(origMethod1));
        }
        else {
            method_exchangeImplementations(origMethod1, newMethod1);
        }
    });
}

- (nullable instancetype)newInitWithContentsOfFile:(NSString *)path {
    UIImage* image = [UIImage imageNamed:@"查看全景图"];
    return image;
}

+ (nullable UIImage *)newImageNamed:(NSString *)name {
    UIImage* image = [UIImage newImageNamed:@"yinhao_"];
    return image;
}
@end
