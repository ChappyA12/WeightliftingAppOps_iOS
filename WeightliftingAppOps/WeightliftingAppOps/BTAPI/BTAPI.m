//
//  BTAPI.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 7/13/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "BTAPI.h"

@implementation BTAPI

+ (BTAPI *)sharedInstance {
    static BTAPI *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
        shared.users = BTAPIUsersManager.sharedInstance;
    });
    return shared;
}

@end
