//
//  MessageSenderViewController.m
//  SHBasePro
//
//  Created by shenghai on 2017/1/15.
//  Copyright © 2017年 ren. All rights reserved.
//

#import "MessageSenderViewController.h"

@interface MessageSenderViewController ()

@end

@implementation MessageSenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(232, 232, 232);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
