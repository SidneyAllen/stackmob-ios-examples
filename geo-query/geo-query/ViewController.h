//
//  ViewController.h
//  base-project
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (IBAction)saveLocation:(id)sender;
- (IBAction)geoQuery:(id)sender;

@end
