//
//  AddressPickerHeader.h
//  WeLearn
//
//  Created by YXG on 2018/1/11.
//  Copyright © 2018年 WeLearn. All rights reserved.
//

#ifndef AddressPickerHeader_h
#define AddressPickerHeader_h

#import "UIView+HExtension.h"


///weakSelf
#define HWeakSelf(type)  __weak typeof(type) weak##type = type;
#define HStrongSelf(type)  __strong typeof(type) type = weak##type;

/**屏幕宽度*/
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
/**屏幕高度*/
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)


/**全局字体*/
#define HGlobelNormalFont(__VA_ARGS__) ([UIFont systemFontOfSize:H_ScaleFont(__VA_ARGS__)])

/**宽度比例*/
#define H_ScaleWidth(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375)*(__VA_ARGS__)

/**高度比例*/
#define H_ScaleHeight(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.height/667)*(__VA_ARGS__)

/**字体比例*/
#define H_ScaleFont(__VA_ARGS__)  ([UIScreen mainScreen].bounds.size.width/375)*(__VA_ARGS__)

/**颜色*/
#define HColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define HRGBColor(rgbValue, a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define HThemeColor (HColor(0xff0000))

#endif /* AddressPickerHeader_h */
