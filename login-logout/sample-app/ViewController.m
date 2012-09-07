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
#import "User.h"
#import "SMClient.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize client = _client;
@synthesize usernameField = _usernameField;
@synthesize passwordField = _passwordField;
@synthesize statusLabel = _statusLabel;

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.managedObjectContext = [self.appDelegate managedObjectContext];
    self.client = [self.appDelegate client];
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)viewDidUnload
{
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [self setStatusLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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

- (IBAction)createNewUser:(id)sender {
    
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

- (IBAction)login:(id)sender {
    [self.client loginWithUsername:self.usernameField.text
                            password:self.passwordField.text
                            onSuccess:^(NSDictionary *results) {
                                NSLog(@"Login Success %@",results);
                            }
                            onFailure:^(NSError *error) {
                                  NSLog(@"Login Fail: %@",error);
                            }];
}

- (IBAction)checkStatus:(id)sender {
    if([self.client isLoggedIn]) {
        
        [self.client getLoggedInUserOnSuccess:^(NSDictionary *result) {
            self.statusLabel.text = [NSString stringWithFormat:@"Hello, %@", [result objectForKey:@"username"]];
        } onFailure:^(NSError *error) {
            NSLog(@"No user found");
        }];
        
    } else {
        self.statusLabel.text = @"Nope, not Logged In";
    }
}

- (IBAction)logout:(id)sender {
    [self.client logoutOnSuccess:^(NSDictionary *result) {
         NSLog(@"Success, you are logged out");
    } onFailure:^(NSError *error) {
         NSLog(@"Logout Fail: %@",error);
    }];
}


@end
