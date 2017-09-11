//
//  MineViewController.m
//  SHBasePro
//  我的窗口控制器
//  Created by mac on 16/8/5.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "MineViewController.h"
//#import "UIImage+GIF.h"
#import "UIControl+SequenceClick.h"
#import "UIImageView+WebCache.h"
#import "UIImage-Extensions.h"
#import "ComplexDealCenter.h"
#import "UILabel+Tool.h"

@interface MineViewController () <ComplexDealProtocol>
@property (strong, nonatomic) UIImageView* bgImg;
@property (nonatomic, strong) UIButton* sayHelloButton;

@property (strong, nonatomic) UIImageView* kkImageView;

@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ComplexDealCenter sharedInstance] addDelegate:self];
    
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
    //self.sayHelloButton.uxy_acceptEventInterval = 1.5;
    
    
    UIImage* img = [UIImage imageNamed:@"本店"];// [imageRotatedByDegrees: folatro];
    self.kkImageView = [[UIImageView alloc] initWithFrame: CGRectMake(100, SCREEN_HEIGHT -  200, 150,150)];
    self.kkImageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.kkImageView];
    //self.kkImageView.image = img;
    [self.kkImageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic.vfanghui.com/pic/HEAD/1_1/SMALL/CD0351138_1_1480141863528.jpg"]];
    self.kkImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClicked:)];
    [self.kkImageView addGestureRecognizer:gest];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200)];
    _textLabel.numberOfLines = 0;
    _textLabel.text = @"为保护您的隐私，经纪人无法看到您的真实号码，只能通过优优好房转接电话联系您。若对房源无意向，请勿随意告知对方手机号或进行回拨。如不愿再次接听该经纪人的转接电话，可在委托详情页中拒绝该经纪人服务！";
    [_textLabel setLineSpaceing:30];
    [self.view addSubview:_textLabel];
}

- (void)onComplexEventDealt:(NSString *)result {
    NSLog(@"%@ onComplexEventDealt Result: %@", [self class], result);
}

- (void)imageClicked:(UIGestureRecognizer *)gest {
    
}

- (void) sayHello {
//    folatro = folatro + 15;
//    UIImage* img = [[UIImage imageNamed:@"carc"] imageRotatedByDegrees: folatro];
//    self.kkImageView.image = img;
//    
//    NSLog(@"Say Hello Clicked");
}


@end
