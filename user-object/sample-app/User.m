//
//  User.m
//  sample-app
//
//  Created by Sidney Maestre on 9/6/12.
//  Copyright (c) 2012 Sidney Maestre. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic username;
@dynamic password;

+ (NSString *)primaryKeyFieldName{
    return @"username";
}

@end
