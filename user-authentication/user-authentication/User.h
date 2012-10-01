//
//  User.h
//  user-authentication
//
//  Created by Matt Vaznaian on 9/30/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "SMModel.h"


@interface User : NSManagedObject <SMModel>

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * password;

@end
