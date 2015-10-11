//
//  ViewController.h
//  Deskka?
//
//  Created by IndyZa on 10/11/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanViewController.h"

@interface MainViewController : UIViewController <ScanViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@property (weak, nonatomic) IBOutlet UIButton *bookButton;

@end

