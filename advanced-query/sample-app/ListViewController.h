//
//  ListViewController.h
//  read
//
//  Created by Sidney Maestre on 8/29/12.
//  Copyright (c) 2012 Sidney Maestre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class SMClient;

@interface ListViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
