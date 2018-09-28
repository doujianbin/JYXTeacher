//
//  JYXGradeSubjectViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/21.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXGradeSubjectViewController.h"
#import "JYXGradeContentView.h"
#import "JYXSubjectContentView.h"
#import "JYXGradeSubjectFooterView.h"
#import "JYXHomeBasicSubjectApi.h"
#import "JYXGradeSubjectModel.h"
#import "TakeOrderSettingHandler.h"

@interface JYXGradeSubjectViewController ()

@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) JYXGradeContentView *gradeContentView;
@property (nonatomic, strong) JYXSubjectContentView *subjectContentView;
@property (nonatomic, strong) JYXGradeSubjectFooterView *footerContentView;
@property (nonatomic, strong) NSArray *dataSourceArray;

@end

@implementation JYXGradeSubjectViewController
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
    self.navigationItem.title = NSLocalizedString(@"年级科目", nil);
    [self setRightBarButton];
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.mScrollView];
    [self.mScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.mScrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mScrollView);
        make.width.equalTo(self.mScrollView);
        make.height.greaterThanOrEqualTo(@0.f);//此处保证容器View高度的动态变化 大于等于0.f的高度
    }];
    
    [self.contentView addSubview:self.gradeContentView];
    [self.gradeContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.subjectContentView];
    [self.subjectContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.gradeContentView.mas_bottom);
    }];
    
    [self.contentView addSubview:self.footerContentView];
    [self.footerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.top.equalTo(self.subjectContentView.mas_bottom);
    }];
    
    WeakSelf(weakSelf);
    [self.gradeContentView setSelectedGradeBlock:^(id model) {
        [weakSelf.subjectContentView configSubjectViewWithData:model];
    }];
    [self.subjectContentView setSelectedSubjectBlock:^{
        [weakSelf.gradeContentView refreshGradeData];
    }];
}

- (void)loadData
{
    [self.footerContentView configGradeSubjectFooterViewWithData:@{}];
    JYXHomeBasicSubjectApi *api = [[JYXHomeBasicSubjectApi alloc] init];
    [SVProgressHUD show];
    [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
        NSArray *array = [api fetchDataWithReformer:request];
        self.dataSourceArray = array;
        [self.gradeContentView configGradeViewWithData:self.dataSourceArray];
    } failure:^(__kindof RXBaseRequest *request) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - eventResponse                - Method -
- (void)submitAction:(UIButton *)btn
{
    NSMutableArray *gradeArray = [NSMutableArray array];
    NSMutableArray *gradeSubjectArray = [NSMutableArray array];
    for (JYXGradeSubjectModel *grade in self.dataSourceArray) {
        if (grade.isSelected.boolValue) {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
            [dictM setValue:grade.value forKey:@"value"];
            [dictM setValue:grade.label forKey:@"label"];
            NSMutableArray *subjectArray = [NSMutableArray array];
            for (JYXGradeSubjectChildrenModel *subject in grade.children) {
                if (subject.isSelected.boolValue) {
                    [gradeSubjectArray addObject:[NSString stringWithFormat:@"%@-%@",grade.label,subject.label]];
                    NSMutableDictionary *childDictM = [NSMutableDictionary dictionary];
                    [childDictM setValue:subject.value forKey:@"value"];
                    [childDictM setValue:subject.label forKey:@"label"];
                    [subjectArray addObject:childDictM];
                }
            }
            [dictM setValue:subjectArray forKey:@"children"];
            [gradeArray addObject:dictM];
        }
    }
    
    //提交
    NSString *str_date = @"";
    for (NSDictionary *dic in gradeArray) {
        NSString *str = [NSString stringWithFormat:@"%@:",[dic objectForKey:@"value"]];
        NSString *str_children = @"";
        if ([[dic objectForKey:@"children"] count] > 0) {
            str_children = [[[dic objectForKey:@"children"] firstObject] objectForKey:@"value"];
        }
        for (int i = 1;i < [[dic objectForKey:@"children"] count];i++) {
            str_children = [str_children stringByAppendingString:[NSString stringWithFormat:@",%@",[[[dic objectForKey:@"children"] objectAtIndex:i] objectForKey:@"value"]]];
        }
        str_date = [str_date stringByAppendingString:[NSString stringWithFormat:@"%@%@/",str,str_children]];
    }
    if ([[str_date substringFromIndex:str_date.length - 1] isEqualToString:@"/"]) {
        str_date = [str_date substringToIndex:str_date.length - 1];
    }
    
    [TakeOrderSettingHandler postTeacherLessonClassWithClassStr:str_date prepare:^{
        
    } success:^(id obj) {
        
    } failed:^(NSInteger statusCode, id json) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
    if (self.selectedGradeSubjectBlock) {
        self.selectedGradeSubjectBlock(gradeSubjectArray, [NSString arrayConvertToJsonData:gradeArray]);
    }
    
    
}

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -
- (void)setRightBarButton
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:NSLocalizedString(@"保存", nil) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT_SIZE(15);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    // 设置尺寸
    btn.size = CGSizeMake(40, 40);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (UIScrollView *)mScrollView
{
    if (!_mScrollView) {
        _mScrollView = [[UIScrollView alloc] init];
        _mScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _mScrollView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (JYXGradeContentView *)gradeContentView
{
    if (!_gradeContentView) {
        _gradeContentView = [[JYXGradeContentView alloc] init];
    }
    return _gradeContentView;
}

- (JYXSubjectContentView *)subjectContentView
{
    if (!_subjectContentView) {
        _subjectContentView = [[JYXSubjectContentView alloc] init];
    }
    return _subjectContentView;
}

- (JYXGradeSubjectFooterView *)footerContentView
{
    if (!_footerContentView) {
        _footerContentView = [[JYXGradeSubjectFooterView alloc] init];
    }
    return _footerContentView;
}

@end

