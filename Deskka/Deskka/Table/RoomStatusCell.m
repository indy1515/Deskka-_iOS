//
//  RoomStatusCell.m
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "RoomStatusCell.h"
#import "CustomColors.h"

@implementation RoomStatusCell
@synthesize backgroundView;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if(selected){
//        self.backgroundColor = [UIColor redColor];
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
    
}

- (void) startAnimation{
    self.availableLabel.text = [NSString stringWithFormat:@"%i%%",(int)self.availablePercentage];
    
}

- (void) setPercentageLabel:(float) value{
    
    self.availablePercentage = value;
    [self setBackgroundWithPercentage:value];
}

- (void) setBackgroundWithPercentage:(float) value{
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
    
    self.backgroundView.backgroundColor = bgColor;
}

@end
