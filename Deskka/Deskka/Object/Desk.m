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
        self.roomId = -1;
        self.isAvailable = false;
        
    }
    
    return self;
}

-(id) initWithDeskId:(int) newDeskId roomId:(int) newRoomId{
    if(self =[super init]){
        self.deskId = newDeskId;
        self.roomId = newRoomId;
        self.isAvailable = false;
        
    }
    
    return self;
}

-(id) initWithDeskId:(int) newDeskId roomId:(int) newRoomId isAvailable:(BOOL) newIsAvailable{
    if(self =[super init]){
        self.deskId = newDeskId;
        self.roomId = newRoomId;
        self.isAvailable = newIsAvailable;
        
    }
    
    return self;
}


@end
