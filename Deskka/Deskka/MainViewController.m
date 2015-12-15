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
    User * currentUser;

}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self checkIfNeedLogin];
    [self fetchFloorList];
    [self initializeVariable];
    [self initializeTable];
    [self setupButton];
    
    //TODO: Fetch all floor data and room for calculation
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [self checkIfNeedLogin];
    [self.logoutButton setEnabled:TRUE];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didDismissController{
    NSLog(@"Trigger Main Controller Dismiss");
    [self checkIfNeedLogin];
    [self fetchFloorList];
}


- (void) initializeVariable{
    currentTableData = [[NSMutableArray alloc] init];
}

- (void) initializeTable{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Reloading..."]; //to give the attributedTitle
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)refresh:(UIRefreshControl *)refreshControl
{
    
    [self fetchFloorList];; //call method
    [refreshControl endRefreshing];
}

- (void) setupButton{
    [self.scanButton addTarget:self action:@selector(toScanViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.logoutButton addTarget:self action:@selector(onClickLogout:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - onClick

- (void) onClickLogout:(UIGestureRecognizer *) recognizer{
    
    [self.logoutButton setEnabled:FALSE];
    [self showAlertLogout];
    
}

- (void) logout{
    [LocalStorage saveUser:[[NSMutableArray alloc] init]];
    [self toLoginViewController:nil];
}


#pragma mark - Popup

- (void)showAlertLogout
{
    NSString* title = @"Log out";
    if(currentUser != nil){
        title = [NSString stringWithFormat:@"Log out from %@",currentUser.firstname];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:@"Are you sure?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch(buttonIndex) {
        case 0: //"No" pressed
            //do something?
            [self.logoutButton setEnabled:TRUE];
            break;
        case 1: //"Yes" pressed
            //here you pop the viewController
            [self logout];
            break;
    }
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
                    fl.max_amount = floor.max_amount;
                    fl.current_available = floor.current_available;
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
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(didDismissController) 
                                                 name:@"AnyViewControllerDismissed" 
                                               object:nil];
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
    NSMutableArray *userList = [LocalStorage loadUser];
   
    if([userList count] == 0){
        [self toLoginViewController:nil];
    }else{
        for(User * user in userList){
            currentUser = user;
            break;
        }
         NSLog(@"User Amount: %i",[userList count]);
    }
}






@end
