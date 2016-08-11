//
//  ContactMethodAlertView.m
//  UUHaoFang
//
//  Created by 正合适 on 16/7/2.
//  Copyright © 2016年 heyk. All rights reserved.
//

#import "ContactMethodAlertView.h"

#define BUTTON_TAG 100
#define VIEW_TAG 200
#define FORBIDDEN !_imageArray || !_titleArray || _imageArray.count == 0 || _titleArray.count == 0 || _imageArray.count != _titleArray.count
@interface ContactMethodAlertView()
@property (nonatomic, strong) NSArray *imageArray;// 图片数组
@property (nonatomic, strong) NSArray *titleArray;// 标题数组
@property (nonatomic, strong) UIButton* closeButton; // 关闭按钮
@end
@implementation ContactMethodAlertView
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)imageArray titles:(NSArray *)titleArray {
    self = [super initWithFrame:frame];
    if (self) {
        _backgroundViewColor = [UIColor blackColor];
        _canTapBG = YES;
        _imageArray = imageArray;
        _titleArray = titleArray;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self initializeUserinterface];
            }
    return self;
}

#pragma mark - 加载界面
- (void)initializeUserinterface {
    self.backgroundColor = [UIColor clearColor];
    // 参数错误就不执行
    if (FORBIDDEN) {
        return;
    }

    // 手势点击
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    view.backgroundColor = _backgroundViewColor;
    view.alpha = 0.4;
    view.tag = VIEW_TAG;
    [self addSubview:view];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTaped)];
    [view addGestureRecognizer:tapGesture];
    
    
    // 容器view
    UIView *containtView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width-50, self.frame.size.width-20)];
    containtView.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY([UIScreen mainScreen].bounds));
    containtView.backgroundColor = [UIColor whiteColor];
    containtView.layer.cornerRadius = 2;
    [self addSubview:containtView];
    
    _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* btnImg = [UIImage imageNamed:@"close_"];
    [_closeButton setImage:btnImg forState:UIControlStateNormal];
    [containtView addSubview:_closeButton];
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((containtView.frame.size.width-120)/2, 50, 120, 17)];
//    titleLabel.center = CGPointMake(CGRectGetMidX(self.frame), titleLabel.centerY);
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"选择联系方式";
    [containtView addSubview:titleLabel];
    
    // 分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((containtView.frame.size.width-(containtView.frame.size.width-60))/2, CGRectGetMidY(titleLabel.frame), containtView.frame.size.width-60, 0.5)];
//    lineView.center = CGPointMake(lineView.centerX, titleLabel.centerY);
    lineView.backgroundColor = [UIColor getColor:@"#bbbbbb"];
    [containtView insertSubview:lineView belowSubview:titleLabel];
    
    
    // 加载图片及标题
    CGFloat buttonWidth = containtView.frame.size.width/_imageArray.count;
    CGFloat buttonHeight = kUIScaleSize(70);
    for (NSInteger i = 0; i < _imageArray.count; i ++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0+i*buttonWidth, CGRectGetMaxY(titleLabel.frame)+60, buttonWidth, buttonHeight)];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_imageArray[i]] forState:UIControlStateNormal];
        button.tag = BUTTON_TAG + i;
        
        button.imageEdgeInsets = UIEdgeInsetsMake(-button.imageView.size.height/2+18, button.titleLabel.size.width/2, button.imageView.size.height/2, -button.titleLabel.size.width/2);
        button.titleEdgeInsets = UIEdgeInsetsMake(button.titleLabel.size.height/2+18, -button.imageView.size.width, -button.titleLabel.size.height/2-12, 0);
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [containtView addSubview:button];
    }
    UIButton *button = (UIButton *)[self viewWithTag:BUTTON_TAG];
    containtView.height = CGRectGetMaxY(button.frame)+65;
    containtView.centerY = [UIScreen mainScreen].bounds.size.height/2;// - containtView.height/2;
    
    _closeButton.frame = CGRectMake(containtView.width - btnImg.size.width/2 - 3, - btnImg.size.height/2 + 3, btnImg.size.width, btnImg.size.height);
    [containtView bringSubviewToFront:_closeButton];
    [_closeButton addTarget:self action:@selector(closeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 关闭按钮点击
- (void) closeButtonClicked: (UIButton*) sender
{
    [self dismiss];
}

- (UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint pt = [_closeButton convertPoint:point fromView:self];
    if ([_closeButton pointInside:pt withEvent:event])
    {
        return _closeButton;
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - 按钮Action
- (void)buttonAction:(UIButton *)sender {
    NSInteger index = sender.tag - BUTTON_TAG;
    if (self.delegate && [self.delegate respondsToSelector:@selector(contactButtonTapedWithIndex:)]) {
        [self.delegate contactButtonTapedWithIndex:index];
    }
    [self dismiss];
}

#pragma mark - 背景点击Action
- (void)backgroundViewTaped {
    if (_canTapBG) {
        [self dismiss];
    } else {
        return;
    }
}

#pragma mark - 出现Action
- (void)show {
    if (FORBIDDEN) {
        return;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

#pragma mark - 消失Action
- (void)dismiss {
    [self removeFromSuperview];
}

#pragma mark - setter
- (void)setBackgroundViewColor:(UIColor *)backgroundViewColor {
    _backgroundViewColor = backgroundViewColor;
    self.backgroundColor = _backgroundViewColor;
    UIView *view = (UIView *)[self viewWithTag:VIEW_TAG];
    view.backgroundColor = _backgroundViewColor;
    view.alpha = 1;
}

- (void)setCanTapBG:(BOOL)canTapBG {
    _canTapBG = canTapBG;
}
@end
