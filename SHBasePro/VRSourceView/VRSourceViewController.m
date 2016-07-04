//
//  VRSourceViewController.m
//  SHBasePro
//
//  Created by shenghai on 16/5/23.
//  Copyright © 2016年 ren. All rights reserved.
//



#import "VRSourceViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>
/**
 *  设置陀螺仪数据
 *
 */
- (void)setGyroscopeInfo:(NSString *)str;
@end

@interface VRSourceViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, weak)  JSContext *jsContext;
@end

@implementation VRSourceViewController



// 打开陀螺仪
- (void)openGyroscope: (BOOL) bOpen
{
    if (bOpen == YES) {
        JSValue *value =_jsContext[@"openGyroscope"];
        [value callWithArguments:nil];
    }
    else
    {
        
    }
}

// 打开指南针旋转
- (void)openCompass : (BOOL) bOpen
{
    if (bOpen == YES) {
        JSValue *value =_jsContext[@"openCompass"];
        [value callWithArguments:nil];
    }
    else
    {
        
    }
}

// 打开VR
- (void)openVRScene : (BOOL) bOpen
{
    if (bOpen == YES) {
        JSValue *value =_jsContext[@"openVRScene"];
        [value callWithArguments:nil];
    }
    else
    {
        
    }
}


- (void)webView:(UIWebView *)webView didCreateJavaScriptContext:(JSContext*) ctx
{
    self.jsContext = ctx;
    __weak typeof(self) weakSelf = self;
    _jsContext[@"vrSource"] = weakSelf;
    _jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"error：%@", exceptionValue);
    };
}

// ////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    // 隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self initWebView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [_webview reload];
}

#pragma mark 隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - 加载webView
- (void)initWebView
{
    NSURL *url = [NSURL URLWithString:_urlStr];
    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_webview];
    [_webview setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webview.delegate = self;
    _webview.backgroundColor = [UIColor whiteColor];
    [_webview loadRequest:request];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
