//
//  Todo.h
//  geo-location
//
//  Created by Carl Atupem on 2/13/13.
//  Copyright (c) 2013 StackMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Todo : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * todoId;
@property (nonatomic, retain) id location;

@end
