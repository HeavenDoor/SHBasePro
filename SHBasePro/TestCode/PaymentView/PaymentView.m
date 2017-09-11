//
//  PaymentView.m
//  HaofangLinkage
//
//  Created by shenghai on 2017/2/6.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import "PaymentView.h"
#import "UIButton+Block.h"

@interface PaymentView ()

@property(nonatomic, strong) UIButton *weChatBtn;
@property(nonatomic, strong) UIButton *aliPayBtn;
@property(nonatomic, strong) UILabel *titleLabel;

@end


@implementation PaymentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initUI];
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 8;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"请选择支付方式";
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _titleLabel.textColor = RGBCOLOR(64, 64, 64);
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    _weChatBtn = [[UIButton alloc] init];
    [_weChatBtn setImage:[UIImage imageNamed:@"wechat_"] forState:UIControlStateNormal];
    [_weChatBtn setTitle:@"微信" forState:UIControlStateNormal];
    [_weChatBtn setTitleColor:RGBCOLOR(64, 64, 64) forState:UIControlStateNormal];
    [_weChatBtn setTitleEdgeInsets:UIEdgeInsetsMake(57, -43, 0, 0)];
    [_weChatBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 21.5, 28, 21.5)];
    //_weChatBtn.imageEdgeInsets = UIEdgeInsetsMake(15, 21.5, 28, 21.5);
    [self addSubview:_weChatBtn];

    LazyWeakSelf;
    [_weChatBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (weakSelf.payMentSelectBlock) {
            weakSelf.payMentSelectBlock(PaymentTypeWeChat);
        }
    }];
    [_weChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(-60);
        make.centerY.equalTo(self.mas_centerY).offset(18);
        make.width.mas_equalTo(@86);
        make.height.mas_equalTo(@86);
    }];
    
    _aliPayBtn = [[UIButton alloc] init];
    [_aliPayBtn setImage:[UIImage imageNamed:@"zhifubao_"] forState:UIControlStateNormal];
    [_aliPayBtn setTitle:@"支付宝" forState:UIControlStateNormal];
    [_aliPayBtn setTitleColor:RGBCOLOR(64, 64, 64) forState:UIControlStateNormal];
    [_aliPayBtn setTitleEdgeInsets:UIEdgeInsetsMake(57, -43, 0, 0)];
    [_aliPayBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 21.5, 28, 21.5)];

    [self addSubview:_aliPayBtn];
    [_aliPayBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        if (weakSelf.payMentSelectBlock) {
            weakSelf.payMentSelectBlock(PaymentTypeAliPay);
        }
    }];
    [_aliPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(60);
        make.centerY.equalTo(self.mas_centerY).offset(18);
        make.width.mas_equalTo(@86);
        make.height.mas_equalTo(@86);
    }];
}

//- (void)genOutTradeNumber {
//    LazyWeakSelf;
//    [MBProgressHUD showHUDAddedTo:self animated:YES];
//    NSDictionary *dict = @{@"TOTAL_FEE" : _aliMoney};
//    [WebService jsonRequestWithInfo:dict serviceType:PUBLIC_SERVICE action:@"createAliOrder" succeededBlock:^(NSString *status, id data) {
//        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
//        if (status.integerValue == 1 && [data isKindOfClass:[NSDictionary class]]) {
//            NSString *outTradeNo = [data objectForKey:@"OUT_TRADE_NO"];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (weakSelf.payMentSelectBlock) {
//                    weakSelf.payMentSelectBlock(PaymentTypeAliPay, outTradeNo);
//                }
//            });
//        } else {
//            // 是字符串在处理，否则不予处理
//            if ([data isKindOfClass:[NSString class]]) {
//                [MBProgressHUD showError:data toView:weakSelf];
//            }
//        }
//    } errorBlock:^(NSString *status, id data) {
//        [MBProgressHUD hideHUDForView:weakSelf animated:YES];
//        
//        // 是字符串在处理，否则不予处理
//        if ([data isKindOfClass:[NSString class]]) {
//            [MBProgressHUD showError:data toView:weakSelf];
//        }
//    }];
//}

@end
