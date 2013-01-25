//
//  ViewController.m
//  read
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize managedObjectContext = _managedObjectContext;

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)readObjects:(id)sender {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Edit the entity name as appropriate.
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    // set any predicates or sort descriptors, etc.
    
    // execute the request
    [self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
        
        NSLog(@"%@",results);
        
    } onFailure:^(NSError *error) {
        
        NSLog(@"Error fetching: %@", error);
        
    }];
    
    // Uncomment the following to return managed object IDs instead of managed objects.
    
    /*
    [self.managedObjectContext executeFetchRequest:fetchRequest returnManagedObjectIDs:YES onSuccess:^(NSArray *results) {
        
        NSLog(@"%@",results);
        
    } onFailure:^(NSError *error) {
        
        NSLog(@"Error fetching: %@", error);
        
    }];
     */
    
}
@end
