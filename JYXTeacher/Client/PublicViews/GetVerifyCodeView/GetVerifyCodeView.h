//
//  GetVerifyCodeView.h
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef BOOL(^GetCodeBlock)(void);
@interface GetVerifyCodeView : UIView
@property (nonatomic, copy) GetCodeBlock getCodeBlock;
@end
