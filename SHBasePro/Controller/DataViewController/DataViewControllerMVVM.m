//
//  DataViewControllerMVVM.m
//  SHBasePro
//  数据窗口控制器
//  Created by mac on 16/8/5.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "DataViewControllerMVVM.h"
#import "DataCellMvvm.h"
#import "AppDelegate.h"

#import "DataViewControllerModule.h"
#import "PresentableViewModel.h"

static NSString* DataViewCellIdentifierMVVM = @"DataViewCellIdentifierMVVM";

@interface DataViewControllerMVVM () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* dataArray;
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation DataViewControllerMVVM


//- (void) setBackgroundColor: (UIColor*) bgColor {
//    self.view.backgroundColor = bgColor;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.bgImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"databg"]];
//    self.bgImg.frame = self.view.frame;
//    [self.view addSubview:self.bgImg];
    self.pageIndex = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[DataCellMvvm class] forCellReuseIdentifier:DataViewCellIdentifierMVVM];
    
    self.dataArray = [NSMutableArray array];
    
    
    WEAK_SELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestDataList:NO];
    }];
    
    self.tableView.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf requestDataList:YES];
    }];
    
    self.tableView.tableFooterView.hidden = YES;
    [self requestDataList:NO];
}

- (void) requestDataList: (BOOL) append
{
    /*NSString* currentIndex = @"1";
    if (append == YES) {
        currentIndex = [NSString stringWithFormat:@"%ld", self.pageIndex + 1];
    }
    WEAK_SELF;
    [DataModelRequest requestVMovieList:currentIndex succeedBlock:^(NSArray<MovieModel*>* data) {
        if (append == NO) {
            [weakSelf.dataArray removeAllObjects];
            
            [weakSelf.dataArray addObjectsFromArray:data];
        }
        else {
            [weakSelf.dataArray addObjectsFromArray:data];
        }
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        
        if (data.count < 10) {
            weakSelf.tableView.mj_header.state = MJRefreshStateNoMoreData;
        }
        else {
            weakSelf.tableView.mj_header.state = MJRefreshStateIdle;
        }
        [weakSelf.tableView reloadData];
    } failerBlock:^(id model) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];*/
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return kUIScaleSize(80);
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataCellMvvm* cell = [tableView dequeueReusableCellWithIdentifier:DataViewCellIdentifierMVVM];

    if (self.dataArray.count > indexPath.row) {
        // 这里 PresentableViewModel 有耦合
        PresentableViewModel* model = [[PresentableViewModel alloc] initWithData:[self.dataArray objectAtIndex:indexPath.row]];
        //[model setTitle:@"掌上好房通，赚钱更轻松"];
        [cell updateWithPresenter: model];
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
