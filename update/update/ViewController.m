//
//  ViewController.m
//  update
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
@synthesize titleField = _titleField;
@synthesize todoId = _todoId;

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.managedObjectContext = [self.appDelegate managedObjectContext];
    self.titleField.delegate = self;
    
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:self.managedObjectContext];
    
    [newManagedObject setValue:@"Hello World" forKey:@"title"];
    self.todoId = [newManagedObject assignObjectId];
    [newManagedObject setValue:self.todoId forKey:[newManagedObject primaryKeyField]];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"There was an error! %@", error);
    }
    else {
        NSLog(@"You created a new object!");
    }
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

- (IBAction)updateObject:(id)sender {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Todo"];
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"todoId == %@", self.todoId];
    [fetchRequest setPredicate:predicte];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (!error) {
        NSManagedObject *todoObject = [results objectAtIndex:0];
        [todoObject setValue:self.titleField.text forKey:@"title"];
        error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"There was an error! %@", error);
        }
        else {
            NSLog(@"You saved!");
        }
    }
}
@end
