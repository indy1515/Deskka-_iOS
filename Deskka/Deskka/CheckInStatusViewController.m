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
    int timeTick;
    NSTimer *timer;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeData];
    [self countDown];
    [self onClickSetup];
    [currentTableData addObject:[[Floor alloc]initWithName:@"6F" maxAmount:100 currentAvailable:85]];
    [currentTableData addObject:[[Floor alloc]initWithName:@"5F" maxAmount:100 currentAvailable:35]];
    [currentTableData addObject:[[Floor alloc]initWithName:@"4F" maxAmount:100 currentAvailable:17]];
    [currentTableData addObject:[[Floor alloc]initWithName:@"3F" maxAmount:100 currentAvailable:6]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initializeData{
    currentTableData = [[NSMutableArray alloc] init];
    
    timeTick = 20;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}


#pragma mark - setup

- (void) onClickSetup{
    [self.checkoutButton addTarget:self action:@selector(onClickCheckout:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - onClick

- (void) onClickCheckout:(UIGestureRecognizer *) recognizer{
    
    //TODO: Check out from network
    
    [self toNoticeViewController:@"CHECKED OUT"];
}

#pragma mark - Automation

//TODO: Countdown Automation - when timeout post done to internet


-(void)countDown{
    //increment the timer
    timeTick--;
    
    
    int seconds = timeTick % 60;
    int minutes = (timeTick / 60) % 60;
    
    //set a text label to display the time
    NSString *timeString =[[NSString alloc] initWithFormat:@"%02d:%02d", minutes, seconds];
    self.timeLabel.text = timeString;
    
    //if we want the timer to stop after a certain number of seconds we can do
    if(timeTick <= 0){//stop the timer after 60 seconds
        [timer invalidate];
        [self countDownEnd];
    }
}

- (void) countDownEnd{
    self.currentDesk.isAvailable = false;
    [self updateDesk:self.currentDesk];
    
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


#pragma mark - Internet

- (void) updateDesk:(Desk *) fixedDesk{
    NSLog(@"Fetching Floor Id");
    NSString *URLString = @"http://188.166.214.252/index.php/desks/";
    URLString = [NSString stringWithFormat:@"%@%i",URLString,fixedDesk.deskId];
    NSDictionary *parameters = @{@"isAvailable":@(fixedDesk.isAvailable),@"user_id":@(1)};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id
                                                            responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        NSError *e = nil;
        //        NSLog(@"URL: %@",operation.request);
        // Response object are recieve in JSONObject
        
        NSMutableArray *jsonArray = [NSMutableArray arrayWithArray:responseObject];
        
        NSMutableArray *addedArray = [[NSMutableArray alloc] init];
        if (!jsonArray) {
            NSLog(@"Error parsing JSON: %@", e);
        } else {
            for(NSDictionary* dict in jsonArray){
                Desk *desk = [[Desk alloc] initWithDictionary:dict];
                [addedArray addObject:desk];
            }
            NSLog(@"No of added item %lu",(unsigned long)addedArray.count);
            
        }        
        [self toNoticeViewController:@"TIME'S UP!"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error AFHTTP: %@ Response: %@", operation.response.URL, operation.responseString);
        
        
    }];
}


#pragma mark - Navigation
- (void) toNoticeViewController:(NSString *) titleString {
    NoticeViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"NoticeViewController"];
    VC2.delegate = self;
    VC2.extraCloseLayerAmount = 3;
    VC2.titleString = titleString;
    [self presentViewController:VC2 animated:YES completion:^{
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
