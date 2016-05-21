//
//  PhoneVerificationView.h
//  HaofangLinkagePhone
//
//  Created by SL on 16/1/22.
//  Copyright © 2016年 成都好房通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhoneVerificationViewDelegate <NSObject>

- (void)cancelTap;

- (void)sumbitActionWithPhoneNumber:(NSString *)phoneNum;

@end

@interface PhoneVerificationView : UIView

//@property (nonatomic, weak) id <PhoneVerificationViewDelegate> delegate;
- (void)setCustomer:(NSString*) phone;

- (BOOL)keyboardShow;

- (void)keyboardHidden;

@end
