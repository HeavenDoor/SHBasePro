//
//  SHSearchView.m
//  SHBasePro
//
//  Created by shenghai on 2017/1/10.
//  Copyright © 2017年 ren. All rights reserved.
//

#import "SHSearchView.h"

@interface SHSearchView () <UITextFieldDelegate>

@property (nonatomic, strong) UIView* searchView;
@property (nonatomic, strong) UIImageView* searchImageView;
@property (nonatomic, strong) UIButton* closeBtn;
@property (nonatomic, strong) UITextField* searchFiled;

@end

@implementation SHSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor redColor];
    [self initSearchView];
    return self;
}

- (void)initSearchView {
    self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    self.searchView.backgroundColor = [UIColor whiteColor];
    self.searchView.layer.cornerRadius = 4;
    self.layer.cornerRadius = 4;
    [self addSubview:self.searchView];
    
    self.searchImageView = [[UIImageView alloc] init];
    [self.searchView addSubview:self.searchImageView];
    [self.searchImageView setImage:[UIImage imageNamed:@"robsearch2"]];
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchView.mas_left).offset(10);
        make.centerY.equalTo(self.searchView.mas_centerY);
        make.width.height.mas_equalTo(@15);
    }];
    
    self.closeBtn = [[UIButton alloc] init];
    [self.closeBtn setBackgroundImage:[UIImage imageNamed:@"ic_f_close"] forState:UIControlStateNormal];
    //[self.closeBtn addTarget:self action:@selector(clearSearchConditions:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.searchView.mas_right).offset(-10);
        make.centerY.equalTo(self.searchView.mas_centerY);
        make.width.height.mas_equalTo(@15);
    }];
    self.closeBtn.hidden = YES;
    
    self.searchFiled = [[UITextField alloc] init];
    [self.searchView addSubview:self.searchFiled];
    self.searchFiled.tintColor = RGBCOLOR(0, 67, 254);
    self.searchFiled.backgroundColor = [UIColor whiteColor];
    self.searchFiled.placeholder = @"搜索客户或订单";
    self.searchFiled.delegate = self;
    [self.searchFiled addTarget:self action:@selector(searchFiledValueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.searchFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchImageView.mas_right).offset(5);
        make.centerY.equalTo(self.searchView.mas_centerY);
        make.right.equalTo(self.closeBtn.mas_left).offset(-5);
        make.height.mas_equalTo(@28);
    }];
}

- (void)searchFiledValueChanged:(UITextField*) searchFiled {
    [self searchWithKey:searchFiled.text];
}

- (void)searchWithKey:(NSString *)key {
    NSLog(@"SHSearchView 正在执行复杂的搜索任务");
}

//<search_protocol>:{search()}
//
//SEARCH_LOGIC<search_protocol>
//
//SEARCH_BAR:{textField, SEARCH_LOGIC<search_protocol>}
//
//HOME_SEARCH_BAR:{SearchBar1, SearchLogic1}
//PAGE_SEARCH_BAR:{SearchBar2, SearchLogic1}
//LOCAL_SEARCH_BAR:{SearchBar2, SearchLogic2}

@end
