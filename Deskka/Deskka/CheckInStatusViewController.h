//
//  CheckInStatusViewController.h
//  Deskka
//
//  Created by IndyZa on 12/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Desk.h"
#import "Floor.h"
#import "RoomStatusCell.h"
#import "CustomColors.h"

@class CheckInStatusViewController;

@protocol CheckInStatusViewControllerDelegate <NSObject>


@end

@interface CheckInStatusViewController : UIViewController

@property (nonatomic, weak) id<CheckInStatusViewControllerDelegate>delegate;

@property (nonatomic, retain) Desk *currentDesk;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *checkoutButton;

@end