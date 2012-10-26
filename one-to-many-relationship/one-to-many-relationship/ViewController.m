//
//  ViewController.m
//  one-to-many-relationship
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "Todo.h"
#import "Category.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize managedObjectContext = _managedObjectContext;

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.managedObjectContext = [self.appDelegate managedObjectContext];
    
    Todo *newTodo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:self.managedObjectContext];
    
    [newTodo setValue:@"Hello One-To-Many" forKey:@"title"];
    [newTodo setValue:[newTodo assignObjectId] forKey:[newTodo primaryKeyField]];
    
    Category *newCategory = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:self.managedObjectContext];
    
    [newCategory setValue:@"Work" forKey:@"name"];
    [newCategory setValue:[newCategory assignObjectId] forKey:[newCategory primaryKeyField]];
    
    Category *newCategory2 = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:self.managedObjectContext];
    
    [newCategory2 setValue:@"Home" forKey:@"name"];
    [newCategory2 setValue:[newCategory2 assignObjectId] forKey:[newCategory primaryKeyField]];
    
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"There was an error! %@", error);
    }
    else {
        NSLog(@"You created a Todo and two Category objects!");
    }
    
    [newTodo addCategoriesObject:newCategory];
    [newTodo addCategoriesObject:newCategory2];
    
    error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"There was an error! %@", error);
    }
    else {
        NSLog(@"You created a relationship between the Todo and Category Objects!");
    }
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

@end
