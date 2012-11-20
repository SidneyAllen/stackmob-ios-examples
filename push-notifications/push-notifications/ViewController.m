//
//  ViewController.m
//  push-notifications
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize pushClient = _pushClient;

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pushClient = self.appDelegate.pushClient;
    self.managedObjectContext = [self.appDelegate managedObjectContext];
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

- (IBAction)registerDevice:(id)sender {
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert];
    
}

@end
