//
//  ViewController.m
//  sample-app
//
//  Created by Sidney Maestre on 8/29/12.
//  Copyright (c) 2012 Sidney Maestre. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize usernameField = _usernameField;
@synthesize passwordField = _passwordField;

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	 
    self.managedObjectContext = [self.appDelegate managedObjectContext];
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)viewDidUnload
{
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)createUser:(id)sender {
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    
   	[newManagedObject setValue:self.usernameField.text forKey:[newManagedObject sm_primaryKeyField]];
    [newManagedObject setValue:self.passwordField.text forKey:@"password"];
    
    
    [self.managedObjectContext performBlock:^{
        NSLog(@"Saving context...");
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"There was an error! %@", error);
        }
        else {
            NSLog(@"You created a new object!");
        }
    }];
   	
}
@end
