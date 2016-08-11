//
//  TrueHouseDepositsView.m
//  Erp4iOS
//  点亮真房源 弹出提示交保证金界面
//  Created by shenghai on 16/6/20.
//  Copyright © 2016年 成都好房通科技有限公司. All rights reserved.
//

#import "TrueHouseDepositsView.h"
#import "masonry.h"



//#define kColor(a,b,c) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:1]

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

@interface TrueHouseDepositsView()
{
    UITapGestureRecognizer* tapRecognizer;  // 点亮规则点击
}

@property (nonatomic, strong) UIView* contengView;  // 背景View
@property (nonatomic, strong) UIButton* closeButton;  // 关闭按钮
@property (nonatomic, strong) UIImageView* bannerImageView;  // 点亮真房源 顶部banner图片
@property (nonatomic, strong) UILabel* contentLabel;  // 显示内容
@property (nonatomic, strong) UILabel* lightRuleLabel; // 点亮规则
@property (nonatomic, strong) UIButton* lightButton;  // 去点亮按钮

@end

@implementation TrueHouseDepositsView

//- (instancetype) initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame: frame];
//    if (self) {
//        [self initSubViews];
//    }
//    return self;
//}

- (instancetype)init
{

    self = [super init];
    if (self) {
        [self initSubViews];
    }
    return self;
}


- (void) initSubViews
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 8;
    
    
    UIImage* bannerImage;
    
    CGFloat viewWidth = 270;
    CGFloat viewHeight = 280;
    
    CGFloat bannerHeight = 115;
    CGFloat contentLabelSize = 13.0;
    CGFloat lightRuleLabelSize = 12.0;
    CGFloat lightButtonLabelSize = 18.0;
    if (iPhone5 || iPhone4)
    {
        bannerImage = [UIImage imageNamed:@"banner_"];
        contentLabelSize = 13.0;
        lightRuleLabelSize = 12.0;
        lightButtonLabelSize = 18.0;
        
        viewWidth = 270;
        viewHeight = 280;
    }
    else if (iPhone6)
    {
        bannerImage = [UIImage imageNamed:@"banner6_"];
        bannerHeight = 138.5;
        contentLabelSize = 15.0;
        lightRuleLabelSize = 14.0;
        lightButtonLabelSize = 20.0;
        
        viewWidth = 325;
        viewHeight = 315;
    }
    else if (iPhone6P)
    {
        bannerImage = [UIImage imageNamed:@"banner6p_"];
        bannerHeight = 148.4;
        contentLabelSize = 15.0;
        lightRuleLabelSize = 14.0;
        lightButtonLabelSize = 20.0;
        
        viewWidth = 347;
        viewHeight = 320;
    }

    self.frame = CGRectMake(SCREEN_WIDTH/2 - viewWidth/2, SCREEN_HEIGHT/2 - viewHeight/2, viewWidth, viewHeight);
    
    _bannerImageView = [[UIImageView alloc] init];
    if (bannerImage != nil) {
        _bannerImageView.image = bannerImage;
    }
    
    [self addSubview:_bannerImageView];
    [_bannerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        //make.size.mas_equalTo(CGSizeMake(self.frame.size.width, bannerHeight));
        make.height.mas_equalTo(bannerHeight);
    }];
    
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.backgroundColor = [UIColor clearColor];
    //设置字体颜色为白色
    _contentLabel.font = [UIFont systemFontOfSize: contentLabelSize];
    _contentLabel.textColor = kColor(50, 50, 50);
    //文字居中显示
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    //自动折行设置
    _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _contentLabel.numberOfLines = 0;
    NSString* title = @"真房源会在优优好房向客户明文显示您的电话号码，让您坐享免费发房端口。";
    _contentLabel.text = title;
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString: title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [title length])];
    _contentLabel.attributedText = attributedString;
    
    //[_tipsBG addSubview:openMicPrivilegeTipsLabel];
    [_contentLabel sizeToFit];
    
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bannerImageView.mas_bottom).offset(32);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    
    _lightRuleLabel = [[UILabel alloc] init];
    _lightRuleLabel.userInteractionEnabled = YES;
    _lightRuleLabel.text = @"点亮规则>";
    tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(RuleLabelClicked:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1; //手指

    //tapRecognizer.delegate = self;
    
    [_lightRuleLabel addGestureRecognizer:tapRecognizer];

    _lightRuleLabel.textAlignment = NSTextAlignmentRight;
    _lightRuleLabel.textColor = kColor(24, 180, 237);
    [_lightRuleLabel setFont:[UIFont systemFontOfSize: lightRuleLabelSize]];
    [self addSubview:_lightRuleLabel];
    [_lightRuleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.equalTo(@70);
    }];
    
    
    _lightButton = [[UIButton alloc] init];
    [_lightButton setTitle:@"去点亮" forState:UIControlStateNormal];
    [_lightButton.titleLabel setFont: [UIFont systemFontOfSize: lightButtonLabelSize]];
    [_lightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lightButton setBackgroundColor:kColor(64, 178, 236)];
    _lightButton.layer.cornerRadius = 5;
    [_lightButton addTarget:self action:@selector(lightClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_lightButton];
    [_lightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(_contentLabel.mas_bottom).offset(45);
        make.height.mas_equalTo(40);
    }];
    
    _closeButton = [[UIButton alloc] init];
    UIImage* image = [UIImage imageNamed:@"close_"];
    [_closeButton setImage: image forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: _closeButton];
    [_closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(-10);
        make.right.equalTo(self.mas_right).offset(10);
        make.width.equalTo(@27);
        make.height.equalTo(@27);
    }];
}

- (UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint buttonPoint = [_closeButton convertPoint:point fromView:self];
    if ([_closeButton pointInside:buttonPoint withEvent:event]) {
        return _closeButton;
    }
    
    return [super hitTest:point withEvent:event];
}
#pragma mark 关闭
- (void) closeClicked: (UIButton*) sender
{
    NSLog(@"关闭");
    self.closeButtonBlock();
}

#pragma mark 去点亮
- (void) lightClicked: (UIButton*) sender
{
    NSLog(@"去点亮");
    self.lightButtonBlock();
}

#pragma mark 点亮规则
- (void) RuleLabelClicked: (UITapGestureRecognizer *)recognizer
{
    NSLog(@"点亮规则");
}

// 关闭block
- (void) perFormCloseAction: (closeBlock) block
{
    self.closeButtonBlock = block;
}

// 点亮block
- (void) perFormLightAction: (lightBlock) block
{
    self.lightButtonBlock = block;
}

@end
