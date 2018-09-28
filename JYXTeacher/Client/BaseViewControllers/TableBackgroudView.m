//
//  TableBackgroudView.m
//  juliye-iphone
//
//  Created by lixiao on 15/8/27.
//  Copyright (c) 2015年 zlycare. All rights reserved.
//

#import "TableBackgroudView.h"
#import <netinet/in.h>
#import "UILabel+LineSpace.h"

@implementation TableBackgroudView

- (instancetype)initWithFrame:(CGRect)frame withDefaultImage:(UIImage *)im_default withNoteTitle:(NSString *)str_noteTitle withNoteDetail:(NSString *)str_noteDetail withButtonAction:(UIButton *)btn_action
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat  currentY = 0.0;
        UIView *v_dataBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, currentY)];
        [self addSubview:v_dataBack];
        
        UIImageView *iv_default = [[UIImageView alloc]init];
        if (im_default) {
            [iv_default setFrame:CGRectMake(frame.size.width / 2 - im_default.size.width/2,0,im_default.size.width,im_default.size.height)];
            currentY = iv_default.bottom;
        }else{
            [iv_default setFrame:CGRectZero];
        }
        [iv_default setImage:im_default];
        [v_dataBack addSubview:iv_default];
        
        UILabel *lb_noteTitle = [[UILabel alloc]init];
        CGFloat height_noteTitle = [lb_noteTitle getSpaceLabelHeightWithText:str_noteTitle withWidth:frame.size.width - SPACING_CONTROLS * 2];
        if (str_noteDetail.length > 0 || btn_action.titleLabel.text.length > 0) {
            [lb_noteTitle setTextColor:[UIColor colorWithHexString:COLOR_TEXT_HARDGRAY]];
        }else{
            [lb_noteTitle setTextColor:[UIColor colorWithHexString:COLOR_TEXT_DESCGRAY]];
        }
        [lb_noteTitle setTextAlignment:NSTextAlignmentCenter];
        [lb_noteTitle setFont:[UIFont systemFontOfSize:FONT_SIZE_TITLE]];
        [v_dataBack addSubview:lb_noteTitle];
        if (str_noteTitle.length == 0) {
            [lb_noteTitle setFrame:CGRectZero];
        }else{
            [lb_noteTitle setFrame:CGRectMake(SPACING_CONTROLS,currentY + SPACING_CONTROLS - 80,frame.size.width - SPACING_CONTROLS * 2,height_noteTitle)];
            currentY = lb_noteTitle.bottom;
        }
        
        UILabel *lb_noteDetail = [[UILabel alloc]init];
        CGFloat height_noteDetail = [lb_noteDetail getSpaceLabelHeightWithText:str_noteDetail withWidth:frame.size.width - SPACING_CONTROLS * 2];
        [lb_noteDetail setTextColor:[UIColor colorWithHexString:COLOR_TEXT_DESCGRAY]];
        [lb_noteDetail setTextAlignment:NSTextAlignmentCenter];
        [lb_noteDetail setFont:[UIFont systemFontOfSize:FONT_SIZE_DESC]];
        [v_dataBack addSubview:lb_noteDetail];
        if (str_noteDetail.length == 0) {
            [lb_noteDetail setFrame:CGRectZero];
        }else{
            if (str_noteTitle.length == 0) {
                [lb_noteDetail setFrame:CGRectMake(SPACING_CONTROLS,currentY + SPACING_CONTROLS,frame.size.width - SPACING_CONTROLS * 2,height_noteDetail)];
            }else{
                [lb_noteDetail setFrame:CGRectMake(SPACING_CONTROLS,currentY + SPACING_CONTROLS,frame.size.width - SPACING_CONTROLS * 2,height_noteDetail)];
            }
            currentY = lb_noteDetail.bottom;
        }
        
        if ([str_noteTitle isEqualToString:ERROR_NETWORK_TEXT]) {
            [btn_action setFrame:frame];
            [self addSubview:btn_action];
        }else{
            if (btn_action) {
                [btn_action.titleLabel setFont:[UIFont systemFontOfSize:FONT_SIZE_TITLE]];
                [btn_action setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btn_action setBackgroundColor:[UIColor whiteColor]];
                [v_dataBack addSubview:btn_action];
                [btn_action setTitleColor:[UIColor colorWithHexString:COLOR_BLUE_MAIN] forState:UIControlStateNormal];
                [btn_action.layer setBorderColor:[[UIColor colorWithHexString:COLOR_BLUE_MAIN] CGColor]];
                [btn_action.layer setBorderWidth:1.0];
                [btn_action.layer setCornerRadius:4.0];
                [btn_action setFrame:CGRectMake(frame.size.width/2 - 120/2,currentY + SPACING_CONTROLS + 6, 120, 40)];
                currentY = btn_action.bottom;
            }
        }
        [v_dataBack setFrame:CGRectMake(0,frame.size.height/2 - currentY/2, SCREEN_WIDTH, currentY)];
        
    }
    return self;
}

@end
