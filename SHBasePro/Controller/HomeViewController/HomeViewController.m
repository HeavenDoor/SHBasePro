//
//  HomeViewController.m
//  SHBasePro
//
//  Created by mac on 16/8/10.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "HomeViewController.h"
#import "DataViewControllerMVVM.h"

#import "NSObject+ApiServiceProtocol.h"

@interface HomeViewController ()

@property (strong, nonatomic) UIImageView* bgImg;
@property (strong, nonatomic) UIButton* msgBtn;

@property (strong, nonatomic) UIButton* mvvmBtn;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homebg"]];
    self.bgImg.frame = self.view.frame;
    [self.view addSubview:self.bgImg];
    
    
    {
        [self requestGetNetWithUrl:[NSURL URLWithString:@"http://www.baidu.com"] Param:@{@"KEY1": @"sheng", @"KEY2": @"hai"}];
        
        [self requestPostNetWithUrl:[NSURL URLWithString:@"http://www.baidu.com"] Param:@{@"KEY1": @"sheng", @"KEY2": @"hai"}];
    }
    
    
    self.msgBtn = [[UIButton alloc] init];
    self.msgBtn.backgroundColor = [UIColor grayColor];
    self.msgBtn.layer.borderWidth = 1;
    self.msgBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.msgBtn.layer.cornerRadius = 4;
    [self.msgBtn setTitle:@"objection" forState:UIControlStateNormal];
    [self.msgBtn addTarget:self action:@selector(objectionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.msgBtn];
    [self.msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).multipliedBy(0.5);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(@130);
        make.height.mas_equalTo(@75);
    }];
    self.msgBtn.enabled = NO;
    
    self.mvvmBtn = [[UIButton alloc] init];
    self.mvvmBtn.backgroundColor = [UIColor grayColor];
    self.mvvmBtn.layer.borderWidth = 1;
    self.mvvmBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.mvvmBtn.layer.cornerRadius = 4;
    [self.mvvmBtn setTitle:@"MVVM" forState:UIControlStateNormal];
    [self.mvvmBtn addTarget:self action:@selector(mvvmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.mvvmBtn];
    [self.mvvmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).multipliedBy(1.5);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(@130);
        make.height.mas_equalTo(@75);
    }];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) objectionAction: (UIButton*) sender {
    UIViewController <DataViewControllerProtocol> *tagsViewController = [[JSObjection defaultInjector] getObject:@protocol(DataViewControllerProtocol)];
    tagsViewController.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:tagsViewController animated:YES];
}

- (void) mvvmAction: (UIButton*) sender {
    DataViewControllerMVVM* mvvmVC = [[DataViewControllerMVVM alloc] init];
    [self.navigationController pushViewController:mvvmVC animated:YES];
}

@end
