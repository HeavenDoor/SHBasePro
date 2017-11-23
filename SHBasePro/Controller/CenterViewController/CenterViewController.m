//
//  CenterViewController.m
//  SHBasePro
//
//  Created by shenghai on 16/9/2.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "CenterViewController.h"
#import "Masonry.h"
#import "UIImage+SHBasePro.h"
#import "MessageSenderViewController.h"
#import "SGScanningQRCodeVC.h"
#import "RequestViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CenterViewController()<UITableViewDelegate>

@property(nonatomic, strong) UIView* navigationView;
@property(nonatomic, strong) UIView* centerview;

@property(strong, nonatomic) UIButton* preTestBtn;
@property(strong, nonatomic) UIButton* backTestBtn;

@property(nonatomic, strong) UIImageView* imgView;

@property(nonatomic, strong) UIWindow *keyWindow;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, copy) NSString *racStr;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) RequestViewModel *requesViewModel;


@end


@implementation CenterViewController

- (void)dealloc {
    NSLog(@"%@", [NSString stringWithFormat:@"释放了 %@",[self class]]);
}



- (void) viewDidLoad {
    [super viewDidLoad];
    _racStr = @"shenghairren";
    
    // 1.创建信号
    
    RACSignal *sig = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"456"];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"销毁了");
        }];
    }];
    
    
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        
        // 2.发送信号
        [subscriber sendNext:@1];
        
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            
            // 执行完Block后，当前信号就不在被订阅了。
            
            NSLog(@"信号被销毁");
            
        }];
    }];
    
    // 3.订阅信号,才会激活信号.
    [siganl subscribeNext:^(id x) {
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];
    
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationView = [[UIView alloc] init];
    [self.view addSubview:self.navigationView];
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(@64);
    }];
    
    UIImageView* imageView = [[UIImageView alloc] init];
    [imageView setImage:[UIImage imageNamed:@"navi_bg_64.png"]];
    [self.navigationView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.navigationView);
    }];

    UIButton *backBtn = [[UIButton alloc] init];
    [self.navigationView addSubview: backBtn];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_btn_ios7"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnPre:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.navigationView);
        make.left.equalTo(self.navigationView.mas_left).offset(10);
        make.top.equalTo(self.navigationView.mas_top).offset(20);
        make.height.mas_equalTo(@44);
        make.width.mas_equalTo(@44);
    }];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    tableView.dataSource = self.requesViewModel;
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    // 执行请求
    RACSignal *requesSiganl = [self.requesViewModel.reuqesCommand execute:nil];
    
    // 获取请求的数据
    [requesSiganl subscribeNext:^(NSArray *x) {
        
        self.requesViewModel.models = x;
        
        [self.tableView reloadData];
        
    }];
    
    
    /*self.preTestBtn = [[UIButton alloc] init];
    self.preTestBtn.backgroundColor = [UIColor grayColor];
    self.preTestBtn.layer.borderWidth = 1;
    self.preTestBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.preTestBtn.layer.cornerRadius = 4;
    [self.preTestBtn setTitle:@"AAA" forState:UIControlStateNormal];
//    [self.preTestBtn addTarget:self action:@selector(preTestBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.preTestBtn];
    [self.preTestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).multipliedBy(0.5);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(@130);
        make.height.mas_equalTo(@75);
    }];

    @weakify(self)
    [[self.preTestBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        self.racStr = [NSString stringWithFormat:@"zhang %d",arc4random_uniform(100)];
    }];
    
    self.backTestBtn = [[UIButton alloc] init];
    self.backTestBtn.backgroundColor = [UIColor grayColor];
    self.backTestBtn.layer.borderWidth = 1;
    self.backTestBtn.layer.borderColor = [UIColor greenColor].CGColor;
    self.backTestBtn.layer.cornerRadius = 4;
    [self.backTestBtn setTitle:@"BBB" forState:UIControlStateNormal];
    [self.backTestBtn addTarget:self action:@selector(backTestBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backTestBtn];
    [self.backTestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX).multipliedBy(1.5);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.mas_equalTo(@130);
        make.height.mas_equalTo(@75);
    }];
    

    _label = [[UILabel alloc] init];
    _label.font = [UIFont systemFontOfSize:18];
    _label.textColor = [UIColor redColor];
    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_preTestBtn.mas_top).offset(-100);
    }];
    _label.text = _racStr;
    [RACObserve(self, racStr) subscribeNext:^(id x) {
        @strongify(self)
        self.label.text = x;
    }];
    */
}

- (void) backBtnPre: (UIButton*) btn {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) preTestBtnAction: (UIButton*) sender {
    //[self performSelector:@selector(ggw) withObject:nil];
    MessageSenderViewController* VC = [[MessageSenderViewController alloc] init];
    //UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:self];
    
    //[self.presentingViewController presentViewController:VC animated:YES completion:nil];
    [(UINavigationController*)(self.parentViewController) pushViewController:VC animated:YES];
    
    
}

- (RequestViewModel *)requesViewModel {
    if (_requesViewModel == nil) {
        _requesViewModel = [[RequestViewModel alloc] init];
    }
    return _requesViewModel;
}


@end
