//
//  ViewController.m
//  create
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize titleField = _titleField;

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.managedObjectContext = [self.appDelegate managedObjectContext];
    self.titleField.delegate = self;
}

- (void)viewDidUnload
{
    [self setTitleField:nil];
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

- (IBAction)createNewObject:(id)sender {
    
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:self.managedObjectContext];
    
    [newManagedObject setValue:self.titleField.text forKey:@"title"];
    [newManagedObject setValue:[newManagedObject assignObjectId] forKey:[newManagedObject primaryKeyField]];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"There was an error! %@", error);
    }
    else {
        NSLog(@"You created a new object!");
    }
}
@end
