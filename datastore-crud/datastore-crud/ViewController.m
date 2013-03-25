/*
 * Copyright 2012-2013 StackMob
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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
