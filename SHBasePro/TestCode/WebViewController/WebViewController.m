//
//  WebViewController.m
//  SHBasePro
//
//  Created by shenghai on 2017/10/18.
//  Copyright © 2017年 ren. All rights reserved.
//

#import "WebViewController.h"
#import "Masonry.h"

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) UIButton *startBtn;

@property (nonatomic, strong) UIButton *geBtn;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	_webView = [[UIWebView alloc] init];
	_webView.delegate = self;
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://passport.csdn.net/account/login"]];
	[_webView loadRequest:request];
	[self.view addSubview:_webView];
	[_webView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
	
	_startBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 100 -10, 100, 100)];
	_startBtn.backgroundColor = [UIColor redColor];
	[_startBtn setTitle:@"Set" forState:UIControlStateNormal];
	[self.view addSubview:_startBtn];
	[[_startBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
		
		NSString *js_result = [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('password').value='shenghai';"];
		
//		NSString *js = @"document.getElementById('index-kw').value";
//		NSString *pageSource = [_webView stringByEvaluatingJavaScriptFromString:js];
//		NSLog(@"pagesource:%@", pageSource);
	}];
	
	_geBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 110, SCREEN_HEIGHT - 110, 100, 100)];
	_geBtn.backgroundColor = [UIColor greenColor];
	[_geBtn setTitle:@"Get" forState:UIControlStateNormal];
	[self.view addSubview:_geBtn];
	
	[[_geBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
		NSString *js = @"window.document.getElementById('password').value";
		NSString *pageSource = [_webView stringByEvaluatingJavaScriptFromString:js];
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"输入框内容" message:pageSource delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
		[alertView show];
		
		js = @"window.document.documentElement.innerHTML";
		pageSource = [_webView stringByEvaluatingJavaScriptFromString:js];
		NSLog(@"pagesource:%@", pageSource);

	}];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
	NSString *js = @"document.documentElement.innerHTML";
	NSString *pageSource = [_webView stringByEvaluatingJavaScriptFromString:js];
	NSLog(@"pagesource:%@", pageSource);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
