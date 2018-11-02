//
//  JYXAlreadyLessonViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAlreadyLessonViewController.h"
#import "JYXAlreadyLessonTableViewCell.h"
#import "JYXCourseDetailViewController.h"
#import "JYXHomeTeacherWorkListApi.h"
#import "TakeOrderSettingHandler.h"
#import "JYXCertificationBaseInfoViewController.h"
#import "JYXCertificationMaterialsViewController.h"
#import "JYXTakeOrdersSetViewController.h"
#import "ScottPageView.h"
#import "JYXShareWebViewViewController.h"


@interface JYXAlreadyLessonViewController ()<UITableViewDataSource, UITableViewDelegate,BaseTableViewDelagate>
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) BaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic ,strong) UIView   *v_back;
@property (nonatomic ,strong) UIButton   *btn_action;
@property (nonatomic ,strong) UILabel    *lb_detail;
@property (nonatomic, strong) NSDictionary *dic_teacherInfo;
@property (nonatomic ,assign) BOOL          isRenZheng;
@property (nonatomic, strong) ScottPageView *pageViewCode;
@property (nonatomic, strong) NSMutableArray *picArrs;
@property (nonatomic, strong) NSMutableArray *adArrs;

@end

@implementation JYXAlreadyLessonViewController
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectTeacherStatus) name:@"takeOrderSettingComplete" object:nil];
    
    if (self.isRenZheng == NO) {
        [self selectTeacherStatus];
    }
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
    self.page = 1;//默认第一页
//    [self loadData];
    self.picArrs = [[NSMutableArray alloc]init];
    self.adArrs = [[NSMutableArray alloc]init];
}

- (void)setupViews
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.v_back = [[UIView alloc]initWithFrame:self.tableView.frame];
    [self.v_back setBackgroundColor:[UIColor clearColor]];
    
    self.btn_action = [[UIButton alloc]init];
    [self.v_back addSubview:self.btn_action];
    [self.btn_action mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.v_back);
        make.centerY.equalTo(self.v_back).offset(-45);
        make.width.mas_equalTo(125);
        make.height.mas_equalTo(35);
    }];
    self.btn_action.backgroundColor = [UIColor colorWithHexString:@"#1AABFD"];
    self.btn_action.layer.cornerRadius = 18;
    self.btn_action.layer.masksToBounds = YES;
    self.btn_action.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.btn_action addTarget:self action:@selector(btn_actionAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.lb_detail = [[UILabel alloc]init];
    [self.v_back addSubview:self.lb_detail];
    [self.lb_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn_action.mas_bottom).offset(8);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(SCREEN_WIDTH - 30);
        make.height.mas_equalTo(40);
    }];
    [self.lb_detail setTextColor:[UIColor colorWithHexString:@"#6D6D6D"]];
    self.lb_detail.font = [UIFont systemFontOfSize:11];
    [self.lb_detail setTextAlignment:NSTextAlignmentCenter];
    self.lb_detail.numberOfLines = 0;
    
}

- (void)selectTeacherStatus{
    //查询认证状态  如果没认证  给去认证的提示
    JYXUser *user = [JYXUserManager shareInstance].user;
    [TakeOrderSettingHandler getTeacherInfoWithUserid:user.userId prepare:^{
        
    } success:^(id obj) {
        NSDictionary *dic = (NSMutableDictionary *)obj;
//        NSLog(@"dic = %@",dic);
        self.dic_teacherInfo = dic;
        [self.adArrs removeAllObjects];
        [self.picArrs removeAllObjects];
        [self.adArrs addObjectsFromArray:[dic objectForKey:@"ad"]];
        for (int i = 0; i < self.adArrs.count; i++) {
            [self.picArrs addObject:[[self.adArrs objectAtIndex:i] objectForKey:@"pic"]];
        }
        
        //使用cardname进行资本资料是否填写的判断   其余使用单独字段
        if ([[dic objectForKey:@"cardname"] isEqualToString:@""] || [dic[@"cardstatu"] intValue] == 0 || [dic[@"educationstatu"] intValue] == 0) {
            //未认证
////            [self.tableView setHidden:YES];
//            [self.v_back setHidden:NO];
            self.tableView.backgroundView = self.v_back;
            [self.btn_action setHidden:NO];
            [self.lb_detail setHidden:NO];
            [self.btn_action setTitle:@"去认证" forState:UIControlStateNormal];
            [self.lb_detail setText:@"您尚未进行认证"];
            self.lb_detail.font = [UIFont systemFontOfSize:11];
            self.isRenZheng = NO;
        }else if ([dic[@"cardstatu"] intValue] == 1 || [dic[@"educationstatu"] intValue] == 1){
            //认证中
//            [self.tableView setHidden:YES];
//            [self.v_back setHidden:NO];
            self.tableView.backgroundView = self.v_back;
            [self.btn_action setHidden:YES];
            [self.lb_detail setHidden:NO];
            [self.lb_detail setText:@"认证中请耐心等待"];
            self.lb_detail.font = [UIFont systemFontOfSize:17];
            self.isRenZheng = NO;
        }else if ([dic[@"cardstatu"] intValue] == 3 || [dic[@"educationstatu"] intValue] == 3 ){
            //认证失败
//            [self.tableView setHidden:YES];
//            [self.v_back setHidden:NO];
            self.tableView.backgroundView = self.v_back;
            [self.btn_action setHidden:NO];
            [self.btn_action setTitle:@"重新认证" forState:UIControlStateNormal];
            [self.lb_detail setText:@"您的认证审核未通过"];
            self.lb_detail.font = [UIFont systemFontOfSize:11];
            [self.lb_detail setHidden:NO];
            self.isRenZheng = NO;
        }
        else if ([dic[@"planhour"] intValue] == 0 || [[dic objectForKey:@"gradesubject"] count] == 0){
            //认证通过   未接单设置
//            [self.tableView setHidden:YES];
//            [self.v_back setHidden:NO];
            self.tableView.backgroundView = self.v_back;
            [self.btn_action setTitle:@"接单设置" forState:UIControlStateNormal];
            [self.lb_detail setText:@"您还未进行接单设置，系统将自动为您安排年级科目进行展示，请尽快完成接单设置。"];
            self.lb_detail.font = [UIFont systemFontOfSize:11];
            self.isRenZheng = NO;
        }else{
            //认证通过  接单设置已完成
            self.isRenZheng = YES;
//            [self.tableView setHidden:NO];
//            [self.v_back setHidden:YES];
            self.tableView.backgroundView = nil;
            [self.tableView requestDataSource];
        }
        [self.tableView reloadData];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

-(void)tableView:(UITableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete{
    self.page = pageNum + 1;
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeTeacherWorkListApi *api = [[JYXHomeTeacherWorkListApi alloc] initWithTeacherid:@(user.userId.integerValue) token:user.token type:@2 startime:nil page:[NSNumber numberWithInteger:self.page] limitnum:@10];
    //    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        
        
        if (self.page == 1) {
            [self.dataSourceArray removeAllObjects];
        }
        NSArray *array = [api fetchDataWithReformer:request];
        [self.dataSourceArray addObjectsFromArray:array];
        
        complete(array.count);
        if (self.dataSourceArray.count == 0) {
            self.tableView.backgroundView = self.v_back;
        }else{
            self.tableView.backgroundView = nil;
        }
        
    } failure:^(__kindof RXBaseRequest *request) {
        //        [SVProgressHUD dismiss];
    }];
}

#pragma mark - eventResponse                - Method -

- (void)btn_actionAction{
    if ([self.btn_action.titleLabel.text isEqualToString:@"去认证"] || [self.btn_action.titleLabel.text isEqualToString:@"重新认证"]) {
        if ([[self.dic_teacherInfo objectForKey:@"cardname"] isEqualToString:@""]) {
            //去基本设置界面
            JYXCertificationBaseInfoViewController *vc = [[JYXCertificationBaseInfoViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //去身份、学历认证界面
            JYXCertificationMaterialsViewController *vc = [[JYXCertificationMaterialsViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        //去接单设置界面
        JYXTakeOrdersSetViewController *vc = [[JYXTakeOrdersSetViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXCourseDetailViewController *vc = [[JYXCourseDetailViewController alloc] init];
    vc.courseType = @1;
    vc.courseId = self.dataSourceArray[indexPath.row][@"id"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXAlreadyLessonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXAlreadyLessonTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXAlreadyLessonTableViewCell *mCell = (JYXAlreadyLessonTableViewCell *)cell;
    [mCell configAlreadyLessonCellWithData:self.dataSourceArray[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (self.picArrs.count > 0) {
        
        _pageViewCode = [ScottPageView pageViewWithImageArr:self.picArrs andImageClickBlock:^(NSInteger index) {
            NSLog(@"点击代码创建的第%ld张图片",index+1);
            JYXShareWebViewViewController *vc = [[JYXShareWebViewViewController alloc]init];
            vc.str_title = [[self.adArrs objectAtIndex:index] objectForKey:@"title"];
            vc.str_url = [[self.adArrs objectAtIndex:index] objectForKey:@"url"];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        _pageViewCode.time = 3;
        return _pageViewCode;
        
    }else{
        return nil;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.picArrs.count > 0) {
        return 95;
    }else{
        return 0.01f;
    }
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
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped hasHeaderRefreshing:YES hasFooterRefreshing:YES];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 159;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableViewDelegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.contentInset = EdgeInsets(4, 0, 0, 0);
        
        [_tableView registerClass:[JYXAlreadyLessonTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXAlreadyLessonTableViewCell class])];
    }
    return _tableView;
}

@end
