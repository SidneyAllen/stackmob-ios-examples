//
//  Todo.h
//  one-to-one-relationship
//
//  Created by Matt Vaznaian on 9/30/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Todo : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * todoId;
@property (nonatomic, retain) Category *category;

@end
