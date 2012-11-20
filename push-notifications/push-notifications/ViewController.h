//
//  ViewController.h
//  push-notifications
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMPushClient;

@interface ViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) SMPushClient *pushClient;

- (IBAction)registerDevice:(id)sender;

@end
