//
//  NoticeViewController.h
//  Deskka
//
//  Created by IndyZa on 12/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NoticeViewController;

@protocol NoticeViewControllerDelegate <NSObject>


@end


@interface NoticeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSString* titleString;
@property int extraCloseLayerAmount;
@property bool isNotDismissToMain;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (nonatomic, weak) id<NoticeViewControllerDelegate>delegate;
@end
