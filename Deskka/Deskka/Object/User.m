//
//  User.m
//  Deskka
//
//  Created by IndyZa on 12/16/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize chulaId;
@synthesize password;
@synthesize firstname;
@synthesize lastname;
@synthesize faculty;
@synthesize major;
@synthesize year;

-(id) init{
    if(self =[super init]){
        self.userId = -1;
        self.chulaId = @"";
        self.password = @"";
        self.firstname = @"";
        self.lastname = @"";
        self.faculty = @"";
        self.major = @"";
        self.year = @"";
    }
    
    return self;
}

-(id) initWithDictionary:(NSDictionary*) userDict{
    if(self =[super init]){
        self.userId = [userDict[@"id"] intValue];
        self.password = userDict[@"password"];
        self.chulaId = userDict[@"chulaID"];
        self.firstname = userDict[@"name"];
        self.lastname = userDict[@"lastName"];
        self.faculty = userDict[@"faculty"];
        self.major = userDict[@"major"];
        self.year = userDict[@"year"];
    }
    
    return self;
}

- (BOOL) nilEqual:(id) b 
{
    id a = self;
    return (a == nil && b == nil) || [a isEqual:b];
}
@end
