//
//  JYXTransactionDetailViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXTransactionDetailViewController.h"
#import "JYXTransactionDetailTableViewCell.h"
#import "JYXHomeBasicTranhistoryListApi.h"

@interface JYXTransactionDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) UILabel     *lb_noData;
@end

@implementation JYXTransactionDetailViewController
#pragma mark - lifeCycle                    - Method -

- (void)dealloc
{
    
}

- (void)loadView
{
    [super loadView];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"交易明细", nil);
    
    self.lb_noData = [[UILabel alloc]init];
    [self.view addSubview:self.lb_noData];
    [self.lb_noData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(-50);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    [self.lb_noData setText:@"暂无交易明细数据"];
    [self.lb_noData setTextColor:[UIColor colorWithHexString:@"#6D6D6D"]];
    self.lb_noData.font = [UIFont systemFontOfSize:17];
    [self.lb_noData setTextAlignment:NSTextAlignmentCenter];
    [self.lb_noData setHidden:YES];
    
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)loadData
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeBasicTranhistoryListApi *api = [[JYXHomeBasicTranhistoryListApi alloc] initWithUserid:user.userId WithToken:user.token];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSArray *array = [api fetchDataWithReformer:request];
        if (array.count == 0) {
            [self.lb_noData setHidden:NO];
        }else{
            [self.lb_noData setHidden:YES];
        }
        self.dataSourceArray = [array mutableCopy];
        [self.tableView reloadData];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        [self.lb_noData setHidden:YES];
    }];
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXTransactionDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXTransactionDetailTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXTransactionDetailTableViewCell *mCell = (JYXTransactionDetailTableViewCell *)cell;
    [mCell configTransactionDetailCellWithData:self.dataSourceArray[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

#pragma mark - getters and setters          - Method -
- (NSMutableArray *)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 45;
        
        [_tableView registerClass:[JYXTransactionDetailTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXTransactionDetailTableViewCell class])];
    }
    return _tableView;
}

@end
