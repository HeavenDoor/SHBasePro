//
//  BaseViewController.h
//  SHBasePro
//
//  Created by shenghai on 16/9/2.
//  Copyright © 2016年 ren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, copy) void(^userDefineBlock)();
@end
