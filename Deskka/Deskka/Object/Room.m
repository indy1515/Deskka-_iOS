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
        self.name = @"NULL";
        self.occupy = -1;
        self.max_amount = -1;
        self.type = -1;
    }
    
    return self;
}

- (id) initWithName:(NSString *) newName occupy:(int) newOccupy maxAmount:(int) newMaxAmount type:(int) newType{
    if(self =[super init]){
        self.name = newName;
        self.occupy = newOccupy;
        self.max_amount = newMaxAmount;
        self.type = newType;
    }
    
    return self;
}



@end
