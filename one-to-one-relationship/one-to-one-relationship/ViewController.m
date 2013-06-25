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
#import "Todo.h"
#import "Category.h"

@interface ViewController ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation ViewController

@synthesize managedObjectContext = _managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.managedObjectContext = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
    
    Todo *newTodo = [NSEntityDescription insertNewObjectForEntityForName:@"Todo" inManagedObjectContext:self.managedObjectContext];
    
    [newTodo setValue:@"Hello One-To-One" forKey:@"title"];
    [newTodo setValue:[newTodo assignObjectId] forKey:[newTodo primaryKeyField]];
    
    Category *newCategory = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:self.managedObjectContext];
    
    [newCategory setValue:@"Work" forKey:@"name"];
    [newCategory setValue:[newCategory assignObjectId] forKey:[newCategory primaryKeyField]];
    
    
    NSError *error = nil;
    if (![self.managedObjectContext saveAndWait:&error]) {
        NSLog(@"There was an error! %@", error);
    }
    else {
        NSLog(@"You created a Todo and Category object!");
    }
    
    [newTodo setCategory:newCategory];
    
    [self.managedObjectContext saveOnSuccess:^{
        
        NSLog(@"You created a relationship between the Todo and Category Object!");
        
    } onFailure:^(NSError *error) {
        
        NSLog(@"There was an error! %@", error);
        
    }];
    
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
