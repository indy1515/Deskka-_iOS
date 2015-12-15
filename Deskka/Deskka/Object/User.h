//
//  User.h
//  Deskka
//
//  Created by IndyZa on 12/16/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property int userId;
@property NSString* chulaId;
@property NSString* password;
@property NSString* firstname;
@property NSString* lastname;
@property NSString* faculty;
@property NSString* major;
@property NSString* year;

-(id) initWithDictionary:(NSDictionary*) userDict;
- (BOOL) nilEqual:(id) b;
@end
