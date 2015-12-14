//
//  Floor.m
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "Floor.h"

@implementation Floor

-(id) init{
    if(self =[super init]){
        self.floorId = -1;
        self.isAvailable = false;
        self.name = @"NULL";
    }
    
    return self;
}

- (id) initWithName:(NSString *) newName{
    if(self =[super init]){
        
        self.floorId = -1;
        self.isAvailable = false;
        self.name = newName;
    }
    
    return self;
}

-(id) initWithDictionary: (NSDictionary *) floorDict{
    if(self =[super init]){
        self.floorId = [floorDict[@"id"]intValue];
        self.isAvailable = [floorDict[@"isAvailable"] boolValue];
        self.name = floorDict[@"name"];
       
    }
    
    return self;
}



@end
