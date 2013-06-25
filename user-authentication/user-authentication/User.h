//
//  User.h
//  user-authentication
//
//  Created by Matt Vaznaian on 6/25/13.
//  Copyright (c) 2013 StackMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StackMob.h"

@interface User : SMUserManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSDate * createddate;
@property (nonatomic, retain) NSDate * lastmoddate;

- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context;

@end
