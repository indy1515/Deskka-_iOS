//
//  Room.m
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import "Room.h"

@implementation Room

-(id) init{
    if(self =[super init]){
        self.roomId = -1;
        self.isAvailable = false;
        self.name = @"NULL";
        self.typeId = -1;
    }
    
    return self;
}

- (id) initWithName:(NSString *) newName type:(int) newType{
    if(self =[super init]){
        self.roomId = -1;
        self.isAvailable = false;
        self.name = newName;
        self.typeId = newType;
    }
    
    return self;
}

-(id) initWithDictionary: (NSDictionary *) roomDict{
    if(self =[super init]){
        if(roomDict[@"floor"]){
            self.floor = [[Floor alloc] initWithDictionary:roomDict[@"floor"]];
        }
        self.roomId = [roomDict[@"id"]intValue];
        self.isAvailable = [roomDict[@"isAvailable"] boolValue];
        self.name = roomDict[@"name"];
        self.typeId = [roomDict[@"roomType_id"]intValue];

    }

    return self;
}

@end
