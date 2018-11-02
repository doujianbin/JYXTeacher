//
//  JYXClassFeeViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXClassFeeViewController.h"
#import "JYXClassFeeTableViewCell.h"
#import "JYXHomeTeacherTeacherMoneyApi.h"
#import "MyHandler.h"
#import "JYXWithdrawViewController.h"

@interface JYXClassFeeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *topTitleLabel;
@property (nonatomic, strong) UILabel *topClassFeeLabel;
@property (nonatomic, strong) UIButton *applyBtn;
@end

@implementation JYXClassFeeViewController
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
    self.navigationItem.title = NSLocalizedString(@"课时费", nil);
    [self loadData];
}

- (void)setupViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.offset(80);
    }];
    
    [self.topView addSubview:self.topTitleLabel];
    [self.topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView);
        make.centerY.equalTo(self.topView).offset(-15);
    }];
    
    [self.topView addSubview:self.topClassFeeLabel];
    [self.topClassFeeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView);
        make.centerY.equalTo(self.topView).offset(12);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom);
    }];
    
    [self.view addSubview:self.applyBtn];
    [self.applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom).offset(13);
        make.height.offset(46);
        make.width.offset(241);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-30);
    }];
    
    [self.applyBtn addTarget:self action:@selector(applyBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadData
{
    
    [MyHandler getTeacherClassMoneyPrepare:^{
        
    } success:^(id obj) {
        NSDictionary *dict = (NSDictionary *)obj;
        self.topClassFeeLabel.text = [NSString stringWithFormat:@"%@",dict[@"money"]];
        self.dataSourceArray = [dict[@"list"] mutableCopy];
        [self.tableView reloadData];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
    //    JYXUser *user = [JYXUserManager shareInstance].user;
    //    JYXHomeTeacherTeacherMoneyApi *api = [[JYXHomeTeacherTeacherMoneyApi alloc] initWithUserid:user.userId WithToken:user.token];
    //    [SVProgressHUD show];
    //    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
    //        [SVProgressHUD dismiss];
    //        NSDictionary *dict = [api fetchDataWithReformer:request];
    //        self.topClassFeeLabel.text = [NSString stringWithFormat:@"%@元",dict[@"money"]];
    //        self.dataSourceArray = [dict[@"list"] mutableCopy];
    //        [self.tableView reloadData];
    //    } failure:^(__kindof RXBaseRequest *request) {
    //        [SVProgressHUD dismiss];
    //    }];
}

#pragma mark - eventResponse                - Method -

- (void)applyBtnAction{
//    if ([self.topClassFeeLabel.text floatValue] < 100) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"低于100元不可以提现" preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//
//        }];
//        [alert addAction:cancel];
//        [self presentViewController:alert animated:YES completion:nil];
//    }else{
//        JYXWithdrawViewController *vc = [[JYXWithdrawViewController alloc]init];
//        vc.money = [self.topClassFeeLabel.text floatValue];
//        vc.tixianfangshi = 4;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    JYXWithdrawViewController *vc = [[JYXWithdrawViewController alloc]init];
    vc.money = [self.topClassFeeLabel.text floatValue];
    vc.tixianfangshi = 4;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXClassFeeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXClassFeeTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXClassFeeTableViewCell *mCell = (JYXClassFeeTableViewCell *)cell;
    [mCell configClassFeeCellWithData:self.dataSourceArray[indexPath.row]];
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
        _tableView.rowHeight = 60;
        
        [_tableView registerClass:[JYXClassFeeTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXClassFeeTableViewCell class])];
    }
    return _tableView;
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.layer.contents = (id)[UIImage imageNamed:@"navBarBg"].CGImage;
    }
    return _topView;
}

- (UILabel *)topTitleLabel
{
    if (!_topTitleLabel) {
        _topTitleLabel = [[UILabel alloc] init];
        _topTitleLabel.textColor = [UIColor whiteColor];
        _topTitleLabel.font = FONT_SIZE(12);
        _topTitleLabel.text = NSLocalizedString(@"课时费余额(元)", nil);
        [_topTitleLabel sizeToFit];
    }
    return _topTitleLabel;
}

- (UILabel *)topClassFeeLabel
{
    if (!_topClassFeeLabel) {
        _topClassFeeLabel = [[UILabel alloc] init];
        _topClassFeeLabel.textColor = [UIColor whiteColor];
        _topClassFeeLabel.font = FONT_SIZE(20);
        [_topClassFeeLabel sizeToFit];
    }
    return _topClassFeeLabel;
}

- (UIButton *)applyBtn
{
    if (!_applyBtn) {
        _applyBtn = [[UIButton alloc] init];
        _applyBtn.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        [_applyBtn setTitle:NSLocalizedString(@"申请提现", nil) forState:UIControlStateNormal];
        [_applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _applyBtn.titleLabel.font = FONT_SIZE(18);
        JYXViewBorderRadius(_applyBtn, 23, 0, [UIColor clearColor]);
    }
    return _applyBtn;
}

@end
