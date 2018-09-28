//
//  TableBackgroudView.h
//  juliye-iphone
//
//  Created by lixiao on 15/8/27.
//  Copyright (c) 2015年 zlycare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableBackgroudView : UIView

- (instancetype)initWithFrame:(CGRect)frame withDefaultImage:(UIImage *)im_default withNoteTitle:(NSString *)str_noteTitle withNoteDetail:(NSString *)str_noteDetail withButtonAction:(UIButton *)btn_action;

@end
