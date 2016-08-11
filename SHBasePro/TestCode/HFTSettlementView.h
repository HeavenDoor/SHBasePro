//
//  HFTSettlementView.h
//  Erp4iOS
//  IM结算界面
//  Created by shenghai on 16/8/10.
//  Copyright © 2016年 成都好房通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SettlementStatus) {
    SettlementStatus_PrePare = 0,
    SettlementStatus_Finish = 1,
};
@interface HFTSettlementView : UIView
@property (nonatomic, assign) SettlementStatus settleStatus;

- (instancetype) initWithFrame:(CGRect)frame andCaseType: (NSString*) caseType;
@end
