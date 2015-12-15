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
    NSMutableArray *queueMutableArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkIfNeedLogin];
    [self fetchFloorList];
    [self initializeVariable];
    [self setupButton];
    
    //TODO: Fetch all floor data and room for calculation
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [self.logoutButton setEnabled:TRUE];
    
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
    [self.logoutButton addTarget:self action:@selector(onClickLogout:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - onClick

- (void) onClickLogout:(UIGestureRecognizer *) recognizer{
    [self saveUser:[[NSMutableArray alloc] init]];
    [self.logoutButton setEnabled:FALSE];
    [self toLoginViewController:recognizer];
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
    NSLog(@"Table Cell %li",(long)indexPath.row);
//    //    tableView.separatorColor = [UIColor whiteColor];
    Floor *cellValue = [currentTableData objectAtIndex:indexPath.row];
    cell.nameLabel.text = cellValue.name;
    [cell setPercentageLabel:(int)[cellValue getAvailablePercent]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    


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
    Floor *cellValue = [currentTableData objectAtIndex:indexPath.row];

    [self toFloorStatusViewController:cellValue];
}


#pragma mark - Functional



NSInteger sort(Floor* a, Floor* b, void*p) {
    return [[a name] compare:[b name] options:NSNumericSearch];
}







#pragma mark - Fetching


- (void) fetchFloorList{
    
    NSLog(@"Fetching Floor List");
    NSString *URLString = @"http://188.166.214.252/index.php/floors";
    NSDictionary *parameters = nil;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id
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
                Floor *floor = [[Floor alloc] initWithDictionary:dict];
                [addedArray addObject:floor];
            }
            NSLog(@"No of added item %lu",(unsigned long)addedArray.count);
                        
        }
        [self forwardFloorList:addedArray];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error AFHTTP: %@ Response: %@", operation.response.URL, operation.responseString);
        if([currentTableData count] == 0){
            [self fetchFloorList];
        }else{
            
        }
        
    }];

}

- (void) forwardFloorList:(NSMutableArray *) floorList{
    queueMutableArray = floorList;
    for(Floor *fl in floorList){
        [self fetchFloorId:fl.floorId];
    }
}

- (void) fetchFloorId:(int) floorId{
    NSLog(@"Fetching Floor Id");
    NSString *URLString = @"http://188.166.214.252/index.php/floors/";
    URLString = [NSString stringWithFormat:@"%@%i",URLString,floorId];
    NSDictionary *parameters = @{@"option":@"getFloorStat"};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    [manager setResponseSerializer:responseSerializer];
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id
                                                           responseObject) {
        //        NSLog(@"JSON: %@", responseObject);
        NSError *e = nil;
        //        NSLog(@"URL: %@",operation.request);
        // Response object are recieve in JSONObject
        
        NSDictionary *jsonObj = [NSDictionary dictionaryWithDictionary:responseObject];
        
        
        if (!jsonObj) {
            NSLog(@"Error parsing JSON: %@", e);
        } else {
            Floor *floor = [[Floor alloc] initWithDictionary:jsonObj];
            bool foundDuplicate = false;
            for(Floor* fl in currentTableData){
                if(fl.floorId == floor.floorId){
                    foundDuplicate = true;
                    break;
                }
            }
            if(!foundDuplicate) [currentTableData addObject:floor];
        }
        
        //Sorting
        NSArray* tempArray = [[currentTableData copy] sortedArrayUsingFunction:&sort context:nil];
        tempArray = [[tempArray reverseObjectEnumerator] allObjects];
        currentTableData = [NSMutableArray arrayWithArray:tempArray];
        if([currentTableData count] == [queueMutableArray count]){
            [self reloadData:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error AFHTTP: %@ Response: %@", operation.response.URL, operation.responseString);
        if([currentTableData count] == 0){
            [self fetchFloorId:floorId];
        }else{
        }
        
    }];

}

- (void)reloadData:(BOOL)animated
{
    [self.tableView reloadData];
    
    if (animated) {
        
        CATransition *animation = [CATransition animation];
        [animation setType:kCATransitionFade];
//        [animation setSubtype:kCATransitionFade];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [animation setFillMode:kCAFillModeBoth];
        [animation setDuration:.3];
        [[self.tableView layer] addAnimation:animation forKey:@"UITableViewReloadDataAnimationKey"];
        
    }
}



#pragma mark - Navigation

- (void) toLoginViewController:(UIGestureRecognizer *)recognizer {
    LoginViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    VC2.delegate = self;
    [self presentViewController:VC2 animated:NO completion:^{
        //  [loadingView startAnimating];
        NSLog(@"completion fired");
    }];
}

- (void) toScanViewController:(UIGestureRecognizer *)recognizer {
    ScanViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ScanViewController"];
    VC2.delegate = self;
    [self presentViewController:VC2 animated:NO completion:^{
        //  [loadingView startAnimating];
        NSLog(@"completion fired");
    }];
}

- (void) toFloorStatusViewController:(Floor *)floor {
    FloorStatusViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"FloorStatusViewController"];
    VC2.delegate = self;
    VC2.currentFloor = floor;
    [self presentViewController:VC2 animated:NO completion:^{
        //  [loadingView startAnimating];
        NSLog(@"completion fired");
    }];
}

#pragma mark - USER

- (void) checkIfNeedLogin{
    NSMutableArray *userList = [self loadUser];
   
    if([userList count] == 0){
        [self toLoginViewController:nil];
    }else{
         NSLog(@"User Amount: %i",[userList count]);
    }
}

#pragma mark - save/load

- (NSMutableArray *) loadUser{
    // Format is Array of Dictionary with key = @"stationName",@"stationId"
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"userList.plist"];
    NSMutableArray *userDictList = [[[NSMutableArray alloc]initWithContentsOfFile:plistPath]mutableCopy];
    if([userDictList isEqual: nil]) return nil;
    if([userDictList count] == 0) return nil;
    NSMutableArray *userList = [[NSMutableArray alloc] init];
    for(NSDictionary* userDict in userDictList){
        User* user = [[User alloc] initWithDictionary:userDict];
        [userList insertObject:user atIndex:0];
        return userList;
    }
    
    return userList;
}

- (void) saveUser:(NSMutableArray *) userList {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"userList.plist"];
    NSMutableArray* recentList = [[NSMutableArray alloc] init];
    if(!([userList count] == 0)){
        for(User * user in userList){
            NSDictionary* newData = @{
                                      @"id":[NSString stringWithFormat:@"%i",user.userId],
                                      @"chulaID":user.chulaId,
                                      @"password": user.password,
                                      @"name": user.firstname,
                                      @"lastName": user.lastname,
                                      @"faculty": user.faculty,
                                      @"major": user.major,
                                      @"year": user.year
                                      };
            [recentList insertObject:newData atIndex:0];
        }
    }
    [recentList writeToFile:filePath atomically:YES];
    NSLog(@"User Save");
}






@end
