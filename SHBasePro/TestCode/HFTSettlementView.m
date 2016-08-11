//
//  HFTSettlementView.m
//  Erp4iOS
//  IM结算界面
//  Created by shenghai on 16/8/10.
//  Copyright © 2016年 成都好房通科技有限公司. All rights reserved.
//

#import "HFTSettlementView.h"
#import "Masonry.h"

@interface HFTSettlementView()

@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, strong) UILabel* spliderTips;
@property (nonatomic, strong) UILabel* spliderLine;
@property (nonatomic, strong) UILabel* tipsLabel;
@property (nonatomic, strong) UILabel* sjjeLabel;  // 售价金额 或者 租金金额
@property (nonatomic, strong) UILabel* yjjeLabel;  // 佣金金额
@property (nonatomic, strong) UILabel* yjyfLabel;  // 佣金预付
@property (nonatomic, strong) UILabel* xxzfLabel;  // 线下支付

@property (nonatomic, strong) UITextField* sjjeField;  // 售价金额 编辑框
@property (nonatomic, strong) UITextField* yjjeField;  // 佣金金额 编辑框

@property (nonatomic, strong) UILabel* yjyfLabelEx;  // 佣金预付  右侧
@property (nonatomic, strong) UILabel* yjyfLabelExUnit; // 佣金预付 单位
@property (nonatomic, strong) UILabel* xxzfLabelEx;  // 线下支付  右侧
@property (nonatomic, strong) UILabel* xxzfLabelExUnit; // 线下支付 单位

@property (nonatomic, strong) UIButton* jsButton; // 结算按钮
@end

@implementation HFTSettlementView

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
    self.spliderTips.text = @"  收款设置  ";
    self.spliderTips.backgroundColor = [UIColor whiteColor];
    self.spliderTips.textColor = kColor(150, 150, 150);
    [self.contentView addSubview:self.spliderTips];
    [self.spliderTips mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(self.mas_top);
        //make.height.mas_equalTo(@1);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.spliderLine.mas_centerY);
    }];
    
    // 提示Label
    self.tipsLabel = [[UILabel alloc] init];
    self.tipsLabel.text = @"请与客户沟通确认后再设置收款金额，设置后不可更改";
    self.tipsLabel.textColor = kColor(243, 166, 88);
    self.tipsLabel.font = [UIFont systemFontOfSize: kFontScaleSize(13)];
    
    [self.contentView addSubview:self.tipsLabel];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.spliderTips.mas_bottom).offset(10);
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
        make.top.equalTo(self.tipsLabel.mas_bottom).offset(kUIScaleSize(15));
    }];
    
    // 售价金额 输入框
    self.sjjeField = [[UITextField alloc] init];
    self.sjjeField.layer.borderColor = kColor(213, 213, 213).CGColor;
    self.sjjeField.layer.borderWidth = 1.0;
    self.sjjeField.layer.cornerRadius = 4.0;
    
    self.sjjeField = [[UITextField alloc] init];
    self.sjjeField.layer.borderColor = kColor(213, 213, 213).CGColor;
    self.sjjeField.layer.borderWidth = 1.0;
    self.sjjeField.layer.cornerRadius = 4.0;
    self.sjjeField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.sjjeField.leftViewMode = UITextFieldViewModeAlways;
    
    self.sjjeField.rightView = [[UIView alloc]initWithFrame:CGRectMake(self.sjjeField.right, 0, 20, 20)];
    UILabel*labeluint1 = [[UILabel alloc] initWithFrame:self.sjjeField.rightView.frame];
    labeluint1.text = @"元";
    labeluint1.textColor = kColor(221, 221, 221);
    [self.sjjeField.rightView addSubview:labeluint1];
    self.sjjeField.rightViewMode = UITextFieldViewModeAlways;
    self.sjjeField.tintColor = kColor(213, 213, 213);
    
    
    [self.contentView addSubview:self.sjjeField];
    [self.sjjeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sjjeLabel.mas_right).offset(kUIScaleSize(8));
        make.centerY.equalTo(self.sjjeLabel.mas_centerY);
        make.height.equalTo(@kUIScaleSize(25));
        make.width.equalTo(@kUIScaleSize(125));
    }];
    
    // 佣金金额
    self.yjjeLabel = [[UILabel alloc] init];
    self.yjjeLabel.text = @"佣金金额：";
    self.yjjeLabel.textColor = kColor(40, 40, 40);
    [self.contentView addSubview:self.yjjeLabel];
    [self.yjjeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kUIScaleSize(20));
        make.top.equalTo(self.sjjeLabel.mas_bottom).offset(kUIScaleSize(15));
    }];
    
    // 佣金金额 输入框
    self.yjjeField = [[UITextField alloc] init];
    self.yjjeField.layer.borderColor = kColor(213, 213, 213).CGColor;
    self.yjjeField.layer.borderWidth = 1.0;
    self.yjjeField.layer.cornerRadius = 4.0;
    self.yjjeField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
    self.yjjeField.leftViewMode = UITextFieldViewModeAlways;
    
    self.yjjeField.rightView = [[UIView alloc]initWithFrame:CGRectMake(self.yjjeField.right, 0, 20, 20)];
    UILabel*labeluint = [[UILabel alloc] initWithFrame:self.yjjeField.rightView.frame];
    labeluint.text = @"元";
    labeluint.textColor = kColor(221, 221, 221);
    [self.yjjeField.rightView addSubview:labeluint];
    self.yjjeField.rightViewMode = UITextFieldViewModeAlways;
    self.yjjeField.tintColor = kColor(213, 213, 213);
    
    [self.contentView addSubview:self.yjjeField];
    [self.yjjeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yjjeLabel.mas_right).offset(kUIScaleSize(8));
        make.centerY.equalTo(self.yjjeLabel.mas_centerY);
        make.height.equalTo(@kUIScaleSize(25));
        make.width.equalTo(@kUIScaleSize(125));
    }];
    
    // 佣金预付
    self.yjyfLabel = [[UILabel alloc] init];
    self.yjyfLabel.text = @"佣金预付：";
    self.yjyfLabel.textColor = kColor(40, 40, 40);
    [self.contentView addSubview:self.yjyfLabel];
    [self.yjyfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kUIScaleSize(20));
        make.top.equalTo(self.yjjeLabel.mas_bottom).offset(kUIScaleSize(15));
    }];
    
    // 佣金预付 右侧
    self.yjyfLabelEx = [[UILabel alloc] init];
    self.yjyfLabelEx.text = @"3500";
    self.yjyfLabelEx.textColor = kColor(255, 132, 0);
    [self.contentView addSubview:self.yjyfLabelEx];
    [self.yjyfLabelEx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yjyfLabel.mas_right).offset(kUIScaleSize(10));
        //make.top.equalTo(self.yjjeLabel.mas_bottom).offset(kUIScaleSize(23));
        make.centerY.equalTo(self.yjyfLabel.mas_centerY);
        //make.width.equalTo(@200);
    }];
    //[self.yjyfLabelEx sizeToFit];
    // 佣金预付 单位
    self.yjyfLabelExUnit = [[UILabel alloc] init];
    self.yjyfLabelExUnit.text = @"元";
    self.yjyfLabelExUnit.textColor = kColor(170, 170, 170);
    [self.contentView addSubview:self.yjyfLabelExUnit];
    [self.yjyfLabelExUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yjyfLabelEx.mas_right).offset(kUIScaleSize(3));
        //make.top.equalTo(self.yjjeLabel.mas_bottom).offset(kUIScaleSize(23));
        make.centerY.equalTo(self.yjyfLabelEx.mas_centerY);
        make.width.equalTo(@30);
    }];
    
    
    // 线下支付
    self.xxzfLabel = [[UILabel alloc] init];
    self.xxzfLabel.text = @"线下支付：";
    self.xxzfLabel.textColor = kColor(40, 40, 40);
    [self.contentView addSubview:self.xxzfLabel];
    [self.xxzfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kUIScaleSize(20));
        make.top.equalTo(self.yjyfLabel.mas_bottom).offset(kUIScaleSize(15));
    }];
    
    // 线下支付 右侧
    self.xxzfLabelEx = [[UILabel alloc] init];
    self.xxzfLabelEx.text = @"3500";
    self.xxzfLabelEx.textColor = kColor(255, 132, 0);
    [self.contentView addSubview:self.xxzfLabelEx];
    [self.xxzfLabelEx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.xxzfLabel.mas_right).offset(kUIScaleSize(10));
        //make.top.equalTo(self.yjjeLabel.mas_bottom).offset(kUIScaleSize(23));
        make.centerY.equalTo(self.xxzfLabel.mas_centerY);
        //make.width.equalTo(@200);
    }];
    //[self.yjyfLabelEx sizeToFit];
    // 线下支付 单位
    self.xxzfLabelExUnit = [[UILabel alloc] init];
    self.xxzfLabelExUnit.text = @"元";
    self.xxzfLabelExUnit.textColor = kColor(170, 170, 170);
    [self.contentView addSubview:self.xxzfLabelExUnit];
    [self.xxzfLabelExUnit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.xxzfLabelEx.mas_right).offset(kUIScaleSize(3));
        //make.top.equalTo(self.yjjeLabel.mas_bottom).offset(kUIScaleSize(23));
        make.centerY.equalTo(self.xxzfLabelEx.mas_centerY);
        make.width.equalTo(@30);
    }];
    
    self.jsButton = [[UIButton alloc] init];
    [self.jsButton setTitle:@"结算并发送" forState:UIControlStateNormal];
    self.jsButton.titleLabel.font = [UIFont systemFontOfSize:kFontScaleSize(18)];
    self.jsButton.titleLabel.textColor = [UIColor whiteColor];
    self.jsButton.layer.cornerRadius = 6.0;
    self.jsButton.backgroundColor = kColor(70, 180, 236);
    [self.jsButton addTarget:self action:@selector(jsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.jsButton];
    [self.jsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(kUIScaleSize(20));
        make.right.equalTo(self.contentView.mas_right).offset(kUIScaleSize(-20));
        make.height.mas_equalTo(@40);
        make.top.equalTo(self.xxzfLabel.mas_bottom).offset(kUIScaleSize(12));
    }];
}

- (void) setSettleStatus:(SettlementStatus)settleStatus
{
    _settleStatus = settleStatus;
}

- (void) jsButtonClicked: (UIButton*) sender
{
    
}
@end
