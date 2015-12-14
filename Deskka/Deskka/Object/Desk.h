//
//  Desk.h
//  Deskka
//
//  Created by IndyZa on 12/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Room.h"

@interface Desk : NSObject

@property int deskId;
@property NSString* name;
//@property int roomId;
@property int userId;
@property BOOL isAvailable;

@property Room *room;

-(id) initWithDictionary: (NSDictionary *) deskDict;

-(id) initWithDeskId:(int) newDeskId roomId:(int) newRoomId;
-(id) initWithDeskId:(int) newDeskId roomId:(int) newRoomId isAvailable:(BOOL) newIsAvailable;

@end
