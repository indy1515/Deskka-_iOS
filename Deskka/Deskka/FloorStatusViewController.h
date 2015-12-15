//
//  FloorStatusViewController.h
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Floor.h"
#import "AFHTTPRequestOperationManager.h"
#import "UICountingLabel.h"
#import "ColorHelper.h"
@class FloorStatusViewController;

@protocol FloorStatusViewControllerDelegate <NSObject>

//-(void) passItemBack:(FloorStatusViewController *)controller didFinishWithItem:(SearchStation*)item;
//-(void)snapToCurrentLocationInMap:(FloorStatusViewController *)controller;
@end
@interface FloorStatusViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel; 
@property (weak, nonatomic) IBOutlet UILabel *statLabel; // (0/0)
@property (weak, nonatomic) IBOutlet UILabel *percentLabel; // (%)

@property (weak, nonatomic) IBOutlet UIView *colorBgView;
@property (weak, nonatomic) IBOutlet UICountingLabel *descriptionLabel1;
@property (weak, nonatomic) IBOutlet UICountingLabel *descriptionLabel2;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndictor;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UIView *blackView;

@property Floor* currentFloor;

@property (nonatomic, weak) id<FloorStatusViewControllerDelegate>delegate;
@end
