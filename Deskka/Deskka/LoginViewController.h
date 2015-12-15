//
//  LoginViewController.h
//  Deskka
//
//  Created by aey howatt on 12/15/15.
//  Copyright © 2015 IndyZaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "AFHTTPRequestOperationManager.h"
@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>


@end
@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *fieldId;
@property (weak, nonatomic) IBOutlet UITextField *fieldPsw;
@property (weak, nonatomic) IBOutlet UIButton *btnGo;

@property (nonatomic, weak) id<LoginViewControllerDelegate>delegate;
@end
