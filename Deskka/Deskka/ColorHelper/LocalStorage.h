//
//  LocalStorage.h
//  Deskka
//
//  Created by IndyZa on 12/16/2558 BE.
//  Copyright © 2558 IndyZaLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface LocalStorage : NSObject

+ (NSMutableArray *) loadUser;
+ (void) saveUser:(NSMutableArray *) userList ;
@end
