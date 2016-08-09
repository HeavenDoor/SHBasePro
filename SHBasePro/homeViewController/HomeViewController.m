//
//  HomeViewController.m
//  SHBasePro
//  首页窗口控制器
//  Created by mac on 16/8/5.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@property (strong, nonatomic) UIImageView* bgImg;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homebg"]];
    self.bgImg.frame = self.view.frame;
    [self.view addSubview:self.bgImg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
