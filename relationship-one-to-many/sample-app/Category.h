//
//  Category.h
//  relationship-one-to-many
//
//  Created by Sidney Maestre on 9/4/12.
//  Copyright (c) 2012 Sidney Maestre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Todo;

@interface Category : NSManagedObject

@property (nonatomic, retain) NSString * category_id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Todo *todo;

@end
