//
//  JYXHelpViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/20.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXHelpViewController.h"
#import "JYXHelpTableViewCell.h"
#import "JYXUserFeedbackViewController.h"
#import "JYXWebViewViewController.h"
#import "JYXPlayVedioViewController.h"

@interface JYXHelpViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation JYXHelpViewController
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
    self.navigationItem.title = NSLocalizedString(@"帮助", nil);
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
    NSDictionary *FAQDict = @{@"title":@"常见问题", @"type":@1};
    NSDictionary *feedbackDict = @{@"title":@"用户反馈", @"type":@2};
    NSDictionary *protocolDict = @{@"title":@"用户协议", @"type":@3};
    NSDictionary *useVideoDict = @{@"title":@"使用视频", @"type":@4};
    self.dataSourceArray = [@[FAQDict, feedbackDict, protocolDict, useVideoDict] mutableCopy];
}

#pragma mark - eventResponse                - Method -

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *type = self.dataSourceArray[indexPath.row][@"type"];
    switch (type.integerValue) {
        case 1://常见问题
        {
            JYXWebViewViewController *vc = [[JYXWebViewViewController alloc]init];
            vc.str_title = @"常见问题";
            vc.str_url = @"http://www.jiaoyuxuevip.com/API_DOC/help/commonProblem.html";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2://用户反馈
        {
            JYXUserFeedbackViewController *vc = [[JYXUserFeedbackViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3://用户协议
        {
            JYXWebViewViewController *vc = [[JYXWebViewViewController alloc]init];
            vc.str_title = @"用户协议";
            vc.str_url = @"http://www.jiaoyuxuevip.com/API_DOC/help/agreement.html";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4://使用视频
        {
            JYXPlayVedioViewController *vc = [[JYXPlayVedioViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXHelpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXHelpTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JYXHelpTableViewCell *mCell = (JYXHelpTableViewCell *)cell;
    [mCell configHelpCellWithData:self.dataSourceArray[indexPath.row]];
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
        _tableView.rowHeight = 45;
        
        [_tableView registerClass:[JYXHelpTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXHelpTableViewCell class])];
    }
    return _tableView;
}

@end
