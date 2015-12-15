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

- (void) layoutSubviews{
    [self startAnimation];
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
    
    self.availableLabel.format = @"%d%%";
    self.availableLabel.method = UILabelCountingMethodEaseOut;
    [self.availableLabel countFrom:[self.availableLabel currentValue] to:(int)self.availablePercentage withDuration:1.0f];
//    self.availableLabel.text = [NSString stringWithFormat:@"%i%%",(int)self.availablePercentage];
    
}

- (void) setPercentageLabel:(float) value{
    self.availableLabel.text = @"0%%";
    self.availablePercentage = value;
    [self setBackgroundWithPercentage:value];
}

- (void) setBackgroundWithPercentage:(float) value{
    UIColor *bgColor = [UIColor blueCustom];
    bgColor = [ColorHelper getBackgroundColorFromValue:(int) value];    
    self.backgroundView.backgroundColor = bgColor;
}

@end
