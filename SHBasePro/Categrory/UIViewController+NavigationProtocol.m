//
//  UIViewController+NavigationProtocol.m
//  Erp4iOS
//
//  Created by shenghai on 2017/5/23.
//  Copyright © 2017年 成都好房通科技股份有限公司. All rights reserved.
//

#import "UIViewController+NavigationProtocol.h"
#import "HFTNavigationProtocol.h"

@implementation UIViewController (NavigationProtocol)

+ (BOOL)gl_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel {
	Method origMethod = class_getInstanceMethod(self, origSel);
	Method altMethod = class_getInstanceMethod(self, altSel);
	if (!origMethod || !altMethod) {
		return NO;
	}
	class_addMethod(self,
					origSel,
					class_getMethodImplementation(self, origSel),
					method_getTypeEncoding(origMethod));
	class_addMethod(self,
					altSel,
					class_getMethodImplementation(self, altSel),
					method_getTypeEncoding(altMethod));
	method_exchangeImplementations(class_getInstanceMethod(self, origSel),
								   class_getInstanceMethod(self, altSel));
	return YES;
}

+ (void)load {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		[self gl_swizzleMethod:@selector(viewWillAppear:) withMethod:@selector(gl_viewWillAppear:)];
		[self gl_swizzleMethod:@selector(viewDidLoad) withMethod:@selector(gl_viewDidLoad)];
		[self gl_swizzleMethod:@selector(setTitle:) withMethod:@selector(gl_setTitle:)];
	});
}

- (void)gl_viewWillAppear:(BOOL)animated {
	if ([self conformsToProtocol:@protocol(HFTNavigationProtocol)]) {
		self.navigationController.navigationBar.translucent = NO;
		
		//自动判断如果是第一次导航栏隐藏否则显示，联动的标签控制栏要另外处理
		if (self.navigationController.viewControllers.count == 1) {
//            NSLog(@"%@",NSStringFromCGRect(self.rdv_tabBarController.tabBar.frame));
//            [self.rdv_tabBarController.tabBar removeFromSuperview];
//            [self.rdv_tabBarController.tabBar setFrame:CGRectMake(0, self.view.bounds.size.height - 49, kScreenWidth, 49)];
//            [self.view addSubview:self.rdv_tabBarController.tabBar];
//            
			[self.navigationController setNavigationBarHidden:YES animated:YES];
		} else {
			[self.navigationController setNavigationBarHidden:NO animated:YES];
		}
		
//		if (self.isHideNaviBar) {
//			[self.navigationController setNavigationBarHidden:YES animated:YES];
//		}
	}
	[self gl_viewWillAppear:animated];
}

- (void)gl_viewDidLoad {
	if ([self conformsToProtocol:@protocol(HFTNavigationProtocol)]) {
		[self.navigationController.navigationBar setClipsToBounds:NO];
		[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_bg_44.png"] forBarMetrics:UIBarMetricsDefault];
		
		//当此控制器不在导航栏底部时添加返回按钮
		NSArray *viewControllers = self.navigationController.viewControllers;
		if (viewControllers.count > 1) {
			UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
			[backBtn setBackgroundImage:[UIImage imageNamed:@"back_btn_ios7"] forState:UIControlStateNormal];
			[backBtn addTarget:self action:@selector(backLastView) forControlEvents:UIControlEventTouchUpInside];
			backBtn.frame = CGRectMake(0, 0, 44, 44);
			UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
			self.navigationItem.leftBarButtonItem = backItem;
			[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_bg_64.png"]forBarMetrics:UIBarMetricsDefault];
		}
		
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
		[titleLabel setTextColor:[UIColor whiteColor]];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		self.navigationItem.titleView = titleLabel;
		
		[self.navigationController.navigationBar setTranslucent:NO];
	}
	[self gl_viewDidLoad];
}

- (void)gl_setTitle:(NSString *)title {
	if ([self conformsToProtocol:@protocol(HFTNavigationProtocol)]) {
		UILabel *titleLabel = [[UILabel  alloc]initWithFrame:CGRectZero];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.font = [UIFont boldSystemFontOfSize:18];
		titleLabel.text = title;
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.textAlignment = NSTextAlignmentCenter;
		[titleLabel sizeToFit];
		self.navigationItem.titleView = titleLabel;
	}
	[self gl_setTitle:title];
}

- (void)backLastView {
	if ([self respondsToSelector:@selector(backAction)]) {
		[self performSelector:@selector(backAction)];
	} else {
		[self.navigationController popViewControllerAnimated:YES];
	}
}


@end
