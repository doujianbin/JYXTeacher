//
//  BaseTableView.m
//  juliye-iphone
//
//  Created by lixiao on 15/9/1.
//  Copyright (c) 2015年 zlycare. All rights reserved.
//

#import "BaseTableView.h"
#import "TableBackgroudView.h"
#import "MJRefreshAnimationStateHeader.h"

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self onCreate];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkErrorHandler) name:@"k_NOTI_NETWORK_ERROR" object:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self onCreate];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkErrorHandler) name:@"k_NOTI_NETWORK_ERROR" object:nil];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style hasHeaderRefreshing:(BOOL)isHeaderRefreshing hasFooterRefreshing:(BOOL)isFooterRefreshing{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.hasHeaderRefreshing = isHeaderRefreshing;
        self.hasFooterRefreshing = isFooterRefreshing;
        [self onCreate];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkErrorHandler) name:@"k_NOTI_NETWORK_ERROR" object:nil];
    }
    return self;
}

- (void)onCreate{
    [self showOrHidenFooterRefresh];
}

- (void)showOrHidenFooterRefresh{
    if (!self.mj_footer.isRefreshing) {
        self.mj_footer.alpha = 0.;
    }else{
        self.mj_footer.alpha = 1.0;
    }
}

#pragma mark - MJRefresh & DataSource
- (void)headerRereshing
{
    if ([self.tableViewDelegate respondsToSelector:@selector(tableView:requestDataSourceWithPageNum:complete:)]) {
        self.int_pageNum = 0;
        [self.tableViewDelegate tableView:self requestDataSourceWithPageNum:self.int_pageNum complete:^(NSInteger count) {
            [self reloadData];
            if (count == 0) {
                self.mj_footer.hidden = YES;
            }
            if (count > 0) {
                [self setBackgroundView:nil];
            }
            [self.mj_header endRefreshing];
        }];
        [self.mj_footer resetNoMoreData];
    }
}

- (void)footerRereshing{
    if ([self.tableViewDelegate respondsToSelector:@selector(tableView:requestDataSourceWithPageNum:complete:)]) {
        self.int_pageNum = self.int_pageNum + 1;
        [self.tableViewDelegate tableView:self requestDataSourceWithPageNum:self.int_pageNum complete:^(NSInteger count){
            [self reloadData];
            if (count == 0) {
                self.mj_footer.hidden = YES;
            }else{
                [self.mj_footer endRefreshing];
            }
            if (count > 0) {
                [self setBackgroundView:nil];
            }
            [self showOrHidenFooterRefresh];
        }];
    }
}

#pragma mark - setBackGroundView

- (void)networkErrorHandler{
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
    if ([self isDataSourceEmpty]) {
        if (self.hideErrorBackView == NO) {
            [self addTableBackgroundViewOfTableViewError:TableViewNetworkError];
        }
    }else{
        [self setBackgroundView:nil];
    }
    [self showOrHidenFooterRefresh];
}

- (void)setDataErrorDefaultView{
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
    if ([self isDataSourceEmpty]) {
        if (self.hideErrorBackView == NO) {
            [self addTableBackgroundViewOfTableViewError:TableViewNoDataError];
        }
    }else{
        [self setBackgroundView:nil];
    }
    [self showOrHidenFooterRefresh];
}

- (void)setDefaultView:(TableBackgroudView *)defaultView{
    if ([self isDataSourceEmpty]) {
        [self setBackgroundView:defaultView];
    }else{
        [self setBackgroundView:nil];
    }
}

- (BOOL)isDataSourceEmpty{
    if (self.dataSource){
        if ([self numberOfSections] == 0 || ([self numberOfSections] == 1 && [self numberOfRowsInSection:0] == 0)) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
    
}

- (void)addTableBackgroundViewOfTableViewError:(TableViewError)error{
    
    UIImage *im_default = [[UIImage alloc]init];
    UIButton *btn_loadData = [[UIButton alloc]init];
    [btn_loadData addTarget:self action:@selector(reloadDataAgain) forControlEvents:UIControlEventTouchUpInside];
    TableBackgroudView *v_bg;
    switch (error) {
        case TableViewNoDataError:
        {
            im_default = [UIImage imageNamed:@"data_error"];
            v_bg = [[TableBackgroudView alloc]initWithFrame:self.frame withDefaultImage:im_default withNoteTitle:@"点击屏幕,重新加载" withNoteDetail:nil withButtonAction:btn_loadData];
        }
            break;
        case TableViewNetworkError:
        {
            im_default = [UIImage imageNamed:@"default_error"];
            v_bg = [[TableBackgroudView alloc]initWithFrame:self.frame withDefaultImage:im_default withNoteTitle:@"点击屏幕,重新加载" withNoteDetail:nil withButtonAction:btn_loadData];
        }
            break;
        default:
            break;
    }
    [self setBackgroundView:v_bg];
}


- (void)requestDataSource{
    if (self.hasHeaderRefreshing) {
        [self.mj_header beginRefreshing];
    }else{
        if ([self.tableViewDelegate respondsToSelector:@selector(tableView:requestDataSourceWithPageNum:complete:)]) {
            self.int_pageNum = 0;
            [self.tableViewDelegate tableView:self requestDataSourceWithPageNum:self.int_pageNum complete:^(NSInteger count) {
                [self reloadData];
                if (count == 0) {
                    if (self.hasFooterRefreshing) {
                        self.mj_footer.hidden = YES;
                    }
                }
                if (count > 0) {
                    [self setBackgroundView:nil];
                }
            }];
            if (self.hasFooterRefreshing) {
                [self.mj_footer resetNoMoreData];
            }
        }
    }
}

- (void)loadDataNoRefreshing {
    if ([self.tableViewDelegate respondsToSelector:@selector(tableView:requestDataSourceWithPageNum:complete:)]) {
        self.int_pageNum = 0;
        [self.tableViewDelegate tableView:self requestDataSourceWithPageNum:self.int_pageNum complete:^(NSInteger count) {
            [self reloadData];
            if (count == 0) {
                if (self.hasFooterRefreshing) {
                    self.mj_footer.hidden = YES;
                }
            }
            if (count > 0) {
                [self setBackgroundView:nil];
            }
        }];
        
        if (self.hasFooterRefreshing) {
            [self.mj_footer resetNoMoreData];
        }
    }
}

- (void)loadNextPageManually {
    [self footerRereshing];
}

- (void)reloadDataAgain{
    [self requestDataSource];
}

- (void)setHasHeaderRefreshing:(BOOL)hasHeaderRefreshing{
    _hasHeaderRefreshing = hasHeaderRefreshing;
    if(hasHeaderRefreshing){
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    }else{
        self.mj_header = nil;
    }
}

- (void)setHasFooterRefreshing:(BOOL)hasFooterRefreshing{
    _hasFooterRefreshing = hasFooterRefreshing;
    if (hasFooterRefreshing) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }else{
        self.mj_footer = nil;
    }
}

@end

