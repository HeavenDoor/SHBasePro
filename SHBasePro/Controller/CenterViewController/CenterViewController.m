//
//  CenterViewController.m
//  SHBasePro
//
//  Created by shenghai on 16/9/2.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "CenterViewController.h"
#import "masonry.h"
@interface CenterViewController()
@property (nonatomic, strong) UIView* centerview;
@property (nonatomic, strong) UIButton* btn;
@end
@implementation CenterViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    self.centerview = [[UIView alloc] init];
    self.centerview.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.centerview];
    [self.centerview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.view.mas_top).offset(150);
        make.height.mas_equalTo(@200);
    }];
    
    self.btn = [[UIButton alloc] init];
    self.btn.backgroundColor = [UIColor whiteColor];
    [self.centerview addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.centerview.mas_centerX);
        make.centerY.equalTo(self.centerview.mas_centerY);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@50);
    }];
    
    [self.btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) btnClicked: (UIButton*) btn
{
    [self.centerview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.top.equalTo(self.view.mas_top).offset(150);
        make.height.mas_equalTo(self.centerview.height + 20);
    }];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

@end
