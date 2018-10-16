//
//  JYXSpecialtyApproveViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/29.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXSpecialtyApproveViewController.h"
#import "JYXSpecialtyApproveTableViewCell.h"
#import "JYXHomeTeacherSubjectListApi.h"
#import "JYXAddEditSpecialtyApproveViewController.h"

@interface JYXSpecialtyApproveViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) UIButton *addApproveBtn;
@end

@implementation JYXSpecialtyApproveViewController
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
    [self loadData];
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
    self.navigationItem.title = NSLocalizedString(@"专业认证", nil);
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
    }];
    
    [self.view addSubview:self.addApproveBtn];
    [self.addApproveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(17);
        make.right.equalTo(self.view).offset(-17);
        make.height.offset(35);
        make.top.equalTo(self.tableView.mas_bottom).offset(30);
        make.bottom.equalTo(self.view).offset(-30);
    }];
}

- (void)loadData
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherSubjectListApi *api = [[JYXHomeTeacherSubjectListApi alloc] initWithUserid:user.userId WithToken:user.token];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSArray *array = [api fetchDataWithReformer:request];
        self.dataSourceArray = [array mutableCopy];
        [self.tableView reloadData];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - eventResponse                - Method -
- (void)submitAction:(UIButton *)btn
{
    if (self.dataSourceArray.count >= 5) {
        [MBProgressHUD showInfoMessage:NSLocalizedString(@"最多只能添加五个专业认证！", nil)];
        return;
    }
    JYXAddEditSpecialtyApproveViewController *vc = [[JYXAddEditSpecialtyApproveViewController alloc] init];
    vc.specialtyApprove = SpecialtyApproveAdd;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXAddEditSpecialtyApproveViewController *vc = [[JYXAddEditSpecialtyApproveViewController alloc] init];
    vc.specialtyApprove = SpecialtyApproveEdit;
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithDictionary:self.dataSourceArray[indexPath.row]];
    [dictM setValue:@(self.dataSourceArray.count+1) forKey:@"approveCount"];
    [vc setResult:dictM];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXSpecialtyApproveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXSpecialtyApproveTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXSpecialtyApproveTableViewCell *mCell = (JYXSpecialtyApproveTableViewCell *)cell;
    [mCell configSpecialtyApproveCellWithData:self.dataSourceArray[indexPath.row]];
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
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 45;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = EdgeInsets(8, 0, 0, 0);
        
        [_tableView registerClass:[JYXSpecialtyApproveTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXSpecialtyApproveTableViewCell class])];
    }
    return _tableView;
}

- (UIButton *)addApproveBtn
{
    if (!_addApproveBtn) {
        _addApproveBtn = [[UIButton alloc] init];
        _addApproveBtn.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        [_addApproveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addApproveBtn setTitle:NSLocalizedString(@"添加专业认证", nil) forState:UIControlStateNormal];
        _addApproveBtn.titleLabel.font = FONT_SIZE(15);
        _addApproveBtn.layer.cornerRadius = 18;
        _addApproveBtn.layer.masksToBounds = YES;
        [_addApproveBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addApproveBtn;
}

@end
