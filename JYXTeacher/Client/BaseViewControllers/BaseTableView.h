//
//  BaseTableView.h
//  juliye-iphone
//
//  Created by lixiao on 15/9/1.
//  Copyright (c) 2015年 zlycare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import "TableBackgroudView.h"

@class BaseTableView;

typedef NS_ENUM(NSUInteger, TableViewError) {
    TableViewNetworkError,
    TableViewNoDataError,
};

typedef enum {
    ENUM_HeaderRefreshing =0,//头刷新
    ENUM_FooterRefreshing,//尾刷新
} ENUM_Refreshing_State;

/**
 *  数据请求处理完成后调用的Block
 *  count 表示返回的数据数量
 */
typedef void (^DataCompleteBlock)(NSInteger count);

@protocol BaseTableViewDelagate <NSObject>

@optional
//@required
- (void)tableView:(BaseTableView *)tableView requestDataSourceWithPageNum:(NSInteger)pageNum complete:(DataCompleteBlock)complete;

@optional
- (void)backgroundButtonReloadData;

@end

@interface BaseTableView : UITableView

@property (nonatomic,assign) BOOL             hasHeaderRefreshing;         //是否可以下拉刷新
@property (nonatomic,assign) BOOL             hasFooterRefreshing;         //是否可以下拉刷新
@property (nonatomic,assign) NSInteger        int_pageNum;          //数据分页
@property (nonatomic,strong) TableBackgroudView *defaultView;
@property (nonatomic,weak)   id<BaseTableViewDelagate>  tableViewDelegate;
@property (nonatomic,assign) BOOL             hideErrorBackView;

- (void)setDataErrorDefaultView;
- (void)requestDataSource;
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style hasHeaderRefreshing:(BOOL)isHeaderRefreshing hasFooterRefreshing:(BOOL)isFooterRefreshing;
- (void)loadDataNoRefreshing;
- (void)loadNextPageManually;

@end
