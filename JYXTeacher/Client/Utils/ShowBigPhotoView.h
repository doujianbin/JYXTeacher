//
//  ShowBigPhotoView.h
//  DocChat-C-iphone
//
//  Created by lixiao on 2017/10/25.
//  Copyright © 2017年 juliye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRZoomScrollView.h"

@interface ShowBigPhotoView : UIView<UIScrollViewDelegate>

@property (nonatomic,strong) NSMutableArray     *arr_images;//图片数组uuid
@property (nonatomic,assign) int                 int_index;//第几个cell
@property (nonatomic,strong) UIScrollView       *sv_showBigPhoto;//底层scrollView
@property (nonatomic,strong) MRZoomScrollView   *zoomScrollView_showPhoto;
@property (nonatomic,strong) UILabel            *lb_num;
@property (nonatomic,strong) UIButton           *btn_next;
@property (nonatomic,strong) NSMutableArray     *arr_imageView;
@property (nonatomic,strong) UIPageControl      *pageCtrl;

- (instancetype)initWithFrame:(CGRect)frame withImagesArray:(NSArray *)arr_images index:(int)index;

@end
