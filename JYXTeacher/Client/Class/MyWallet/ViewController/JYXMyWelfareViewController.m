//
//  JYXMyWelfareViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMyWelfareViewController.h"
#import "JYXMyWelfareTableViewCell.h"
#import "JYXHomeTeacherTeachergoodsListApi.h"

@interface JYXMyWelfareViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) UILabel     *lb_noData;
@end

@implementation JYXMyWelfareViewController
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
    self.navigationItem.title = NSLocalizedString(@"我的福利", nil);
    
    self.lb_noData = [[UILabel alloc]init];
    [self.view addSubview:self.lb_noData];
    [self.lb_noData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view).offset(-50);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(20);
    }];
    [self.lb_noData setText:@"您暂时没有福利"];
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
    JYXHomeTeacherTeachergoodsListApi *api = [[JYXHomeTeacherTeachergoodsListApi alloc] initWithUserid:user.userId WithToken:user.token];
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
    }];
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXMyWelfareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXMyWelfareTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configMyWelfareCellWithData:self.dataSourceArray[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

#pragma mark - getters and setters          - Method -
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 113;
        
        [_tableView registerClass:[JYXMyWelfareTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXMyWelfareTableViewCell class])];
    }
    return _tableView;
}

@end
