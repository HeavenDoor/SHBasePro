//
//  UIControl+SequenceClick.h
//  Erp4iOS
//  这个操蛋的东西解决连续点击的问题
//  Created by shenghai on 16/9/10.
//  Copyright © 2016年 成都好房通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (SequenceClick)
@property (nonatomic, assign) NSTimeInterval uxy_acceptEventInterval;   // 可以用这个给重复点击加间隔
@property (nonatomic, assign) NSTimeInterval uxy_acceptedEventTime;
@end
