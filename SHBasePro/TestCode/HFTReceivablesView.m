//
//  HFTReceivablesView.m
//  Erp4iOS
//  IM收款界面
//  Created by shenghai on 16/8/10.
//  Copyright © 2016年 成都好房通科技有限公司. All rights reserved.
//

#import "HFTReceivablesView.h"
#import "Masonry.h"

@interface HFTReceivablesView()

@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, strong) UILabel* spliderTips;
@property (nonatomic, strong) UILabel* spliderLine;
@property (nonatomic, strong) UILabel* sjjeLabel;  // 售价金额 或者 租金金额
@property (nonatomic, strong) UILabel* yjjeLabel;  // 佣金金额
@property (nonatomic, strong) UILabel* yjyfLabel;  // 佣金预付
@property (nonatomic, strong) UILabel* xxzfLabel;  // 线下支付

@property (nonatomic, strong) UILabel* sjjeLabelEx;
@property (nonatomic, strong) UILabel* yjjeLabelEx;

@property (nonatomic, strong) UILabel* yjyfLabelEx;  // 佣金预付  右侧
@property (nonatomic, strong) UILabel* yjyfLabelExUnit; // 佣金预付 单位
@property (nonatomic, strong) UILabel* xxzfLabelEx;  // 线下支付  右侧
@property (nonatomic, strong) UILabel* xxzfLabelExUnit; // 线下支付 单位

@end

@implementation HFTReceivablesView

- (instancetype) initWithFrame:(CGRect)frame andCaseType: (NSString*) caseType
{
    self = [super initWithFrame:frame];
    
    [self configSubviews: caseType];
    
    return self;
}

- (void) configSubviews: (NSString*) caseType
{
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview: self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    
    self.spliderLine = [[UILabel alloc] init];
    self.spliderLine.backgroundColor = kColor(221, 221, 221);
    [self.contentView addSubview:self.spliderLine];
    [self.spliderLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.height.mas_equalTo(@1);
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@(SCREEN_WIDTH - kUIScaleSize(50)));
    }];
    
    
    self.spliderTips = [[UILabel alloc] init];
    self.spliderTips.text = @"  收款信息  ";
    self.spliderTips.backgroundColor = [UIColor whiteColor];
    self.spliderTips.textColor = kColor(150, 150, 150);
    [self.contentView addSubview:self.spliderTips];
    [self.spliderTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.spliderLine.mas_centerY);
    }];
    
    // 售价金额
    self.sjjeLabel = [[UILabel alloc] init];
    if (caseType.integerValue == 0) {
        self.sjjeLabel.text = @"售价金额：";
    }
    else {
        self.sjjeLabel.text = @"月租金额：";
    }
    self.sjjeLabel.textColor = kColor(40, 40, 40);
    [self.contentView addSubview:self.sjjeLabel];
    [self.sjjeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kUIScaleSize(20));
        make.top.equalTo(self.spliderTips.mas_bottom).offset(kUIScaleSize(20));
    }];
    
    // 售价金额 右侧
    self.sjjeLabelEx = [[UILabel alloc] init];
    self.sjjeLabelEx.text = @"3500元";
    self.sjjeLabelEx.textColor = kColor(40, 40, 40);
    [self.contentView addSubview:self.sjjeLabelEx];
    [self.sjjeLabelEx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sjjeLabel.mas_right).offset(kUIScaleSize(5));
        make.centerY.equalTo(self.sjjeLabel.mas_centerY);
    }];

    // 佣金金额
    self.yjjeLabel = [[UILabel alloc] init];
    self.yjjeLabel.text = @"佣金金额：";
    self.yjjeLabel.textColor = kColor(40, 40, 40);
    [self.contentView addSubview:self.yjjeLabel];
    [self.yjjeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(kUIScaleSize(20));
        make.centerY.equalTo(self.sjjeLabel.mas_centerY);
    }];
    
    // 佣金金额 右侧
    self.yjjeLabelEx = [[UILabel alloc] init];
    self.yjjeLabelEx.text = @"3500元";
    self.yjjeLabelEx.textColor = kColor(40, 40, 40);
    [self.contentView addSubview:self.yjjeLabelEx];
    [self.yjjeLabelEx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yjjeLabel.mas_right).offset(kUIScaleSize(5));
        make.centerY.equalTo(self.yjjeLabel.mas_centerY);
    }];
    
    // 佣金预付
    self.yjyfLabel = [[UILabel alloc] init];
    self.yjyfLabel.text = @"佣金预付：";
    self.yjyfLabel.textColor = kColor(40, 40, 40);
    [self.contentView addSubview:self.yjyfLabel];
    [self.yjyfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kUIScaleSize(20));
        make.top.equalTo(self.sjjeLabel.mas_bottom).offset(kUIScaleSize(15));
    }];
    
    // 佣金预付 右侧
    self.yjyfLabelEx = [[UILabel alloc] init];
    self.yjyfLabelEx.text = @"3500";
    self.yjyfLabelEx.textColor = kColor(255, 132, 0);
    [self.contentView addSubview:self.yjyfLabelEx];
    [self.yjyfLabelEx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yjyfLabel.mas_right).offset(kUIScaleSize(5));
        make.centerY.equalTo(self.yjyfLabel.mas_centerY);
    }];
    // 佣金预付 单位
    self.yjyfLabelExUnit = [[UILabel alloc] init];
    self.yjyfLabelExUnit.text = @"元";
    self.yjyfLabelExUnit.textColor = kColor(40, 40, 40);
    [self.contentView addSubview:self.yjyfLabelExUnit];
    [self.yjyfLabelExUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yjyfLabelEx.mas_right).offset(kUIScaleSize(1));
        make.centerY.equalTo(self.yjyfLabelEx.mas_centerY);
        make.width.equalTo(@30);
    }];
    
    
    // 线下支付
    self.xxzfLabel = [[UILabel alloc] init];
    self.xxzfLabel.text = @"线下支付：";
    self.xxzfLabel.textColor = kColor(40, 40, 40);
    [self.contentView addSubview:self.xxzfLabel];
    [self.xxzfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(kUIScaleSize(20));
        make.centerY.equalTo(self.yjyfLabel.mas_centerY);
    }];
    
    // 线下支付 右侧
    self.xxzfLabelEx = [[UILabel alloc] init];
    self.xxzfLabelEx.text = @"3500";
    self.xxzfLabelEx.textColor = kColor(255, 132, 0);
    [self.contentView addSubview:self.xxzfLabelEx];
    [self.xxzfLabelEx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.xxzfLabel.mas_right).offset(kUIScaleSize(5));
        make.centerY.equalTo(self.xxzfLabel.mas_centerY);
    }];
    // 线下支付 单位
    self.xxzfLabelExUnit = [[UILabel alloc] init];
    self.xxzfLabelExUnit.text = @"元";
    self.xxzfLabelExUnit.textColor = kColor(40, 40, 40);
    [self.contentView addSubview:self.xxzfLabelExUnit];
    [self.xxzfLabelExUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.xxzfLabelEx.mas_right).offset(kUIScaleSize(1));
        make.centerY.equalTo(self.xxzfLabelEx.mas_centerY);
        make.width.equalTo(@30);
    }];
    
    
}

@end
