//
//  ViewController.m
//  Deskka?
//
//  Created by IndyZa on 10/11/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "MainViewController.h"
#import "RoomStatusCell.h"
#import "Floor.h"
#import "CustomColors.h"
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
@interface MainViewController ()

@end

@implementation MainViewController{
    NSMutableArray *currentTableData; // Room Status Array
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeVariable];
    [self setupButton];
    [currentTableData addObject:[[Floor alloc]initWithName:@"6F" maxAmount:100 currentAvailable:85]];
    [currentTableData addObject:[[Floor alloc]initWithName:@"5F" maxAmount:100 currentAvailable:35]];
    [currentTableData addObject:[[Floor alloc]initWithName:@"4F" maxAmount:100 currentAvailable:17]];
    [currentTableData addObject:[[Floor alloc]initWithName:@"3F" maxAmount:100 currentAvailable:6]];
//    [self.tableView reloadData];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initializeVariable{
    currentTableData = [[NSMutableArray alloc] init];
}

- (void) setupButton{
    [self.scanButton addTarget:self action:@selector(toScanViewController:) forControlEvents:UIControlEventTouchUpInside];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Table Size: %lu",(unsigned long)[currentTableData count]);
    return [currentTableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RoomStatusCell";
  
    RoomStatusCell *cell = (RoomStatusCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RoomStatusCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSLog(@"Table Cell %i",indexPath.row);
//    //    tableView.separatorColor = [UIColor whiteColor];
    Floor *cellValue = [currentTableData objectAtIndex:indexPath.row];
    cell.nameLabel.text = cellValue.name;
    cell.availableLabel.text = [NSString stringWithFormat:@"%i%%",(int)[cellValue getAvailablePercent]];
    [cell setBackgroundWithPercentage:(int)[cellValue getAvailablePercent]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

//    if(cellValue.isShown){
//        [cell.viewButton setImage:[UIImage imageNamed:@"main_show"] forState:UIControlStateNormal];
//        
//    }else{
//        [cell.viewButton setImage:[UIImage imageNamed:@"main_hide"] forState:UIControlStateNormal];
//    }
//    cell.busNoLabel.text = cellValue.nameTH;
//    cell.stationALabel.text = [cellValue getStationA];
//    cell.stationBLabel.text = [cellValue getStationB];
//    cell.delegate = self;
//    cell.cellIndex = indexPath.row;
//    //    directionType;
//    //    stationALabel;
//    //    stationBLabel;
//    //    viewButton;
//    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            tableView.layoutMargins = UIEdgeInsetsZero;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowNo = indexPath.row;
    [self toFloorStatusViewController:nil];
}

- (void) toScanViewController:(UIGestureRecognizer *)recognizer {
    ScanViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ScanViewController"];
    VC2.delegate = self;
    [self presentViewController:VC2 animated:NO completion:^{
        //  [loadingView startAnimating];
        NSLog(@"completion fired");
    }];
}

- (void) toFloorStatusViewController:(UIGestureRecognizer *)recognizer {
    FloorStatusViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"FloorStatusViewController"];
    VC2.delegate = self;
    [self presentViewController:VC2 animated:NO completion:^{
        //  [loadingView startAnimating];
        NSLog(@"completion fired");
    }];
}


@end
