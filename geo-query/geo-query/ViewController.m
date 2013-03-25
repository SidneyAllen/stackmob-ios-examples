/*
 * Copyright 2012-2013 StackMob
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
     Get the current location.
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

- (IBAction)geoQuery:(id)sender {
    
    /*
     Get the current location.
     */
    [SMGeoPoint getGeoPointForCurrentLocationOnSuccess:^(SMGeoPoint *geoPoint) {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:self.managedObjectContext];
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:entity];
        
        /*
         Set a predicate with an SMGeoPoint
         */
        SMPredicate *predicate = [SMPredicate predicateWhere:@"location" isWithin:10 milesOfGeoPoint:geoPoint];
        [fetchRequest setPredicate:predicate];
        
        [self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
            NSLog(@"Successful query.");
            [results enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                Todo *todo = obj;
                /*
                 To properly pull out the geo point data, unarchive the NSData into an SMGeoPoint instance.
                 */
                NSData *data = todo.location;
                SMGeoPoint *point = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                NSLog(@"SMGeoPoint for object %i in results: %@", idx, point);
            }];
        } onFailure:^(NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    } onFailure:^(NSError *error) {
        NSLog(@"Error getting SMGeoPoint: %@", error);
    }]; 
}
@end
