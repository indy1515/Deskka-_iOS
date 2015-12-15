//
//  RoomStatusCell.h
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomStatusCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *availableLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property float availablePercentage;

- (void) setBackgroundWithPercentage:(float) value;
- (void) setPercentageLabel:(float) value;
@end
