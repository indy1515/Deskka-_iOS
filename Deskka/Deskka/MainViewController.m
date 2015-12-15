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
    [self initializeVariable];
    [self setupButton];
    //TODO: Fetch all floor data and room for calculation
    [self fetchFloorList];
//    [currentTableData addObject:[[Floor alloc]initWithName:@"6F" maxAmount:100 currentAvailable:85]];
//    [currentTableData addObject:[[Floor alloc]initWithName:@"5F" maxAmount:100 currentAvailable:35]];
//    [currentTableData addObject:[[Floor alloc]initWithName:@"4F" maxAmount:100 currentAvailable:17]];
//    [currentTableData addObject:[[Floor alloc]initWithName:@"3F" maxAmount:100 currentAvailable:6]];
    
    
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

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation
{
    for (NSIndexPath *indexPath in indexPaths)
    {
        RoomStatusCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [cell startAnimation];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowNo = indexPath.row;
    [self toFloorStatusViewController:nil];
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
            [currentTableData addObject:floor];
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
