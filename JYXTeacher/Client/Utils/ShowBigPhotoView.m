//
//  ShowBigPhotoView.m
//  DocChat-C-iphone
//
//  Created by lixiao on 2017/10/25.
//  Copyright © 2017年 juliye. All rights reserved.
//

#import "ShowBigPhotoView.h"

@implementation ShowBigPhotoView

- (instancetype)initWithFrame:(CGRect)frame withImagesArray:(NSArray *)arr_images index:(int)index{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.int_index = index;
        self.arr_images = [NSMutableArray arrayWithArray:arr_images];
        
        float height = SCREEN_HEIGHT;
        self.arr_imageView = [NSMutableArray array];
        self.backgroundColor = [UIColor blackColor];
        
        _sv_showBigPhoto = [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, height)];
        _sv_showBigPhoto.delegate = self;
        _sv_showBigPhoto.pagingEnabled = YES;
        _sv_showBigPhoto.userInteractionEnabled = YES;
        _sv_showBigPhoto.showsHorizontalScrollIndicator = NO;
        _sv_showBigPhoto.showsVerticalScrollIndicator = NO;
        _sv_showBigPhoto.bounces = NO;
        [self addSubview:_sv_showBigPhoto];
        
        [_sv_showBigPhoto setContentSize:CGSizeMake(SCREEN_WIDTH * self.arr_images.count, height)];
        [_sv_showBigPhoto setContentOffset:CGPointMake(SCREEN_WIDTH * self.int_index, 0)];
        
        for (int i = 0; i < self.arr_images.count ; i++) {
            _zoomScrollView_showPhoto = [[MRZoomScrollView alloc]init];
            [_zoomScrollView_showPhoto setContentSize:CGSizeMake(SCREEN_WIDTH, height)];
            CGRect frame = self.sv_showBigPhoto.frame;
            frame.origin.x = SCREEN_WIDTH * i;
            frame.origin.y = 0;
            [_zoomScrollView_showPhoto.imageView setContentMode:UIViewContentModeScaleAspectFill];
            _zoomScrollView_showPhoto.frame = frame;
            [_zoomScrollView_showPhoto.imageView setImage:[UIImage imageNamed:[arr_images objectAtIndex:i]]];
            [_zoomScrollView_showPhoto.imageView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
            [_zoomScrollView_showPhoto.imageView setContentMode:UIViewContentModeScaleAspectFill];
            [self.sv_showBigPhoto addSubview:_zoomScrollView_showPhoto];
            [self.arr_imageView addObject:_zoomScrollView_showPhoto.imageView];
        }
        
        self.pageCtrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - 10 - 30,SCREEN_WIDTH, 30)];  //创建UIPageControl，位置在屏幕最下方。
        self.pageCtrl.numberOfPages = arr_images.count;//总的图片页数
        self.pageCtrl.currentPage = 0; //当前页
        self.pageCtrl.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#43b4ff"];//选中
        self.pageCtrl.pageIndicatorTintColor = [UIColor colorWithHexString:@"#abe4ff"];//未选中
        [self addSubview:self.pageCtrl];
        
        self.btn_next = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * (arr_images.count - 1),SCREEN_HEIGHT - 100,SCREEN_WIDTH, 100)];
//        [self.btn_next setTitle:@"跳过" forState:UIControlStateNormal];
//        [self.btn_next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.btn_next setBackgroundColor:[UIColor colorWithHexString:@"#000000" alpha:0.4]];
//        self.btn_next.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.btn_next.layer setCornerRadius:2];
        self.btn_next.layer.masksToBounds = YES;
        [_sv_showBigPhoto addSubview:self.btn_next];
        
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageCtrl.currentPage = (int)(_sv_showBigPhoto.contentOffset.x / SCREEN_WIDTH);
}

@end
