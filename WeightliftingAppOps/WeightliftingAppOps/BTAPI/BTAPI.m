//
//  BTAPI.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 7/13/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "BTAPI.h"

@implementation BTAPI

+ (BTAPIUsersManager *)users {
    return BTAPIUsersManager.sharedInstance;
}

@end
