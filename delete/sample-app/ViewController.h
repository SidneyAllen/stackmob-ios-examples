//
//  ViewController.h
//  sample-app
//
//  Created by Sidney Maestre on 8/29/12.
//  Copyright (c) 2012 Sidney Maestre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StackMob.h"

@interface ViewController : UIViewController
{
    NSManagedObject *aManagedObject;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (IBAction)deleteObject:(id)sender;


@end
