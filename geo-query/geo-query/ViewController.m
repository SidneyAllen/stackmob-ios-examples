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
#import "SMQuery.h"

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
    
    /*
     Initialize the locationManager and call the updating location method.
     */
    locationController = [[MyCLController alloc] init];
    [locationController.locationManager startUpdatingLocation];
    
    self.managedObjectContext = [self.appDelegate managedObjectContext];
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
    NSDecimalNumber *latDecimal = [[NSDecimalNumber alloc] initWithDouble:locationController.locationManager.location.coordinate.latitude];
    NSDecimalNumber *lonDecimal = [[NSDecimalNumber alloc] initWithDouble:locationController.locationManager.location.coordinate.longitude];
    
    /*
     Make an NSDictionary with the latitude and longitude.
     */
    NSDictionary *location = [NSDictionary dictionaryWithObjectsAndKeys:
                              latDecimal
                              ,@"lat"
                              ,lonDecimal
                              ,@"lon", nil];
    
    /*
     Save the location to StackMob.
     */
    NSDictionary *arguments = [NSDictionary dictionaryWithObjectsAndKeys:@"My Location", @"name", location, @"location", nil];
    
    [[[SMClient defaultClient] dataStore] createObject:arguments inSchema:@"todo" onSuccess:^(NSDictionary *theObject, NSString *schema) {
        NSLog(@"Created object %@ in schema %@", theObject, schema);
        
    } onFailure:^(NSError *theError, NSDictionary *theObject, NSString *schema) {
        NSLog(@"Error creating object: %@", theError);
    }];
}

- (IBAction)geoQuery:(id)sender {
    
    SMQuery *qry = [[SMQuery alloc] initWithSchema:@"todo"];
    [qry where:@"location" isWithin:10 milesOf:locationController.locationManager.location.coordinate];
    [[[SMClient defaultClient] dataStore] performQuery:qry onSuccess:^(NSArray *results) {
        NSLog(@"Successful query %@", results);
    } onFailure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}
@end
