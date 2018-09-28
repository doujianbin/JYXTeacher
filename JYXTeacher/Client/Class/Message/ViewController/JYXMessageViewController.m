//
//  JYXMessageViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMessageViewController.h"
#import "JYXMessageTableViewCell.h"
#import "JYXHomeMesRongcloudApi.h"
#import "MyHandler.h"

@interface JYXMessageViewController ()<UITableViewDataSource, UITableViewDelegate>
//@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@end

@implementation JYXMessageViewController
#pragma mark - lifeCycle                    - Method -
- (instancetype)init{
    if (self = [super init]) {
        [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE)]];
    }
    return self;
}

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
    UIImage *backgroundImage = [UIImage imageNamed:@"navBarBg"];
    backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5) resizingMode:UIImageResizingModeStretch];
    UIImage *shadowImage = [UIImage imageWithColor:[UIColor clearColor]
                                              size:CGSizeMake(self.navigationController.navigationBar.size.width, 0.5)];
    UIColor *titleColor = [UIColor colorWithHex:0xffffff];
    
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationController.navigationBar setShadowImage:shadowImage];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : titleColor,
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    [self loadData];
    
    self.conversationListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupViews
{
//    [self.view addSubview:self.tableView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
}

- (void)loadData
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    JYXHomeMesRongcloudApi *api = [[JYXHomeMesRongcloudApi alloc] initWithUserId:@(user.teacherId.integerValue) username:user.nickname type:@1];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [api fetchDataWithReformer:request];
        [[RCIM sharedRCIM] connectWithToken:dict[@"token"]  success:^(NSString *userId) {
            NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"token错误");
        }];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - eventResponse                - Method -
- (void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath{
    RCConversationViewController *vc = [[RCConversationViewController alloc] init];
    vc.conversationType = ConversationType_PRIVATE;
    vc.targetId = model.targetId;
    vc.title = model.conversationTitle;
    [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
}


#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    JYXMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JYXMessageTableViewCell class]) forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    JYXMessageTableViewCell *mCell = (JYXMessageTableViewCell *)cell;
//    [mCell configMessageCellWithData:@{}];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;
//}

#pragma mark - getters and setters          - Method -
//- (NSMutableArray *)dataSourceArray
//{
//    if (!_dataSourceArray) {
//        _dataSourceArray = [NSMutableArray array];
//    }
//    return _dataSourceArray;
//}
//
//- (UITableView *)tableView
//{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] init];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.rowHeight = 62;
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.backgroundColor = [UIColor clearColor];
//
//        [_tableView registerClass:[JYXMessageTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JYXMessageTableViewCell class])];
//    }
//    return _tableView;
//}

@end
