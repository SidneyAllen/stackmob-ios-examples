//
//  ListViewController.m
//  read
//
//  Created by Sidney Maestre on 8/29/12.
//  Copyright (c) 2012 Sidney Maestre. All rights reserved.
//

#import "ListViewController.h"
#import "AppDelegate.h"

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
     BELOW are examples of the types of simple predicates supported for
     queries with StackMob. Only one of these simple predicates
     can be used at a time.  To combine them in compound predicate,
     see our Advanced Query Example
     ************************************/
    
    // EQUAL EXAMPLE
    NSPredicate *equalPredicate =[NSPredicate predicateWithFormat:@"title == %@", @"Hello World"];
    [fetchRequest setPredicate:equalPredicate];
    
    // EQUAL ID Example
    NSPredicate *equalByIdPredicate =[NSPredicate predicateWithFormat:@"todo_id == %@", @"3143B4F8-88C6-4E07-8ED4-74F0B9AF779C"];
    [fetchRequest setPredicate:equalByIdPredicate];
    
    // LESS THAN EXAMPLE
    NSPredicate *lessThanPredicate =[NSPredicate predicateWithFormat:@"count < %d", 4];
    [fetchRequest setPredicate:lessThanPredicate];
    
    // LESS THAN OR EQUAL THAN EXAMPLE
    NSPredicate *lessThanOrEqualPredicate =[NSPredicate predicateWithFormat:@"count <= %d", 5];
    [fetchRequest setPredicate:lessThanOrEqualPredicate];
    
    // GREATER THAN EXAMPLE
    NSPredicate *greaterThanPredicate =[NSPredicate predicateWithFormat:@"count > %d", 4];
    [fetchRequest setPredicate:greaterThanPredicate];
    
    // GREATER THAN OR EQUAL EXAMPLE
    NSPredicate *greaterThanOrEqualPredicate =[NSPredicate predicateWithFormat:@"count >= %d", 10];
    [fetchRequest setPredicate:greaterThanOrEqualPredicate];
    
    // NOT EQUAL EXAMPLE
    NSPredicate *notEqualPredicate =[NSPredicate predicateWithFormat:@"title != %@", @"One More"];
    [fetchRequest setPredicate:notEqualPredicate];
    
    // IN EXAMPLE
    NSArray *choice = [[NSArray alloc]initWithObjects:@"maybe",@"never",nil];
    NSPredicate *inPredicate =[NSPredicate predicateWithFormat:@"choice IN %@", choice];
    [fetchRequest setPredicate:inPredicate];
    
    //BETWEEN EXAMPLE
    NSArray *range = [[NSArray alloc]initWithObjects:@"6",@"10",nil];
    NSPredicate *betweenPredicate =[NSPredicate predicateWithFormat:@"count between %@", range];
    [fetchRequest setPredicate:betweenPredicate];
    
    
    
    
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
