//
//  JYXPhotoView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYXPhotoView : UIView

@property (nonatomic, copy) void(^PictureSelectSuccess)(NSArray *photos);

- (void)show;

@end
