//
//  HomeViewController.m
//  SHBasePro
//
//  Created by mac on 16/8/10.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "HomeViewController.h"
//#import "DataViewController.h"

#import "NSObject+ApiServiceProtocol.h"

@interface HomeViewController ()

@property (strong, nonatomic) UIImageView* bgImg;
@property (strong, nonatomic) UIButton* msgBtn;
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
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@100);
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
    //JSObjectionInjector* injector = [JSObjection defaultInjector];
    //UIViewController<DataViewControllerProtocol>* dataVC = [injector getObject:@protocol(DataViewControllerProtocol)];
    
    UIViewController <DataViewControllerProtocol> *tagsViewController = [[JSObjection defaultInjector] getObject:@protocol(DataViewControllerProtocol)];
    tagsViewController.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:tagsViewController animated:YES];
}

@end
