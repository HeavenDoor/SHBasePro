/*******************************************************************************
 # File        : GModel.m
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/5/22
 # Corporation : 成都好房通科技股份有限公司
 # Description :
 Description Logs
 -------------------------------------------------------------------------------
 # Date        : Change Date
 # Author      : Change Author
 # Notes       :
 Change Logs
 ******************************************************************************/

#import "GModel.h"
#import <objc/runtime.h>

@implementation GModel

- (id)copyWithZone:(nullable NSZone *)zone {
    GModel *instance = [GModel allocWithZone:zone];
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [instance setValue:[self valueForKey:name] forKey:name];
    }
    return instance;
}

- (void)test {
    NSLog(@"GModel Test...");
}
    
- (void)ggwp {
    NSLog(@"%@ Test...", @"ggwp");
}
@end
