//
//  ViewController.h
//  datastore-crud
//
//  Created by Matt Vaznaian on 9/26/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *myTextField;
@property (strong, nonatomic) NSString *myObjectId;

- (IBAction)create:(id)sender;
- (IBAction)read:(id)sender;
- (IBAction)update:(id)sender;
- (IBAction)delete:(id)sender;

@end
