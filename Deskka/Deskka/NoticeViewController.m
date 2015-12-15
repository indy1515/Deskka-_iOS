//
//  NoticeViewController.m
//  Deskka
//
//  Created by IndyZa on 12/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "NoticeViewController.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeSetup];
    
    
    [self setupOnClick];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Setup

- (void) initializeSetup{
    if(self.titleString != nil){
        [self.titleLabel setText:self.titleString];
        [self.titleLabel setFont:[UIFont fontWithName:@"Geomanist-Bold" size:40]];
    }
}

- (void) setupOnClick{
    [self.okButton addTarget:self action:@selector(onClickOkButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - onClick

- (void) onClickOkButton:(UIGestureRecognizer *) recognizer{
    [self toMainViewController:nil];
}



- (void) toMainViewController:(UIGestureRecognizer *)recognizer{
    [self.view endEditing:YES];
    int i = 0;
    UIViewController* presentViewCon = self.presentingViewController;
    while(i < self.extraCloseLayerAmount){
        presentViewCon = presentViewCon.presentingViewController;
        i++;
    }
    [presentViewCon dismissViewControllerAnimated:YES completion:nil];
//    [self dismissViewControllerAnimated:NO completion:nil];
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
