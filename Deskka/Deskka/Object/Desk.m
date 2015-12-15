//
//  Desk.m
//  Deskka
//
//  Created by IndyZa on 12/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "Desk.h"

@implementation Desk

-(id) init{
    if(self =[super init]){
        self.deskId = -1;
        self.name = @"";
        self.userId = -1;
        self.isAvailable = false;
    }
    
    return self;
}

-(id) initWithDeskId:(int) newDeskId roomId:(int) newRoomId{
    if(self =[super init]){
        self.deskId = newDeskId;
        self.name = @"";
        self.userId = -1;
        self.isAvailable = false;
    }
    
    return self;
}

-(id) initWithDeskId:(int) newDeskId roomId:(int) newRoomId isAvailable:(BOOL) newIsAvailable{
    if(self =[super init]){
        self.deskId = newDeskId;
        self.name = @"";
        self.userId = -1;
        self.isAvailable = newIsAvailable;
        
    }
    
    return self;
}


-(id) initWithDictionary: (NSDictionary *) deskDict{
    if(self =[super init]){
        self.deskId = [deskDict[@"id"] intValue];
        self.name = deskDict[@"name"];
        if(deskDict[@"room"]){
            self.room = [[Room alloc] initWithDictionary:deskDict[@"room"]];
        }
        if(![deskDict[@"user_id"] isEqual:[NSNull null]]){
            self.userId = [deskDict[@"user_id"] intValue];
        }
        self.isAvailable = [deskDict[@"isAvailable"] boolValue];
        
    }
    
    return self;
}

@end
