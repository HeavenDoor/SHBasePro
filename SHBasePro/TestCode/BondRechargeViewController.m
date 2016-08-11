//
//  BondRechargeViewController.m
//  SHBasePro
//  真房源保证金充值界面
//  Created by shenghai on 16/6/21.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "BondRechargeViewController.h"
#import "TrueHouseDepositsView.h"
#import "masonry.h"

#define kScaleHeight ([UIScreen mainScreen].bounds.size.width / 375.f)

#define kScaleWidth ([UIScreen mainScreen].bounds.size.width / 320.f)

#define kScaleHeights ([UIScreen mainScreen].bounds.size.height / 667.f)

//---------------------- 适配界面时frame缩放比例 ----------------------
#define kUIScaleSize(ScaleSize) ((ScaleSize)*(kScaleWidth>1.0?1.05:(kScaleWidth<1.0?0.95:1.0)))

//---------------------- 适配界面时字体缩放比例 ----------------------
#define kFontScaleSize(ScaleSize) ((ScaleSize)+(kScaleWidth>1.0?1:(kScaleWidth<1.0?-1:0)))

//
#define kScreenScale_iPhone5 ([UIScreen mainScreen].bounds.size.width/320)


@interface BondRechargeViewController () <UITextFieldDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView* scrollView;  // 滚动区域
@property (nonatomic, strong) UIView* contentView;  // 滚动区域


@property (nonatomic, strong) UIView* topView;  // 第一个白色View 包含充值金额和提示
@property (nonatomic, strong) UITextField* moneyInput;  // 输入金额控件
@property (nonatomic, strong) UILabel* moneyTips;  // 充值金额
@property (nonatomic, strong) UIImageView* moneyFlag;  // ￥
@property (nonatomic, strong) UILabel* spiderLinetop;  // 分割线
@property (nonatomic, strong) UILabel* errorTips;  // 输入错误提示

@property (nonatomic, strong) UIView* midView;  // 第二个白色View 包含支付宝和微信

@property (nonatomic, strong) UIImageView* weixinImgView;  // 微信图标
@property (nonatomic, strong) UILabel* weixinFlag;  // 微信支付Label
@property (nonatomic, strong) UIButton* weixinButton;  // 微信支付按钮

@property (nonatomic, strong) UILabel* spiderLinemid;  // 分割线
@property (nonatomic, strong) UIImageView* zfbImgView;  // 支付宝图标
@property (nonatomic, strong) UILabel* zfbFlag;  // 支付宝支付Label
@property (nonatomic, strong) UIButton* zfbButton;  // 微信支付按钮

@property (nonatomic, strong) UIButton* rechargeButton;  // 确认充值按钮

@property (nonatomic, strong) UILabel* spiderLine1;  // 分割线
@property (nonatomic, strong) UILabel* spiderLine2;  // 分割线
@property (nonatomic, strong) UILabel* spiderLine3;  // 分割线
@property (nonatomic, strong) UILabel* spiderLine4;  // 分割线
@end

@implementation BondRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"保证金充值"];  // setTitle:@"保证金充值"
    self.navigationController.navigationBar.backgroundColor = kColor(0, 0, 236);
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColor(239, 239, 239);
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configSubViews];
    UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
    [self.view addGestureRecognizer:recognizer];
    [self disableRechargeButton];
    
}

- (void)configSubViews
{
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    _scrollView.delegate = self;
    _scrollView.bounces = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.backgroundColor = kColor(239, 239, 239);
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT + 0.3);
    _scrollView.contentOffset = CGPointMake(0, 0);
    [self.view addSubview:_scrollView];
    
    
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _contentView.backgroundColor = kColor(239, 239, 239);
    [_scrollView addSubview: _contentView];
    
    
    
    _spiderLine1 = [[UILabel alloc] init];
    _spiderLine1.backgroundColor = kColor(221, 221, 221);
    [_contentView addSubview:_spiderLine1];
    
    [_spiderLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView.mas_left);
        make.right.equalTo(_contentView.mas_right);
        make.top.equalTo(_contentView.mas_top).offset(kUIScaleSize(11 + 2) + 64);
        make.height.mas_equalTo(@1);
    }];
    
    // 第一个View
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:_topView];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView.mas_top).offset(kUIScaleSize(12 + 2) + 64);
        make.left.equalTo(_contentView.mas_left);
        make.right.equalTo(_contentView.mas_right);
        make.height.mas_equalTo(kUIScaleSize(140));
    }];
    
    // 充值金额
    _moneyTips = [[UILabel alloc] init];
    _moneyTips.text = @"充值金额";

    
    [_moneyTips setFont:[UIFont systemFontOfSize: kFontScaleSize(15)]];
    _moneyTips.textColor = kColor(40, 40, 40);
    [_topView addSubview:_moneyTips];
    [_moneyTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.mas_top).offset(kUIScaleSize(15));
        make.left.equalTo(_topView.mas_left).offset(15);
    }];
    
    // 分割线
    _spiderLinetop = [[UILabel alloc] init];
    _spiderLinetop.backgroundColor = kColor(221, 221, 221);
    
    [_topView addSubview:_spiderLinetop];
    
    [_spiderLinetop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left).offset(15);
        make.right.equalTo(_topView.mas_right).offset(-15);
        make.top.equalTo(_topView.mas_bottom).offset(-kUIScaleSize(35 + 2));
        make.height.mas_equalTo(@1);
    }];
    
    // 错误提示
    _errorTips = [[UILabel alloc] init];
    [_errorTips setFont:[UIFont systemFontOfSize:kFontScaleSize(14)]];
    _errorTips.textColor = kColor(102, 102, 102);
    _errorTips.text = @"输入金额必须为100的倍数";
    [_topView addSubview:_errorTips];
    [_errorTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left).offset(15);
        make.top.equalTo(_spiderLinetop.mas_top).offset(kUIScaleSize(10));
    }];
    
    // 人民币标记
    _moneyFlag = [[UIImageView alloc] init];
    UIImage* moneyImg = [UIImage imageNamed:@"unit_"];
    [_moneyFlag setImage:moneyImg];
    [_topView addSubview: _moneyFlag];
    [_moneyFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left).offset(15);
        make.bottom.equalTo(_spiderLinetop.mas_top).offset(-12);
        make.size.mas_equalTo(CGSizeMake(kUIScaleSize(moneyImg.size.width + 2), kUIScaleSize(moneyImg.size.height + 2)));
    }];
    
    // 输入框
    _moneyInput = [[UITextField alloc] init];
    _moneyInput.delegate = self;
    [_moneyInput setKeyboardType:UIKeyboardTypeNumberPad];
    [_moneyInput addTarget:self action:@selector(moneyChanged:) forControlEvents: UIControlEventEditingChanged];
    //_moneyInput.backgroundColor = [UIColor blueColor];
    [_moneyInput setFont:[UIFont systemFontOfSize:kFontScaleSize(37)]];
    [_moneyInput setTintColor:kColor(190, 190, 190)];
    [_topView addSubview:_moneyInput];
    [_moneyInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_moneyFlag.mas_right).offset(kUIScaleSize(14));
        make.bottom.equalTo(_moneyFlag.mas_bottom).offset(6);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(kUIScaleSize(35));
    }];
    
    
    _spiderLine2 = [[UILabel alloc] init];
    _spiderLine2.backgroundColor = kColor(221, 221, 221);
    [_contentView addSubview:_spiderLine2];
    
    [_spiderLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left);
        make.right.equalTo(_topView.mas_right);
        make.top.equalTo(_topView.mas_bottom);
        make.height.mas_equalTo(@1);
    }];
    
    
    _spiderLine3 = [[UILabel alloc] init];
    _spiderLine3.backgroundColor = kColor(221, 221, 221);
    [_contentView addSubview:_spiderLine3];
    
    [_spiderLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView.mas_left);
        make.right.equalTo(_contentView.mas_right);
        make.top.equalTo(_spiderLine2.mas_bottom).offset(kUIScaleSize(11 + 2));
        make.height.mas_equalTo(@1);
    }];
    //支付View
    _midView = [[UIView alloc] init];
    _midView.backgroundColor = [UIColor whiteColor];
    [_contentView addSubview:_midView];
    [_midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_spiderLine3.mas_bottom);
        make.left.equalTo(_topView.mas_left);
        make.right.equalTo(_topView.mas_right);
        make.height.mas_equalTo(kUIScaleSize(91));
    }];
    
    // 微信imaView
    _weixinImgView = [[UIImageView alloc] init];
    UIImage* wximg = [UIImage imageNamed:@"wechat_"];
    _weixinImgView.image = wximg;
    [_midView addSubview:_weixinImgView];
    [_weixinImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_midView.mas_left).offset(15);
        make.top.equalTo(_midView.mas_top).offset(10);
        make.width.mas_equalTo(kUIScaleSize(wximg.size.width + 2));
        make.height.mas_equalTo(kUIScaleSize(wximg.size.height + 2));
    }];
    
    // 微信选择按钮
    _weixinButton = [[UIButton alloc] init];
    UIImage* imgSel = [UIImage imageNamed:@"xuanze_"];
    UIImage* imgUnSel = [UIImage imageNamed:@"weixuanze_"];
    [_weixinButton setImage:imgUnSel forState:UIControlStateNormal];
    [_weixinButton setImage:imgSel forState:UIControlStateSelected];
    [_weixinButton setSelected:NO];
    [_weixinButton addTarget:self action:@selector(payTyoeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_midView addSubview:_weixinButton];
    [_weixinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_midView.mas_top).offset(12.5);
        make.right.equalTo(_midView.mas_right).offset(-15);
        make.width.mas_equalTo(kUIScaleSize(imgSel.size.width + 2));
        make.height.mas_equalTo(kUIScaleSize(imgSel.size.height + 2));
    }];
    
    _weixinFlag = [[UILabel alloc] init];
    _weixinFlag.text = @"微信支付";
    _weixinFlag.textColor = kColor(40, 40, 40);
    [_weixinFlag setFont:[UIFont systemFontOfSize:kFontScaleSize(16)]];
    
    [_midView addSubview:_weixinFlag];
    [_weixinFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_weixinImgView.mas_right).offset(kUIScaleSize(10));
        make.centerY.equalTo(_weixinImgView.mas_centerY);
        
    }];
    
    // 分割线
    _spiderLinemid = [[UILabel alloc] init];
    _spiderLinemid.backgroundColor = kColor(221, 221, 221);
    [_midView addSubview:_spiderLinemid];
    [_spiderLinemid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_midView.mas_left).offset(15);
        make.right.equalTo(_midView.mas_right);
        make.centerY.equalTo(_midView.mas_centerY);
        make.height.mas_equalTo(@1);
    }];
    
    
    // 支付宝imaView
    _zfbImgView = [[UIImageView alloc] init];
    UIImage* zfbimg = [UIImage imageNamed:@"zhifubao_"];
    _zfbImgView.image = zfbimg;
    [_midView addSubview:_zfbImgView];
    [_zfbImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_midView.mas_left).offset(15);
        make.top.equalTo(_spiderLinemid.mas_top).offset(10);
        make.width.mas_equalTo(kUIScaleSize(zfbimg.size.width + 2));
        make.height.mas_equalTo(kUIScaleSize(zfbimg.size.height + 2));
    }];
    
    // 支付宝选择按钮
    _zfbButton = [[UIButton alloc] init];
    [_zfbButton setImage:imgUnSel forState:UIControlStateNormal];
    [_zfbButton setImage:imgSel forState:UIControlStateSelected];
    [_zfbButton setSelected:NO];
    [_zfbButton addTarget:self action:@selector(payTyoeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_midView addSubview:_zfbButton];
    [_zfbButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_spiderLinemid.mas_top).offset(12.5);
        make.right.equalTo(_midView.mas_right).offset(-15);
        make.width.mas_equalTo(kUIScaleSize(imgSel.size.width + 2));
        make.height.mas_equalTo(kUIScaleSize(imgSel.size.height + 2));
    }];
    
    _zfbFlag = [[UILabel alloc] init];
    _zfbFlag.text = @"支付宝支付";
    _zfbFlag.textColor = kColor(40, 40, 40);
    [_zfbFlag setFont:[UIFont systemFontOfSize:kFontScaleSize(16)]];
    
    [_midView addSubview:_zfbFlag];
    [_zfbFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_zfbImgView.mas_right).offset(kUIScaleSize(10));
        make.centerY.equalTo(_zfbImgView.mas_centerY);
        
    }];
    
    
    _spiderLine4 = [[UILabel alloc] init];
    _spiderLine4.backgroundColor = kColor(221, 221, 221);
    [_contentView addSubview:_spiderLine4];
    
    [_spiderLine4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView.mas_left);
        make.right.equalTo(_contentView.mas_right);
        make.top.equalTo(_midView.mas_bottom);
        make.height.mas_equalTo(@1);
    }];
    
    // 确认充值
    _rechargeButton = [[UIButton alloc] init];
    [_rechargeButton setTitle:@"确认充值" forState:UIControlStateNormal];
    _rechargeButton.layer.cornerRadius = 5.0;
    [_rechargeButton setBackgroundColor:kColor(42, 201, 69)];
    [_rechargeButton.titleLabel setFont:[UIFont systemFontOfSize:kFontScaleSize(18)]];
    [_rechargeButton addTarget:self action:@selector(rechargeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_rechargeButton];
    [_rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView.mas_left).offset(15);
        make.right.equalTo(_contentView.mas_right).offset(-15);
        make.top.equalTo(_midView.mas_bottom).offset(30);
        make.height.mas_equalTo(kUIScaleSize(45 + 2));
    }];
    
}

#pragma mark 确认充值按钮
- (void) rechargeButtonClicked: (UIButton*) sender
{
    NSLog(@"确认充值点击");
}

#pragma mark 选择支付方式按钮
- (void) payTyoeButtonClicked: (UIButton*) sender
{
    [sender setSelected: !sender.selected];
    if (sender.selected) {
        if (sender == _zfbButton) {
            _weixinButton.selected = NO;
        }
        else
        {
            _zfbButton.selected = NO;
        }
        if ([self isInputLegal])
        {
            [self enableRechargeButton];
        }
        else
        {
            [self disableRechargeButton];
        }
    }
    else
    {
        [_rechargeButton setBackgroundColor:[UIColor grayColor]];
        _rechargeButton.userInteractionEnabled = NO;
    }
}

#pragma mark 合法性判断
- (BOOL) isInputLegal
{
    if (![_moneyInput.text isEqualToString:@""] && _moneyInput.text.intValue%100 == 0 && (_zfbButton.selected || _weixinButton.selected) )
    {
        return YES;
    }
    return NO;
}

- (void) enableRechargeButton
{
    [_rechargeButton setBackgroundColor: kColor(42, 201, 69)];
    _rechargeButton.userInteractionEnabled = YES;
}

- (void) disableRechargeButton
{
    [_rechargeButton setBackgroundColor:[UIColor grayColor]];
    _rechargeButton.userInteractionEnabled = NO;
}

- (void) viewTap: (UITapGestureRecognizer*) sender
{
    [self.view endEditing:YES];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if(![self isNumber1: [textField.text stringByAppendingString:string]])
    {
        return NO;
    }
    if (textField.text.length >= 4 ) {
        return NO;
    }
    return YES;
}

- (void) moneyChanged: (UITextField*) textField
{
    if ([textField.text integerValue] % 100 == 0)
    {
        if ([self isInputLegal])
        {
            [self enableRechargeButton];
        }
        else
        {
            [self disableRechargeButton];
        }
        
        _errorTips.textColor = kColor(102, 102, 102);
    }
    else
    {
        
        [self disableRechargeButton];
        _errorTips.textColor = kColor(255, 0, 0);
    }
}

- (BOOL)isNumber1:(NSString*)str
{
    NSString *regex = @"^[1-9]\\d*$";
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pre evaluateWithObject:str];
}

@end
