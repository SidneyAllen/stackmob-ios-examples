//
//  ViewController.h
//  datastore-crud
//
//  Created by Matt Vaznaian on 9/30/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (strong, nonatomic) NSString *myObjectId;

- (IBAction)createObject:(id)sender;
- (IBAction)readObject:(id)sender;
- (IBAction)updateObject:(id)sender;
- (IBAction)deleteObject:(id)sender;

@end
