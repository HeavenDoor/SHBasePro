//
//  NavigationPresenterProtocol.h
//  SHBasePro
//
//  Created by shenghai on 2016/12/20.
//  Copyright © 2016年 ren. All rights reserved.
//

#ifndef NavigationPresenterProtocol_h
#define NavigationPresenterProtocol_h

@protocol NavigationPresenterProtocol <NSObject>

@property (nonatomic, strong) UIViewController* holdVC;
- (void) viewDidLoad;
- (void) viewWillAppear;
- (void) viewDidAppear;
- (void) backBtnPre : (UIButton*) sender;

@end

#endif /* NavigationPresenterProtocol_h */
