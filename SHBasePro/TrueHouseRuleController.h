//
//  TrueHouseRuleController.h
//  SHBasePro
//  真房源规则页面
//  Created by shenghai on 16/7/5.
//  Copyright © 2016年 ren. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AgreeBlock)(void);
typedef void(^RejectBlock)(void);

@interface TrueHouseRuleController : UIViewController

@property (nonatomic,copy) AgreeBlock agreeBlock;
@property (nonatomic,copy) RejectBlock rejectBlock;
@end
