//
//  ViewController.m
//  base-project
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
/*
 Import the StackMob header file.
 */
#import "StackMob.h"
/*
Import the Todo header file.
 */
#import "Todo.h"


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
    
    /*
     Set the mapView delegate.
     */
    _mapView.delegate = self;
    
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)saveLocation:(id)sender {
    
    /*
     Get the current longitude and latitude.
     */
    [SMGeoPoint getGeoPointForCurrentLocationOnSuccess:^(SMGeoPoint *geoPoint) {
        
        Todo *todo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:self.managedObjectContext];
        todo.todoId = [todo assignObjectId];
        todo.title = @"My Location";
        todo.location = [NSKeyedArchiver archivedDataWithRootObject:geoPoint];
        
        /*
         Save the location to StackMob.
         */
       [self.managedObjectContext saveOnSuccess:^{
           NSLog(@"Created new object in Todo schema");
       } onFailure:^(NSError *error) {
            NSLog(@"Error creating object: %@", error);
       }];
        
    } onFailure:^(NSError *error) {
        NSLog(@"Error getting SMGeoPoint: %@", error);
    }];
}
@end
