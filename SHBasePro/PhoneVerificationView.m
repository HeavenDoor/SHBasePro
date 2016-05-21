//
//  PhoneVerificationView.m
//  HaofangLinkagePhone
//
//  Created by SL on 16/1/22.
//  Copyright © 2016年 成都好房通科技有限公司. All rights reserved.
//

#import "PhoneVerificationView.h"

@interface PhoneVerificationView () <UITextFieldDelegate>

//取消Button
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

//电话显示label
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;

//左边的filed
@property (weak, nonatomic) IBOutlet UITextField *leftTxtFed;

//右边的filed
@property (weak, nonatomic) IBOutlet UITextField *rightTxtFed;

//显示颜色的view
@property (weak, nonatomic) IBOutlet UIView *addView;

//电话号码
@property (nonatomic, strong) NSString *phoneNumber;

//确定按钮
@property (weak, nonatomic) IBOutlet UIButton *sumbitBtn;

@end

@implementation PhoneVerificationView

- (void)awakeFromNib
{
    //设置AddView
    //_addView.layer.cornerRadius = 3.f;
    _addView.layer.masksToBounds = YES;
    
    //_leftTxtFed.layer.cornerRadius = 2.5f;
    _leftTxtFed.layer.masksToBounds = YES;
    
    //_rightTxtFed.layer.cornerRadius = 2.5f;
    _rightTxtFed.layer.masksToBounds = YES;
}

- (void)dealloc
{
    [_leftTxtFed removeTarget:self action:@selector(leftEdit:) forControlEvents:UIControlEventEditingChanged];
    [_rightTxtFed removeTarget:self action:@selector(rightEdit:) forControlEvents:UIControlEventEditingChanged];
}

//设置显示前9位的电话号码
- (void)setCustomer:(NSString*) phone
{

    
    NSArray *arr = [phone componentsSeparatedByString:@"*"];
    
    _phoneNumber = arr[0];
    
    //判断是不是有9位
    if (_phoneNumber.length > 8)
    {
        NSString *txt1 = [_phoneNumber substringWithRange:(NSRange){0, 3}];
        NSString *txt2 = [_phoneNumber substringWithRange:(NSRange){3, 4}];
        NSString *txt3 = [_phoneNumber substringWithRange:(NSRange){7, 2}];
        _phoneNum.text = [NSString stringWithFormat:@"%@ %@ %@", txt1, txt2, txt3];
        
        switch (_phoneNumber.length)
        {
            case 9:
                //添加两个按钮的事件
                [self addTextFeildEvent];
                break;
            case 10:
            case 11:
            {
                _leftTxtFed.text = [_phoneNumber substringWithRange:NSMakeRange(9, 1)];
                _leftTxtFed.enabled = NO;
                _leftTxtFed.textColor = [UIColor lightGrayColor];
                if (_phoneNumber.length == 11)
                {
                    _rightTxtFed.text = [_phoneNumber substringWithRange:NSMakeRange(10, 1)];
                    _rightTxtFed.enabled = NO;
                    _rightTxtFed.textColor = [UIColor lightGrayColor];
                }
                else
                {
                    [_rightTxtFed addTarget:self action:@selector(rightEdit:) forControlEvents:UIControlEventEditingChanged];
                }
            }
                
                break;
            default:
                break;
        }
        
    }
    else
    {
        //如果没有9位，直接返回
//        if (_delegate && [_delegate respondsToSelector:@selector(cancelTap)])
//        {
//            [_delegate cancelTap];
//        }
    }
    
    [self isEmptyWithTextFiled];
    
}

#pragma mark - 添加两个事件
- (void)addTextFeildEvent
{
    [_leftTxtFed addTarget:self action:@selector(leftEdit:) forControlEvents:UIControlEventEditingChanged];
    
    [_rightTxtFed addTarget:self action:@selector(rightEdit:) forControlEvents:UIControlEventEditingChanged];
    
    _rightTxtFed.delegate = self;
    
}

#pragma mark - 响应事件
- (IBAction)cancelAction:(id)sender
{
//    if (_delegate && [_delegate respondsToSelector:@selector(cancelTap)])
//    {
//        if ([_leftTxtFed isFirstResponder])
//        {
//            [_leftTxtFed resignFirstResponder];
//        }
//        
//        if ([_rightTxtFed isFirstResponder])
//        {
//            [_rightTxtFed resignFirstResponder];
//        }
//        [_delegate cancelTap];
//    }
}

#pragma mark - 确定按钮
- (IBAction)sumbitAction:(id)sender
{
    BOOL result = [self isPureInt:_leftTxtFed.text];
    if (!result)
    {
        //[MBProgressHUD showError:@"手机格式错误" toView:self];
        return;
    }
    
    result = [self isPureInt:_rightTxtFed.text];
    if (!result)
    {
        //[MBProgressHUD showError:@"手机格式错误" toView:self];
        return;
    }
    
    if (result)
    {
        if (_leftTxtFed.text.length > 0 && _rightTxtFed.text.length > 0)
        {
            NSString *phoneNumber;
            switch (_phoneNumber.length) {
                case 9:
                    phoneNumber = [NSString stringWithFormat:@"%@%@%@", self.phoneNumber, self.leftTxtFed.text, self.rightTxtFed.text];
                    break;
                case 10:
                    phoneNumber = [NSString stringWithFormat:@"%@%@", self.phoneNumber, self.rightTxtFed.text];
                    break;
                case 11:
                    phoneNumber = _phoneNumber;
                    break;
                default:
                    break;
            }
            //拼接成整个号码
            
//            if (self.delegate && [self.delegate respondsToSelector:@selector(sumbitActionWithPhoneNumber:)])
//            {
//                [self.delegate sumbitActionWithPhoneNumber:phoneNumber];
//                [self.rightTxtFed resignFirstResponder];
//            }
        }
    }
}

#pragma mark - 左边的filed change
- (void)leftEdit:(UITextField *)filed
{
    NSString *text = filed.text;
    if (text.length > 1)
    {
        //只获取第一位
        text = [text substringWithRange:(NSRange){0, 1}];
    }
    
    //判断是不是整形
    BOOL result = [self isPureInt:text];
    
    if (result)
    {
        //如果是，那么下一个filed成为第一响应者
        filed.text = text;
        
        /*
        if (_leftTxtFed.text.length > 0 && filed.text > 0)
        {
            //拼接成整个号码
            NSString *phoneNumber = [NSString stringWithFormat:@"%@%@%@", self.phoneNumber, self.leftTxtFed.text, self.rightTxtFed.text];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(sumbitActionWithPhoneNumber:)])
            {
                [self.delegate sumbitActionWithPhoneNumber:phoneNumber];
                [self.leftTxtFed resignFirstResponder];
            }
        }
         */
        
        [_rightTxtFed becomeFirstResponder];
    }
    else
    {
        filed.text = @"";
    }
    [self isEmptyWithTextFiled];
}

#pragma mark - 右边的filed change
- (void)rightEdit:(UITextField *)filed
{
    NSString *text = filed.text;
    if (text.length > 1)
    {
        //只获取第一位
        text = [text substringWithRange:(NSRange){0, 1}];
    }
    
    //判断是不是整形
    BOOL result = [self isPureInt:text];
    
    if (result)
    {
        filed.text = text;
    }
    else
    {
        filed.text = @"";
    }
    [self isEmptyWithTextFiled];
}

#pragma mark - textField Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //如果是删除
    if ([string isEqualToString:@""])
    {
        //如果是没有
        if ([textField.text isEqualToString:@""])
        {
            [_leftTxtFed becomeFirstResponder];
            _leftTxtFed.text = @"";
            return NO;
        }
    }
    return YES;
}

#pragma mark - 判断三个选项是否为空
- (void)isEmptyWithTextFiled
{
    //只要其中一个有值
    if (_leftTxtFed.text.length > 0 && _rightTxtFed.text.length > 0)
    {
            //可以点击
            _sumbitBtn.enabled = YES;
            
            //改变颜色
            [_sumbitBtn setImage:[UIImage imageNamed:@"确定"] forState:UIControlStateNormal];
    }
    else
    {
            //不能点击
            _sumbitBtn.enabled = NO;
            
            //改变颜色
            [_sumbitBtn setImage:[UIImage imageNamed:@"确定(灰色)"] forState:UIControlStateNormal];
    }
}

- (BOOL)keyboardShow
{
    BOOL result;
    switch (_phoneNumber.length)
    {
        case 9:
            [_leftTxtFed becomeFirstResponder];
            result = YES;
            break;
        case 10:
            [_rightTxtFed becomeFirstResponder];
            result = YES;
            break;
        case 11:
            result = NO;
            break;
        default:
            result = NO;
            break;
    }
    return result;
}

- (void)keyboardHidden
{
    if ([_leftTxtFed isFirstResponder])
    {
        [_leftTxtFed resignFirstResponder];
    }
    
    if ([_rightTxtFed isFirstResponder])
    {
        [_rightTxtFed resignFirstResponder];
    }
}

#pragma mark - tools
//判断是不是整形
- (BOOL)isPureInt:(NSString *)string
{
    NSScanner *scan = [NSScanner scannerWithString:string];
    
    int val;
    
    //判断是不是整形
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (BOOL)sumbitValidateWithText:(NSString *)text
{
    //验证时候是整数
    BOOL result = [self isPureInt:text];
    
    return  result;
}

@end
