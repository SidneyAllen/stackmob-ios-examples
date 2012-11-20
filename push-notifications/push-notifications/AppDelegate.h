//
//  AppDelegate.h
//  push-notifications
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class SMClient;
@class SMPushClient;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) SMClient *client;
@property (strong, nonatomic) SMPushClient *pushClient;

@end
