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
    [self initializeDataAndView];
    [self setupButton];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Intialization

- (void) initializeDataAndView{
    if([self.currentFloor isEqual:nil]){
        [self setupUIwithFloor:self.currentFloor];
    }
}

- (NSString *) getCounterStringFromFloor:(Floor *) floor{
    return [NSString stringWithFormat:@"%i/%i",floor.current_available,floor.max_amount];
}



#pragma mark - Setup
- (void) setupButton{
    [self.cancelButton addTarget:self action:@selector(toMainViewController:) forControlEvents:UIControlEventTouchUpInside];
}




- (void) setupUIwithFloor:(Floor *) floor{
    [self setupFloorNameUI:floor];
    [self setupPercentageAndCounterUI:floor];
    [self fetchFloorRoomStat:floor.floorId];
}

- (void) setupRoomStatUI:(int) noise withNoiseless:(int) noiseless{
    //TODO: set room type stat
    [self.descriptionLabel1 setText:[NSString stringWithFormat:@"%i QUIET ROOMS",noiseless]];
    [self.descriptionLabel2 setText:[NSString stringWithFormat:@"%i NOISY ROOMS",noise]];
    
}

- (void) setupFloorNameUI:(Floor *) floor{
    NSString *floorName = floor.name;
    //TODO: set floor name UI
    [self.nameLabel setText:floorName];
}

/**
 * Setup percentage(%) and counter string(0/0) 
 **/
- (void) setupPercentageAndCounterUI:(Floor *) floor{
    // Setup available percentage
    NSString *availablePercentage = [NSString stringWithFormat:@"%f",[floor getAvailablePercent]];
    [self.percentLabel setText:availablePercentage];
    
    // Setup available counter string
    NSString *availableCounterString = [self getCounterStringFromFloor:floor];
    //TODO: Data binding
    [self.statLabel setText:availableCounterString];
}




#pragma mark - Internet

- (void) fetchFloorRoomStat:(int) floorId{
    NSLog(@"Fetching Floor Room Stat Id");
    NSString *URLString = [NSString stringWithFormat:@"http://188.166.214.252/index.php/floors/%i/rooms",floorId];
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
        
        NSDictionary *jsonObj = [NSDictionary dictionaryWithDictionary:responseObject];
        
        
        if (!jsonObj) {
            NSLog(@"Error parsing JSON: %@", e);
        } else {
            int noiseRoomAmt = [jsonObj[@"noise"] intValue];
            int noiselessRoomAmt = [jsonObj[@"noiseless"] intValue];
            [self setupRoomStatUI:noiseRoomAmt withNoiseless:noiselessRoomAmt];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error AFHTTP: %@ Response: %@", operation.response.URL, operation.responseString);
        
        
    }];
}



#pragma mark - Navigation
/*
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
