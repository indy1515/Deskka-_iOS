//
//  CheckInStatusViewController.m
//  Deskka
//
//  Created by IndyZa on 12/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "CheckInStatusViewController.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface CheckInStatusViewController ()

@end

@implementation CheckInStatusViewController{
    NSMutableArray *currentTableData; // Room Status Array
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Table

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
//    [self toFloorStatusViewController:nil];
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
