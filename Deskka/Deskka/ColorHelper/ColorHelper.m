//
//  ColorHelper.m
//  Deskka
//
//  Created by IndyZa on 12/16/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "ColorHelper.h"

@implementation ColorHelper

+ (UIColor *)getBackgroundColorFromValue:(int) value{
    UIColor *bgColor = [UIColor blueCustom];
    if(value >= 51){
        bgColor = [UIColor blueCustom];
    }else if(value >= 21){
        bgColor = [UIColor violetCustom];
    }else if(value >= 11){
        bgColor = [UIColor blush];
    }else{
        bgColor = [UIColor orangeCustom];
    }
    return bgColor;

}

@end
