//
//  Desk.h
//  Deskka
//
//  Created by IndyZa on 12/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Desk : NSObject

@property int deskId;
@property int roomId;
@property BOOL isAvailable;


-(id) initWithDeskId:(int) newDeskId roomId:(int) newRoomId;
-(id) initWithDeskId:(int) newDeskId roomId:(int) newRoomId isAvailable:(BOOL) newIsAvailable;

@end
