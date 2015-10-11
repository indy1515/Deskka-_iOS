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
        self.name = @"NULL";
        self.current_available = -1;
        self.max_amount = -1;
    }
    
    return self;
}

- (id) initWithName:(NSString *) newName maxAmount:(int) newMaxAmount currentAvailable:(int) newCurrentAvailableAmount{
    if(self =[super init]){
        self.name = newName;
        self.current_available = newCurrentAvailableAmount;
        self.max_amount = newMaxAmount;
    }
    
    return self;
}


- (float) getAvailablePercent{
    return ((float)self.current_available/self.max_amount)*100;
}
@end
