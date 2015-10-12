//
//  FloorStatusViewController.m
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "FloorStatusViewController.h"

@interface FloorStatusViewController ()

@end

@implementation FloorStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupButton{
    [self.cancelButton addTarget:self action:@selector(toMainViewController:) forControlEvents:UIControlEventTouchUpInside];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void) toMainViewController:(UIGestureRecognizer *)recognizer{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
