//
//  User.h
//  user-object
//
//  Created by Matt Vaznaian on 9/30/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StackMob.h"


@interface User : SMUserManagedObject

@property (nonatomic, retain) NSString * username;

- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context;

@end
