//
//  Category.h
//  one-to-many-relationship
//
//  Created by Matt Vaznaian on 9/30/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Todo;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * categoryId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Todo *todo;

@end
