//
//  ViewController.h
//  user-authentication
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SMClient;

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) SMClient *client;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (IBAction)createUser:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)checkStatus:(id)sender;
- (IBAction)logout:(id)sender;

@end
