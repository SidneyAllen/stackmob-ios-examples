//
//  ViewController.m
//  facebook-login-logout
//
//  Created by Matt Vaznaian on 9/28/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"

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
    
    [self updateView];
    
    self.client = [self.appDelegate client];
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            [self sessionStateChanged:session state:status error:error];
        }];
    }
    
    self.managedObjectContext = [self.appDelegate managedObjectContext];
}

- (void)updateView {

    if ([self.client isLoggedIn]) {
        [self.buttonLoginLogout setTitle:@"Log out" forState:UIControlStateNormal];
    } else {
        [self.buttonLoginLogout setTitle:@"Login with Facebook" forState:UIControlStateNormal];
    }
}

- (void)viewDidUnload
{
    [self setButtonLoginLogout:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)buttonClickHandler:(id)sender {

    if ([self.client isLoggedIn]) {
        [self logoutUser];
    } else {
        [FBSession openActiveSessionWithReadPermissions:nil allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            [self sessionStateChanged:session state:status error:error];
        }];
    }
}

- (IBAction)checkStatus:(id)sender {
    NSLog(@"%@",[self.client isLoggedIn] ? @"Logged In" : @"Logged Out");
    
}

- (void)createUser {
    
    [self.client createUserWithFacebookToken:[NSString stringWithFormat:@"%@",FBSession.activeSession.accessToken] onSuccess:^(NSDictionary *result) {
        NSLog(@"Success %@", result);
        [self loginUser];
    } onFailure:^(NSError *error) {
        NSLog(@"Error: %@", error);
        // User already exists with this FB Token, call Login method
        if (error.code == 401) {
            [self loginUser];
        }
    }];
}

- (void)loginUser {
    
    [self.client loginWithFacebookToken:FBSession.activeSession.accessToken onSuccess:^(NSDictionary *result) {
        NSLog(@"Logged In");
        [self updateView];
    } onFailure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void)logoutUser {
    
    [self.client logoutOnSuccess:^(NSDictionary *result) {
        NSLog(@"Logged Out");
        [self sessionStateChanged:FBSession.activeSession state:FBSessionStateClosed error:nil];
    } onFailure:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            [self createUser];
            break;
        case FBSessionStateClosed:
            [FBSession.activeSession closeAndClearTokenInformation];
            [self updateView];
            break;
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }    
}

@end
