//
//  ViewController.h
//  sample-app
//
//  Created by Sidney Maestre on 8/29/12.
//  Copyright (c) 2012 Sidney Maestre. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMClient.h"

@interface ViewController : UIViewController  <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) SMClient *client;

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


- (IBAction)createNewUser:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)checkStatus:(id)sender;
- (IBAction)logout:(id)sender;

@end
