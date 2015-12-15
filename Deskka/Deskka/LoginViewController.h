//
//  LoginViewController.h
//  Deskka
//
//  Created by aey howatt on 12/15/15.
//  Copyright © 2015 IndyZaLab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *fieldId;
@property (weak, nonatomic) IBOutlet UITextField *fieldPsw;
@property (weak, nonatomic) IBOutlet UIButton *btnGo;

- (IBAction)fieldFilled;

@end
