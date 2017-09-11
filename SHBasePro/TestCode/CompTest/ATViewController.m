/*******************************************************************************
 # File        : ATViewController.m
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/5/25
 # Corporation : 成都好房通科技股份有限公司
 # Description :
 <#Description Logs#>
 -------------------------------------------------------------------------------
 # Date        : <#Change Date#>
 # Author      : <#Change Author#>
 # Notes       :
 <#Change Logs#>
 ******************************************************************************/

#import "ATViewController.h"

@implementation ATViewController

#pragma mark ----------------------------- 生命周期 ------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化默认数据
    [self createDefaultData];
    // 初始化界面
    [self createUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)dealloc {
    NSLog(@"=====%@被销毁了=====", [self class]);
}

#pragma mark - 初始化默认数据
- (void)createDefaultData {
    
}

#pragma mark - 初始化界面
- (void)createUI {
    
}


- (void)test {
    NSLog(@"ATViewController test ...");
}

- (void)backAction {
    
}


#pragma mark ----------------------------- 其他方法 ------------------------------

#pragma mark ----------------------------- 网络请求 ------------------------------

#pragma mark ----------------------------- 代理方法 ------------------------------

#pragma mark --------------------------- setter&getter -------------------------


@end
