//
//  Room.h
//  Deskka
//
//  Created by IndyZa on 10/12/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Room : NSObject

@property int roomId;
@property NSString *name;
@property int occupy;
@property int max_amount;
@property int type;

@end
