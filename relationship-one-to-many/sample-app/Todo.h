//
//  Todo.h
//  relationship-one-to-many
//
//  Created by Sidney Maestre on 9/4/12.
//  Copyright (c) 2012 Sidney Maestre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category;

@interface Todo : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * todo_id;
@property (nonatomic, retain) NSSet *categories;
@end

@interface Todo (CoreDataGeneratedAccessors)

- (void)addCategoriesObject:(Category *)value;
- (void)removeCategoriesObject:(Category *)value;
- (void)addCategories:(NSSet *)values;
- (void)removeCategories:(NSSet *)values;

@end
