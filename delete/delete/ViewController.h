//
//  ViewController.h
//  delete
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
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
