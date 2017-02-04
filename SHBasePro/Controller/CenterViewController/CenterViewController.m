//
//  CenterViewController.m
//  SHBasePro
//
//  Created by shenghai on 16/9/2.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "CenterViewController.h"
#import "masonry.h"
#import "UIImage+SHBasePro.h"
#import "MessageSenderViewController.h"



@interface CenterViewController()

@property(nonatomic, strong) UIView* navigationView;
@property(nonatomic, strong) UIView* centerview;

@property(strong, nonatomic) UIButton* preTestBtn;
@property(strong, nonatomic) UIButton* backTestBtn;

@property(nonatomic, strong) UIImageView* imgView;

@property(nonatomic, strong) UIWindow *keyWindow;
@end


@implementation CenterViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationView = [[UIView alloc] init];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(@64);
    }];
    
    UIImageView* imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:@"navi_bg_64.png"]];
    [self.navigationView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.navigationView);
    }];

    UIButton *backBtn = [[UIButton alloc] init];
    [self.navigationView addSubview: backBtn];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_btn_ios7"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnPre:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navigationView);
        make.left.equalTo(self.navigationView.mas_left).offset(10);
        make.top.equalTo(self.navigationView.mas_top).offset(20);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@44);
    }];
    
    self.preTestBtn = [[UIButton alloc] init];
    self.preTestBtn.backgroundColor = [UIColor grayColor];
    self.preTestBtn.layer.borderWidth = 1;
    self.preTestBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.preTestBtn.layer.cornerRadius = 4;
    [self.preTestBtn setTitle:@"AAA" forState:UIControlStateNormal];
    [self.preTestBtn addTarget:self action:@selector(preTestBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.preTestBtn];
    [self.preTestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).multipliedBy(0.5);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(@130);
        make.height.mas_equalTo(@75);
    }];
    
    self.backTestBtn = [[UIButton alloc] init];
    self.backTestBtn.backgroundColor = [UIColor grayColor];
    self.backTestBtn.layer.borderWidth = 1;
    self.backTestBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.backTestBtn.layer.cornerRadius = 4;
    [self.backTestBtn setTitle:@"BBB" forState:UIControlStateNormal];
    [self.backTestBtn addTarget:self action:@selector(backTestBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backTestBtn];
    [self.backTestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).multipliedBy(1.5);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(@130);
        make.height.mas_equalTo(@75);
    }];
    
    self.imgView = [[UIImageView alloc] init];
    [self.view addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@100);
        make.height.equalTo(@100);
    }];
    [self.imgView setImage:[[UIImage alloc] initWithContentsOfFile:@""]];
}

- (void) backBtnPre: (UIButton*) btn {
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController popViewControllerAnimated:YES];
}

- (void) preTestBtnAction: (UIButton*) sender {
    [self performSelector:@selector(ggw) withObject:nil];
    MessageSenderViewController* VC = [[MessageSenderViewController alloc] init];
    //UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:self];
    
    //[self.presentingViewController presentViewController:VC animated:YES completion:nil];
    [(UINavigationController*)(self.parentViewController) pushViewController:VC animated:YES];
}

- (void) backTestBtnAction: (UIButton*) sender {
    NSString *gg = nil;
    NSDictionary *dict = @{gg: @"ggwp", @"sheng": gg, @"AAA": @"ren"};
    
    NSString * pp = [dict objectForKey:@"sheng"];
    if (pp == [NSNull null]) {
        NSLog(@"null");
    }
    _keyWindow = [[UIApplication sharedApplication] keyWindow];

}


@end
