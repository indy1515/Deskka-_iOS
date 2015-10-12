//
//  Floor.h
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Floor : NSObject

@property int floorId;
@property NSString* name;
@property int max_amount;
@property int current_available;


- (id) initWithName:(NSString *) newName maxAmount:(int) newMaxAmount currentAvailable:(int) newCurrentAvailableAmount;

/**
 * Show Availability of the floor
 **/
- (float) getAvailablePercent;

@end
