//
//  TrueHouseRuleController.m
//  SHBasePro
//  真房源规则页面
//  Created by shenghai on 16/7/5.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "TrueHouseRuleController.h"
#import "masonry.h"
#import "UIImageView+WebCache.h"

#import <AVFoundation/AVFoundation.h>

@interface TrueHouseRuleController()
@property (nonatomic, strong) UIWebView* webView;
@property (nonatomic, strong) UILabel* spliderLabel;
@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, strong) UIButton* rejectButton;
@property (nonatomic, strong) UIButton* agreeButton;
@property (nonatomic, strong) UIImageView* imgView;

@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) UILabel* soundLabel;
@end

@implementation TrueHouseRuleController

- (void) viewDidLoad
{
    self.num = 999;
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc] init];
    //_webView.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT - 64);
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"truehouse_agreement.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    [self.navigationController setTitle:@"真房源规则"];
    self.navigationController.navigationBar.tintColor = [UIColor blueColor];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.equalTo(self.view.mas_height).offset(-244);
    }];
    
    _spliderLabel = [[UILabel alloc] init];
    _spliderLabel.backgroundColor = kColor(221, 221, 221);
    [self.view addSubview:_spliderLabel];
    [_spliderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.equalTo(_webView.mas_bottom);
        make.height.mas_equalTo(@1);
    }];
    
    
    _contentView = [[UIView alloc] init];
    //_contentView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.equalTo(_webView.mas_bottom).offset(1);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    _rejectButton = [[UIButton alloc] init];
    [_rejectButton setTitle:@"拒绝" forState:UIControlStateNormal];
    [_rejectButton setTitleColor:kColor(187, 187, 187) forState:UIControlStateNormal];
    [_rejectButton setImage:[UIImage imageNamed:@"jujue_"] forState:UIControlStateNormal];
    [_rejectButton addTarget:self action:@selector(rejectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    //_rejectButton.backgroundColor = [UIColor purpleColor];
    [_contentView addSubview:_rejectButton];
    [_rejectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top);
        make.left.equalTo(_contentView.mas_left);
        make.width.equalTo(_contentView.mas_width).multipliedBy(0.5);
        make.bottom.equalTo(_contentView.mas_bottom).offset(-150);
    }];
    
    _agreeButton = [[UIButton alloc] init];
    //_agreeButton.backgroundColor = [UIColor greenColor];
    [_agreeButton setTitle:@"同意" forState:UIControlStateNormal];
    [_agreeButton setTitleColor:kColor(70, 180, 236) forState:UIControlStateNormal];
    [_agreeButton setImage:[UIImage imageNamed:@"tongyi_"] forState:UIControlStateNormal];
    [_agreeButton addTarget:self action:@selector(agreeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_contentView addSubview:_agreeButton];
    [_agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top);
        make.right.equalTo(_contentView.mas_right);
        make.width.equalTo(_contentView.mas_width).multipliedBy(0.5);
        make.bottom.equalTo(_contentView.mas_bottom).offset(-150);
    }];
    
    
    _imgView = [[UIImageView alloc] init];
    
    [_contentView addSubview: _imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@100);
        make.top.equalTo(_agreeButton.mas_bottom).offset(20);
        make.left.equalTo(_agreeButton.mas_left);
    }];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:@"http://pic.hftsoft.com/pic/hftpic/house/2016/07/1_1/AA01D0/SmallPic/1/CSCD1607081030002_23384984.jpg!240!180"] placeholderImage:[UIImage imageNamed:@"banner6p_"] options:SDWebImageRefreshCached];
    
    _soundLabel = [[UILabel alloc] init];
    [_contentView addSubview: _soundLabel];
    [_soundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(@100);
        make.top.equalTo(_agreeButton.mas_bottom).offset(20);
        make.left.equalTo(_rejectButton.mas_left);
    }];
}


- (void) agreeButtonClicked: (UIButton*) sender
{
    
    [self playAudio: ++self.num];
    _soundLabel.text = [NSString stringWithFormat:@"%ld", self.num];
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:@"http://pic.hftsoft.com/pic/hftpic/house/2016/07/1_1/AA01D0/SmallPic/1/CSCD1607081030002_23384984.jpg!240!180"] placeholderImage:[UIImage imageNamed:@"banner6p_"] options:SDWebImageRefreshCached];
    //self.agreeBlock();
}

- (void) playAudio: (NSInteger) ids
{
    AudioServicesPlaySystemSound(ids);
}

- (void) rejectButtonClicked: (UIButton*) sender
{
    [self playAudio:--self.num];
    //self.rejectBlock();
    _soundLabel.text = [NSString stringWithFormat:@"%ld", self.num];
}

@end
