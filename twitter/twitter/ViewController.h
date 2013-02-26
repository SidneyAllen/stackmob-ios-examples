//
//  ViewController.h
//  twitter
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIActionSheetDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) NSString *oauthToken;
@property (strong, nonatomic) NSString *oauthTokenSecret;

- (IBAction)loginUser:(id)sender;
- (IBAction)logoutUser:(id)sender;
- (IBAction)checkStatus:(id)sender;

@end
