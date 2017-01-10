//
//  TestViewController.m
//  SHBasePro
//
//  Created by shenghai on 16/8/10.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController()
@property (nonatomic, strong) UIButton* sayHelloButton;
@property (nonatomic, strong) UIButton* sayShenghaiButton;
@end
@implementation TestViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColor(200, 200, 200);
    self.sayHelloButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, 200, 100, 50)];
    self.sayHelloButton.backgroundColor = [UIColor redColor];
    self.sayHelloButton.layer.cornerRadius = 8.0;
    [self.sayHelloButton setTitle: @"sayHello" forState:UIControlStateNormal];
    [self.sayHelloButton addTarget:self action:@selector(sayHello) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sayHelloButton];
    
    
    self.sayShenghaiButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, 400, 100, 50)];
    self.sayShenghaiButton.backgroundColor = [UIColor redColor];
    self.sayShenghaiButton.layer.cornerRadius = 8.0;
    [self.sayShenghaiButton setTitle: @"sayShenghai" forState:UIControlStateNormal];
    [self.sayShenghaiButton addTarget:self action:@selector(sayShenghai) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sayShenghaiButton];
    [self.view addSubview: [self genView]];
}

- (UIView *)genView
{
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 150 - 64, SCREEN_WIDTH, 150)];
    
    view.backgroundColor = RGBA(0, 0, 255, 0.5);
    return view;
}

- (void) sayHello
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"sayHello" message:@"sayHello clicked" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void) sayShenghai
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"sayShenghai" message:@"sayShenghai clicked" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    //[self.view addSubview: [self genView]];
}
@end
