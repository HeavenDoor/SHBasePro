//
//  TestLoginViewController.m
//  SHBasePro
//
//  Created by shenghai on 2017/11/23.
//  Copyright © 2017年 ren. All rights reserved.
//

#import "TestLoginViewController.h"
#import "RWDummySignInService.h"

@interface TestLoginViewController ()

@property (nonatomic, strong) UITextField *userNameInput;

@property (nonatomic, strong) UITextField *passWordInput;

@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation TestLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

- (void)createUI {
    _userNameInput = [UITextField new];
    _userNameInput.layer.borderWidth = 1;
    _userNameInput.layer.borderColor = RGBGRAY(212).CGColor;
    _userNameInput.layer.cornerRadius = 3;
    [_userNameInput setPlaceholder:@"请输入用户名"];
    [self.view addSubview:_userNameInput];
    
    _passWordInput = [UITextField new];
    _passWordInput.layer.borderWidth = 1;
    _passWordInput.layer.borderColor = RGBGRAY(212).CGColor;
    _passWordInput.layer.cornerRadius = 3;
    [_passWordInput setPlaceholder:@"请输入密码"];
    [self.view addSubview:_passWordInput];
    
    _loginButton = [UIButton new];
    //_loginButton.backgroundColor = RGBCOLOR(47, 234, 212);
    
    _loginButton.backgroundColor = RGBGRAY(232);
    
    [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.view addSubview:_loginButton];

    
    [_userNameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.top.equalTo(self.view.mas_centerY).offset(-150);
        make.height.mas_equalTo(@40);
    }];
    
    [_passWordInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_userNameInput);
        make.height.mas_equalTo(_userNameInput);
        make.top.equalTo(_userNameInput.mas_bottom).offset(10);
    }];
    
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_userNameInput);
        make.height.mas_equalTo(_userNameInput);
        make.top.equalTo(_passWordInput.mas_bottom).offset(10);
    }];
    
    [self createUIEvent];
}

- (void)createUIEvent {
    RACSignal *userNameSignal = [_userNameInput.rac_textSignal map:^id(NSString *text) {
        return @([self isInputValid:self.userNameInput]);
    }];
    
    RACSignal *passwordSignal = [[_passWordInput rac_textSignal] map:^id(NSString *text) {
        return @([self isInputValid:self.passWordInput]);
    }];
    
    RAC(_userNameInput, backgroundColor) = [userNameSignal map:^id(NSNumber * value) {
        return value.boolValue == YES ? [UIColor whiteColor] : RGBCOLOR(248, 241, 0);
    }];
    
    RAC(_passWordInput, backgroundColor) = [passwordSignal map:^id(NSNumber *value) {
        return value.boolValue == YES ? [UIColor whiteColor] : RGBCOLOR(248, 241, 0);
    }];
    
    
    RACSignal *buttonSignal = [RACSignal combineLatest:@[userNameSignal, passwordSignal] reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid){
        return @(usernameValid.boolValue && passwordValid.boolValue);
    }];
    [buttonSignal subscribeNext:^(NSNumber *value) {
        _loginButton.enabled = value.boolValue;
        _loginButton.backgroundColor = value.boolValue == YES ? RGBCOLOR(47, 234, 212) : RGBGRAY(232);
    }];

    
    [[[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^RACStream *(id value) {
        return [self loginSignal];
    }] subscribeNext:^(NSNumber *result) {
        NSLog(@"login btn clicked");
        if (result.boolValue == YES) {
            NSLog(@"Login success");
            [self test];
        } else {
            NSLog(@"Login faile");
            [self test];
        }
    }];
}

- (void)test {
    
    
    // 创建信号A  
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {  
        // 发送请求  
        //        NSLog(@"----发送上部分请求---afn");  
        
        [subscriber sendNext:@"上部分数据"];  
        [subscriber sendCompleted]; // 必须要调用sendCompleted方法！  
        return nil;  
    }];  
    
    // 创建信号B，  
    RACSignal *signals2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {  
        // 发送请求  
        //        NSLog(@"--发送下部分请求--afn");  
        [subscriber sendNext:@"下部分数据"];  
        return nil;  
    }];  
    
    
    // concat:按顺序去链接  
    //**-注意-**：concat，第一个信号必须要调用sendCompleted  
    // 创建组合信号  
    RACSignal *concatSignal = [signals2 concat:signal1];  
    // 订阅组合信号  
    [concatSignal subscribeNext:^(id x) {  
        NSLog(@"%@",x);  
    }]; 
    
    
    
    RACSubject *signalA = [RACSubject subject];  
    // 创建信号B  
    RACSubject *signalB = [RACSubject subject];  
    // 压缩成一个信号  
    // **-zipWith-**: 当一个界面多个请求的时候，要等所有请求完成才更新UI  
    // 等所有信号都发送内容的时候才会调用  
    RACSignal *zipSignal = [signalA zipWith:signalB];  
    [zipSignal subscribeNext:^(id x) {  
        NSLog(@"%@", x); //所有的值都被包装成了元组  
    }];  
    
    // 发送信号 交互顺序，元组内元素的顺序不会变，跟发送的顺序无关，而是跟压缩的顺序有关[signalA zipWith:signalB]---先是A后是B  
    [signalA sendNext:@1];  
    [signalB sendNext:@2];
    
    RACSubject *letters1 = [RACSubject subject];
    RACSubject *numbers1 = [RACSubject subject];
    RACSubject *chinese = [RACSubject subject];
    
    [[RACSignal merge:@[letters1, numbers1, chinese]] subscribeNext:^(id x) {
        NSLog(@"deal with %@", x);
    } completed:^{
        NSLog(@"deal with complete");
    }];
    
    
    [[letters1 concat:chinese] subscribeNext:^(id x) {
        NSLog(@"deal with concat");
    }];
    
    [letters1 sendNext:@"AAA"];
    [letters1 sendCompleted];
    [numbers1 sendNext:@"666"];
    [numbers1 sendCompleted];
    [chinese sendNext:@"你好！"];
    [chinese sendCompleted];
    
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    [[RACSignal
      combineLatest:@[letters, numbers]
      reduce:^(NSString *letter, NSString *number){
          return [letter stringByAppendingString:number];
      }]
     subscribeNext:^(NSString * x) {
         NSLog(@"%@", x);
     }];
    
    //B1 C1 C2
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
    
    
    [[[@[@"you", @"are", @"beautiful"] rac_sequence].signal
      map:^id(NSString * value) {
          return [value capitalizedString];
      }] subscribeNext:^(id x) {
          NSLog(@"capitalizedSignal --- %@", x);
      }];
}

- (RACSignal *)loginSignal {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [[RWDummySignInService alloc] signInWithUsername:_userNameInput.text password:_passWordInput.text complete:^(BOOL value) {
            [subscriber sendNext:@(value)];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
    return signal;
}

- (BOOL)isInputValid:(UITextField *)textField {
    if (textField.text.length >= 3) {
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
