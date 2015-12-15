//
//  LoginViewController.m
//  Deskka
//
//  Created by aey howatt on 12/15/15.
//  Copyright © 2015 IndyZaLab. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.fieldId becomeFirstResponder];
    [self.btnGo setEnabled:NO];
    [self setupOnClick];
    [self setupListener];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(NSNotification *)notification {
    // Do whatever you like to respond to text changes here.
    [self checkField];
}

#pragma mark - Setup

- (void) setupOnClick{
    [self.btnGo addTarget:self action:@selector(onClickGoButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) setupListener{
    [self.fieldId addTarget:self 
                     action:@selector(textFieldDidChange:) 
           forControlEvents:UIControlEventEditingChanged];
    [self.fieldPsw addTarget:self 
                      action:@selector(textFieldDidChange:) 
            forControlEvents:UIControlEventEditingChanged];
}


#pragma mark - Internet & Fetching

- (void) fetchUserList{
    NSLog(@"Fetching User List");
    NSString *URLString = @"http://188.166.214.252/index.php/users";
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
                User *user = [[User alloc] initWithDictionary:dict];
                [addedArray addObject:user];
            }
            NSLog(@"No of added item %lu",(unsigned long)addedArray.count);
            
        }
        [self forwardUserList:addedArray];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error AFHTTP: %@ Response: %@", operation.response.URL, operation.responseString);
        
        [self fetchUserList];

        
    }];
    
}
#pragma mark - Processing

- (void) forwardUserList:(NSMutableArray *) userList{
    User* foundUser = [self checkUsernamePasswordWithUserList:userList];
    if(foundUser){
        //save user
        NSMutableArray * userList = [[NSMutableArray alloc] init];
        [userList insertObject:foundUser atIndex:0];
        [LocalStorage saveUser:userList];
        [self toMainViewController:nil];
        
    }
}

- (void) processUsernamePassword{
    [self fetchUserList];
}


- (User *) checkUsernamePasswordWithUserList:(NSMutableArray *) userList{
    for(User* user in userList){
        if([user.chulaId isEqual:self.fieldId.text]){
            if([user.password isEqual:self.fieldPsw.text]){
                return user;
            }
        }
    }
    
    return nil;
}



#pragma mark - onClick

- (void) onClickGoButton:(UIGestureRecognizer *)recognizer{
    [self processUsernamePassword];
}


#pragma mark - Navigation




- (void) toMainViewController:(UIGestureRecognizer *)recognizer{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AnyViewControllerDismissed" 
                                                        object:nil 
                                                      userInfo:nil];
}






- (void)checkField {
    if ([self.fieldId.text length] != 0 && [self.fieldPsw.text length] != 0) {
        [self.btnGo setEnabled:YES];
    }
    else {
        [self.btnGo setEnabled:NO];
    }
}





@end
