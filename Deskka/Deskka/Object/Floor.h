//
//  Floor.h
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"
@interface Floor : NSObject

@property int floorId;
@property BOOL isAvailable;
@property NSString* name;
@property int max_amount;
@property int current_available;
//@property NSMutableArray* roomArray;


- (id) initWithName:(NSString *) newName maxAmount:(int) newMaxAmount currentAvailable:(int) newCurrentAvailableAmount;

-(id) initWithDictionary: (NSDictionary *) floorDict;

/**
 * Show Availability of the floor
 **/
- (float) getAvailablePercent;

@end
