//
//  FloorStatusViewController.h
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FloorStatusViewController;

@protocol FloorStatusViewControllerDelegate <NSObject>

//-(void) passItemBack:(FloorStatusViewController *)controller didFinishWithItem:(SearchStation*)item;
//-(void)snapToCurrentLocationInMap:(FloorStatusViewController *)controller;
@end
@interface FloorStatusViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic, weak) id<FloorStatusViewControllerDelegate>delegate;
@end
