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
#import "SMTwitterCredentials.h"

@interface ViewController ()

@property (nonatomic, strong) SMTwitterCredentials *twitterCredentials;

@end

@implementation ViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize twitterCredentials = _twitterCredentials;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.managedObjectContext = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
    
    self.twitterCredentials = [[SMTwitterCredentials alloc] initWithTwitterConsumerKey:@"TWITTER_APP_KEY" secret:@"TWITTER_APP_SECRET"];
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

- (IBAction)loginUser:(id)sender {
    
    // This will usually return true if you are using the simulator, even if there are no accounts
    if (self.twitterCredentials.twitterAccountsAvailable) {
        
        /*
         SMTwitterCredentials method for Twitter auth workflow.
         Pass nil for username to show a pop-up to the user and allow them to select from the available accounts.
         Pass an account username to search and use that account without any user interaction. Great technique for a "stay logged in" feature
         */
        [self.twitterCredentials retrieveTwitterCredentialsForAccount:nil onSuccess:^(NSString *token, NSString *secret, NSDictionary *fullResponse) {
            
            /*
             StackMob method to login with Twitter token and secret.  A StackMob user will be created with the username provided if one doesn't already exist attached to the provided credentials.
             */
            [[SMClient defaultClient] loginWithTwitterToken:token twitterSecret:secret createUserIfNeeded:YES usernameForCreate:fullResponse[@"screen_name"] onSuccess:^(NSDictionary *result) {
                NSLog(@"Successful Login with Twitter: %@", result);
            } onFailure:^(NSError *error) {
                NSLog(@"Login failed: %@", error);
            }];
            
        } onFailure:^(NSError *error) {
            NSLog(@"Twitter Auth Error: %@", error);
        }];
        
    } else {
        // Handle no Twitter accounts available on device
        NSLog(@"No Tiwtter accounts found on device.");
    }
    
}

- (IBAction)checkStatus:(id)sender {
    
    NSLog(@"%@",[[SMClient defaultClient] isLoggedIn] ? @"Logged In" : @"Logged Out");
    
    /*
     StackMob method to grab the currently logged in user's Twitter information.
     This assumes the user was logged in user Twitter credentials.
     */
    [[SMClient defaultClient] getLoggedInUserTwitterInfoOnSuccess:^(NSDictionary *result) {
        NSLog(@"Logged In User Twitter Info, %@", result);
    } onFailure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
}

- (IBAction)logoutUser:(id)sender {
    
    /*
     StackMob method to logout the currently logged in user.
     */
    [[SMClient defaultClient] logoutOnSuccess:^(NSDictionary *result) {
        NSLog(@"Logged out.");
    } onFailure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
}

@end
