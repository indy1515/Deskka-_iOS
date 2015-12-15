//
//  RoomStatusCell.h
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICountingLabel.h"
#import "ColorHelper.h"

@interface RoomStatusCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UICountingLabel *availableLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property float availablePercentage;

- (void) setBackgroundWithPercentage:(float) value;
- (void) setPercentageLabel:(float) value;
- (void) startAnimation;
@end
