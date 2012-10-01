//
//  User.m
//  user-authentication
//
//  Created by Matt Vaznaian on 9/30/12.
//  Copyright (c) 2012 StackMob. All rights reserved.
//

#import "User.h"


@implementation User

@dynamic username;
@dynamic password;

+ (NSString *)primaryKeyFieldName{
    return @"username";
}

@end
