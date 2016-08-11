//
//  IMSendhouseTips.m
//  Erp4iOS
//  IM发送房源超过5条的提示框
//  Created by shenghai on 16/8/9.
//  Copyright © 2016年 成都好房通科技有限公司. All rights reserved.
//

#import "IMSendhouseTips.h"
#import "Masonry.h"

@interface IMSendhouseTips()
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* contentLabelUp;
@property (nonatomic, strong) UILabel* contentLabelDown;

@property (nonatomic, strong) UIButton* sureButton;
@property (nonatomic, strong) UILabel* spliderLabel;
@end

@implementation IMSendhouseTips
- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self genSubViews];
    return self;
}

- (void) genSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 8.0;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = @"提示";
    self.titleLabel.textColor = kColor(37, 182, 237);
    self.titleLabel.font = [UIFont systemFontOfSize: kFontScaleSize(18.0)];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kUIScaleSize(15));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    self.contentLabelUp = [[UILabel alloc] init];
    self.contentLabelUp.numberOfLines = 0;
    self.contentLabelUp.text = @"最多可以同时推荐5套房源，请主动联系或耐心等待对方同意看房。";
    self.contentLabelUp.textColor = kColor(50, 50, 50);
    self.contentLabelUp.font = [UIFont systemFontOfSize: kFontScaleSize(16.0)];
    
    [self addSubview:self.contentLabelUp];
    [self.contentLabelUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(kUIScaleSize(30));
        make.left.equalTo(self.mas_left).offset(kUIScaleSize(10));
        make.width.mas_equalTo(@(self.width - kUIScaleSize(20)));
    }];
    
    
    self.contentLabelDown = [[UILabel alloc] init];
    self.contentLabelDown.numberOfLines = 0;
    self.contentLabelDown.text = @"最多可以同时推荐5套房源，请主动联系或耐心等待对方同意看房。";
    self.contentLabelDown.textColor = kColor(50, 50, 50);
    self.contentLabelDown.font = [UIFont systemFontOfSize: kFontScaleSize(16.0)];
    
    [self addSubview:self.contentLabelDown];
    [self.contentLabelDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabelUp.mas_bottom).offset(kUIScaleSize(10));
        make.left.equalTo(self.mas_left).offset(kUIScaleSize(10));
        make.width.mas_equalTo(@(self.width - kUIScaleSize(20)));
    }];
    
    
    self.sureButton = [[UIButton alloc] init];
    [self.sureButton addTarget:self action:@selector(okButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.sureButton setTitle:@"我知道了" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:kColor(37, 182, 237) forState:UIControlStateNormal];
    [self.sureButton.titleLabel setFont:[UIFont systemFontOfSize: kFontScaleSize(18.0)]];
    [self addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(@(kUIScaleSize(40)));
    }];
    
    self.spliderLabel = [[UILabel alloc] init];
    self.spliderLabel.backgroundColor = kColor(230, 230, 230);
    
    [self addSubview:self.spliderLabel];
    [self.spliderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.sureButton.mas_top).offset(-1);
        make.height.mas_equalTo(@1);
    }];
    
}

- (void) okButtonClicked: (UIButton*) sender
{
    if (self.okBlock) {
        self.okBlock();
    }
}
@end
