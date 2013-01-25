//
//  ViewController.m
//  user-object
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "User.h"

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
    // Do any additional setup after loading the view, typically from a nib.
    
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)viewDidUnload
{
    [self setUsernameField:nil];
    [self setPasswordField:nil];
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

- (IBAction)createUser:(id)sender {
    
    User *newUser = [[User alloc] initIntoManagedObjectContext:self.managedObjectContext];
    
    [newUser setValue:self.usernameField.text forKey:[newUser primaryKeyField]];
    [newUser setPassword:self.passwordField.text];
    
    [self.managedObjectContext saveOnSuccess:^{
        
        NSLog(@"You created a new user object!");
        
    } onFailure:^(NSError *error) {
        
        [self.managedObjectContext deleteObject:newUser];
        [newUser removePassword];
        NSLog(@"There was an error! %@", error);
        
    }];
    
}
@end
