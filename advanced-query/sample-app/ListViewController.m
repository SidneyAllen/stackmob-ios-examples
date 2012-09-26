//
//  ListViewController.m
//  read
//
//  Created by Sidney Maestre on 8/29/12.
//  Copyright (c) 2012 Sidney Maestre. All rights reserved.
//

#import "ListViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"

@interface ListViewController ()

@end

@implementation ListViewController

@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = _managedObjectContext;

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.managedObjectContext = [self.appDelegate managedObjectContext];
    
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:self.managedObjectContext];
    
    [newManagedObject setValue:@"Hello World" forKey:@"title"];
    [newManagedObject setValue:[NSNumber numberWithInt:5] forKey:@"count"];
    [newManagedObject setValue:[newManagedObject sm_assignObjectId] forKey:[newManagedObject sm_primaryKeyField]];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"There was an error! %@", error);
    }
    else {
        NSLog(@"You created a new object!");
    }
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    
    /***********************************
     BELOW is an example of a compound predicate supported in
     queries with StackMob. You can create multiple predicates
     and combine them using "and".  To see examples of a type
     of predicates supported, see Basic Query examples
     ************************************/
    
    // EQUAL EXAMPLE
    NSPredicate *equalPredicate =[NSPredicate predicateWithFormat:@"title == %@", @"Hello World"];
    [fetchRequest setPredicate:equalPredicate];
    
    // LESS THAN EXAMPLE
    NSPredicate *lessThanPredicate =[NSPredicate predicateWithFormat:@"count > %d", 2];
    [fetchRequest setPredicate:lessThanPredicate];
    
    // COMPOUND PREDICATE using AND
    NSArray *predicates = [[NSArray alloc]initWithObjects:equalPredicate,lessThanPredicate,nil];
    NSPredicate *compoundPredicate =[NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    [fetchRequest setPredicate:compoundPredicate];

    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    NSLog(@"An error %@, %@", error, [error userInfo]);
	}
    
    return __fetchedResultsController;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [object valueForKey:@"title"];
    
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


@end
