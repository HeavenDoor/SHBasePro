//
//  MineViewController.m
//  SHBasePro
//  我的窗口控制器
//  Created by mac on 16/8/5.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "MineViewController.h"
#import "UIImage+GIF.h"
#import "UIControl+SequenceClick.h"

@interface MineViewController ()
@property (strong, nonatomic) UIImageView* bgImg;
@property (nonatomic, strong) UIButton* sayHelloButton;

@property (strong, nonatomic) UIImageView* kkImageView;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mingbg"]];
    self.bgImg.frame = self.view.frame;
    [self.view addSubview:self.bgImg];
    
    self.view.backgroundColor = kColor(200, 200, 200);
    self.sayHelloButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 50, SCREEN_HEIGHT - 300, 100, 50)];
    self.sayHelloButton.backgroundColor = [UIColor redColor];
    self.sayHelloButton.layer.cornerRadius = 8.0;
    [self.sayHelloButton setTitle: @"sayHello" forState:UIControlStateNormal];
    [self.sayHelloButton addTarget:self action:@selector(sayHello) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sayHelloButton];
    self.sayHelloButton.uxy_acceptEventInterval = 1.5;
    
    UIImage* img = [UIImage sd_animatedGIFNamed:@"yyqiangdan"];
    self.kkImageView = [[UIImageView alloc] initWithFrame: CGRectMake(100, SCREEN_HEIGHT -  200, 50,50)];
    self.kkImageView.image = img;
    [self.view addSubview:self.kkImageView];
    
    
    
//    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
//    effectview.frame = self.bgImg.frame;
//    
//    [self.view addSubview:effectview];
}

- (void) sayHello
{
//    HFTReceivablesView* SettlementView = [[HFTReceivablesView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 125) andCaseType:@"0"];
//    //SettlementView.settleStatus = SettlementStatus_PrePare;
//    [self.view addSubview:SettlementView];
//
    
    NSLog(@"Say Hello Clicked");
}


@end
