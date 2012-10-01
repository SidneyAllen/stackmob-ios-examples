//
//  ViewController.m
//  datastore-crud
//
//  Created by Matt Vaznaian on 9/30/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize myTextField;
@synthesize myObjectId = _myObjectId;

- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.myObjectId = nil;
    self.myTextField.delegate = self;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setMyTextField:nil];
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

- (IBAction)createObject:(id)sender {
    
    NSDictionary *arguments = [NSDictionary dictionaryWithObject:[myTextField text] forKey:@"name"];
    
    [[[SMClient defaultClient] dataStore] createObject:arguments inSchema:@"todo" onSuccess:^(NSDictionary *theObject, NSString *schema) {
        NSLog(@"Created object %@ in schema %@", theObject, schema);
        self.myObjectId = [theObject objectForKey:@"todo_id"];
    } onFailure:^(NSError *theError, NSDictionary *theObject, NSString *schema) {
        NSLog(@"Error creating object: %@", theError);
    }];
    
}

- (IBAction)readObject:(id)sender {
    
    [[[SMClient defaultClient] dataStore] readObjectWithId:self.myObjectId inSchema:@"todo" onSuccess:^(NSDictionary *theObject, NSString *schema) {
        NSLog(@"Result of read is %@", theObject);
    } onFailure:^(NSError *theError, NSString *theObjectId, NSString *schema) {
        NSLog(@"Error reading object: %@", theError);
    }];
    
}

- (IBAction)updateObject:(id)sender {
    
    NSDictionary *arguments = [NSDictionary dictionaryWithObject:[myTextField text] forKey:@"name"];
    
    [[[SMClient defaultClient] dataStore] updateObjectWithId:self.myObjectId inSchema:@"todo" update:arguments onSuccess:^(NSDictionary *theObject, NSString *schema) {
        NSLog(@"Result of update is %@", theObject);
    } onFailure:^(NSError *theError, NSDictionary *theObject, NSString *schema) {
        NSLog(@"Error updating object: %@", theError);
    }];
    
}

- (IBAction)deleteObject:(id)sender {
    
    [[[SMClient defaultClient] dataStore] deleteObjectId:self.myObjectId inSchema:@"todo" onSuccess:^(NSString *theObjectId, NSString *schema) {
        NSLog(@"Deleted object %@", theObjectId);
        self.myObjectId = nil;
    } onFailure:^(NSError *theError, NSString *theObjectId, NSString *schema) {
        NSLog(@"Error deleting object: %@", theError);
    }];
    
}
@end
