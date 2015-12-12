//
//  CheckInNoticeViewController.h
//  Deskka
//
//  Created by IndyZa on 12/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckInStatusViewController.h"
#import "Desk.h"


@class CheckInNoticeViewController;

@protocol CheckInNoticeViewControllerDelegate <NSObject>


@end

@interface CheckInNoticeViewController : UIViewController<CheckInStatusViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (nonatomic, retain) Desk *currentDesk;

@property (nonatomic, weak) id<CheckInNoticeViewControllerDelegate>delegate;

@end
