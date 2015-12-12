//
//  CheckInNoticeViewController.m
//  Deskka
//
//  Created by IndyZa on 12/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "CheckInNoticeViewController.h"

@interface CheckInNoticeViewController ()

@end

@implementation CheckInNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Setup

- (void) setupButton{
    [self.okButton addTarget:self action:@selector(onClickOkButton:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - onClick

- (void) onClickOkButton:(UIGestureRecognizer *) regonizer{
    [self toCheckInStatusViewController:self.currentDesk];  
}


#pragma mark - Navigation

- (void) toCheckInStatusViewController:(Desk *)desk {
    CheckInStatusViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"CheckInStatusViewController"];
    VC2.delegate = self;
    VC2.currentDesk = desk;
    [self presentViewController:VC2 animated:NO completion:^{
        //  [loadingView startAnimating];
        NSLog(@"completion fired");
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
