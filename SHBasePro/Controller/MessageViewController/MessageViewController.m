//
//  MessageViewController.m
//  SHBasePro
//  消息窗口控制器
//  Created by mac on 16/8/5.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "MessageViewController.h"
#import "DataCell.h"
#import "MessageAPIManager.h"

static NSString* DataViewCellIdentifier = @"DataViewCellIdentifier";

@interface MessageViewController () <UITableViewDataSource, UITableViewDelegate, CTAPIManagerParamSource, CTAPIManagerCallBackDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* dataArray;
//@property (nonatomic, assign) NSInteger pageIndex;
@property(nonatomic, strong) MessageAPIManager *msgAPIManager;
@end

@implementation MessageViewController


- (void) setBackgroundColor: (UIColor*) bgColor {
    self.view.backgroundColor = bgColor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.msgAPIManager = [[MessageAPIManager alloc] init];
    self.msgAPIManager.delegate = self;
    self.msgAPIManager.paramSource = self;
    //self.pageIndex = 1;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.dataArray = [NSMutableArray array];
    WEAK_SELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.msgAPIManager loadData];
    }];
    
    self.tableView.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.msgAPIManager loadData];
    }];
    
    self.tableView.tableFooterView.hidden = YES;
    [self.msgAPIManager loadData];
}

- (void) requestDataList: (BOOL) append
{
    
    /*NSString* currentIndex = @"1";
     if (append == YES) {
     currentIndex = [NSString stringWithFormat:@"%ld", self.pageIndex + 1];
     }
     WEAK_SELF;
     [DataModelRequest requestVMovieList:currentIndex succeedBlock:^(NSArray<MovieModel*>* data) {
     
     }];*/
}

#pragma mark - CTAPIManagerParamSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager {
    NSDictionary *params = @{};
    if (manager == self.msgAPIManager) {
        params = @{@"p" : @"1", @"tab" : @"latest"};
    }
    return params;
}

#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager {
    if (manager == self.msgAPIManager) {
        [self.dataArray removeAllObjects];
        self.dataArray = [manager fetchDataWithReformer:self.msgAPIManager];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (self.dataArray.count < 10) {
            self.tableView.mj_header.state = MJRefreshStateNoMoreData;
        }
        else {
            self.tableView.mj_header.state = MJRefreshStateIdle;
        }
        [self.tableView reloadData];
    }
}

- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager
{
    if (manager == self.msgAPIManager) {
        //self.resultLable.text = @"fail";
        NSLog(@"%@", [manager fetchDataWithReformer:nil]);
        //[self layoutResultLable];
    }
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
    DataCell* cell = [tableView dequeueReusableCellWithIdentifier:DataViewCellIdentifier];
    if (cell == nil) {
        cell = [[DataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DataViewCellIdentifier];
    }
    if (self.dataArray.count > indexPath.row) {
        //cell.cellData = [self.dataArray objectAtIndex:indexPath.row];
        
        MovieModel *data = [self.dataArray objectAtIndex:indexPath.row];
        cell.cellData = data;
        
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
