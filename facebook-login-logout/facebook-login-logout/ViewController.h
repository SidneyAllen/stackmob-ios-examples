//
//  ViewController.h
//  facebook-login-logout
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMClient.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) SMClient *client;
@property (weak, nonatomic) IBOutlet UIButton *buttonLoginLogout;

- (IBAction)buttonClickHandler:(id)sender;
- (IBAction)checkStatus:(id)sender;
@end
