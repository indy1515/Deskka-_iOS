//
//  Room.h
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Floor.h"

@interface Room : NSObject

@property int roomId;
@property BOOL isAvailable;
@property NSString *name;
@property int typeId;

//@property NSMutableArray *deskArray;
//@property int occupy;
//@property int max_amount;
//@property int type;

@property Floor *floor;

-(id) initWithDictionary: (NSDictionary *) roomDict;

- (id) initWithName:(NSString *) newName occupy:(int) newOccupy maxAmount:(int) newMaxAmount type:(int) newType;
@end
