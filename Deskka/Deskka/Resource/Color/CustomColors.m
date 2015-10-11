//
//  CustomColors.m
//  transitia
//
//  Created by IndyZa on 7/26/2558 BE.
//  Copyright (c) 2558 IndyZaLab. All rights reserved.
//

#import "CustomColors.h"
//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

@implementation UIColor (CustomColors)

+ (UIColor *)blueCustom {
    return UIColorFromRGB(0x2E3192);
}
+ (UIColor *)violetCustom {
    return UIColorFromRGB(0x6E4580);
}
+ (UIColor *)blush {
    return UIColorFromRGB(0xAD5A6F);
}
+ (UIColor *)orangeCustom {
    return UIColorFromRGB(0xED6E5D);
}
+ (UIColor *)beige {
    return UIColorFromRGB(0xEDE8E2);
}
+ (UIColor *)white {
    return UIColorFromRGB(0xFFFFFF);
}





@end
