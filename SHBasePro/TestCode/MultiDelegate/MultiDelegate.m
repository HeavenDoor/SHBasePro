/*******************************************************************************
 # File        : MultiDelegate.m
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/8/15
 # Corporation : 成都好房通科技股份有限公司
 # Description :
 <#Description Logs#>
 -------------------------------------------------------------------------------
 # Date        : <#Change Date#>
 # Author      : <#Change Author#>
 # Notes       :
 <#Change Logs#>
 ******************************************************************************/

#import "MultiDelegate.h"

@interface MultiDelegate ()

@end

@implementation MultiDelegate

- (instancetype)init {
    if (self = [super init]) {
        _delegates = [NSPointerArray weakObjectsPointerArray];
    }
    return self;
}

- (void)addDelegate:(id)delegate {
    [_delegates addPointer:(__bridge void*)delegate];
}

- (void)removeDelegate:(id)delegate {
    NSUInteger index = [self indexOfDelegate:delegate];
    if (index != NSNotFound) {
        [_delegates removePointerAtIndex:index];
    }
    [_delegates compact];
}

- (NSUInteger)indexOfDelegate:(id)delegate {
    for (NSUInteger i = 0; i < _delegates.count; i += 1) {
        if ([_delegates pointerAtIndex:i] == (__bridge void*)delegate) {
            return i;
        }
    }
    return NSNotFound;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    for (id delegate in _delegates) {
        if (delegate && [delegate respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (signature) {
        return signature;
    }
    [_delegates compact];
    for (id delegate in _delegates) {
        if (!delegate) {
            continue;
        }
        signature = [delegate methodSignatureForSelector:aSelector];
        if (signature) {
            break;
        }
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    BOOL responded = NO;
    for (id delegate in _delegates) {
        if (delegate && [delegate respondsToSelector:selector]) {
            [anInvocation invokeWithTarget:delegate];
            responded = YES;
        }
    }
    if (!responded) {
        [self doesNotRecognizeSelector:selector];
    }
}


@end
