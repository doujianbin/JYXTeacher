//
//  JYXShareListChildViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXShareListChildViewController.h"
#import "JYXShareListTableViewCell.h"
#import "MyHandler.h"

@interface JYXShareListChildViewController ()<UITableViewDelegate, UITableViewDataSource,BaseTableViewDelagate>
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation JYXShareListChildViewController
#pragma mark - lifeCycle                    - Method -

- (void)dealloc
{
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSourceArray = [[NSMutableArray alloc]init];
    }
    return self;
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
//    [self loadData];
    self.title = @"已共享列表";
//    UIImage *backgroundImage = [UIImage imageNamed:@"navBarBg"];
//    backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
//    UIImage *shadowImage = [UIImage imageWithColor:[UIColor clearColor]
//                                              size:CGSizeMake(self.navigationController.navigationBar.size.width, 0.5)];
//
//    UIColor *titleColor = [UIColor colorWithHex:0xffffff];
//
//    [self.navigationController.navigationBar setBackgroundImage:backgroundImage
//                                                  forBarMetrics:UIBarMetricsDefault];
//
//    [self.navigationController.navigationBar setShadowImage:shadowImage];
//
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : titleColor,
//                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    [self.tableView requestDataSource];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    [MyHandler getShareListDataPrepare:^{
        
    } success:^(id obj) {
        [self.dataSourceArray addObjectsFromArray:(NSArray *)obj];
        if (self.dataSourceArray.count == 0) {
            self.tableView.defaultView = [[TableBackgroudView alloc] initWithFrame:self.tableView.frame withDefaultImage:nil withNoteTitle:@"暂无分享数据" withNoteDetail:nil withButtonAction:nil];
        }
        [self.tableView reloadData];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXShareListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXShareListTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configShareListCellWithData:[self.dataSourceArray objectAtIndex:indexPath.row]];
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
        _tableView = [[BaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain hasHeaderRefreshing:NO hasFooterRefreshing:NO];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.tableViewDelegate = self;
        _tableView.rowHeight = 72;
        
        [_tableView registerClass:[JYXShareListTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXShareListTableViewCell class])];
    }
    return _tableView;
}

@end
