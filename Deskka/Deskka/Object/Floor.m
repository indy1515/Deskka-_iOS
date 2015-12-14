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

- (id) initWithId:(int)newId withName:(NSString *) newName maxAmount:(int) newMaxAmount currentAvailable:(int) newCurrentAvailableAmount isAvailable:(BOOL) isAvailable{
    if(self =[super init]){
        self.floorId = newId;
        self.isAvailable = isAvailable;
        self.name = newName;
        self.current_available = newCurrentAvailableAmount;
        self.max_amount = newMaxAmount;
    }
    return self;
}



-(id) initWithDictionary: (NSDictionary *) floorDict{
    if(self =[super init]){
        self.floorId = [floorDict[@"id"]intValue];
        self.isAvailable = [floorDict[@"isAvailable"] boolValue];
        self.name = floorDict[@"name"];
        if([floorDict objectForKey:@"deskAvailability"]){
            int availability = [floorDict[@"deskAvailability"][@"available"] intValue];
            int unavailability = [floorDict[@"deskAvailability"][@"unavailable"] intValue];
            
        }
       
    }
    
    return self;
}



@end
