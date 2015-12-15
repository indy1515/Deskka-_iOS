//
//  LocalStorage.m
//  Deskka
//
//  Created by IndyZa on 12/16/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "LocalStorage.h"

@implementation LocalStorage


#pragma mark - save/load

+ (NSMutableArray *) loadUser{
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

+ (void) saveUser:(NSMutableArray *) userList {
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
