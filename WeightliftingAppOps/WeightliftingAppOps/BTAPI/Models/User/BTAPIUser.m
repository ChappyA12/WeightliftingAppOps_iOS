//
//  BTAPIUser.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 7/13/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "BTAPIUser.h"

@implementation BTAPIUser

+ (BTAPIUser *)userForDictionary:(NSDictionary *)dict {
    BTAPIUser *user = [[super alloc] init];
    user.name = dict[@"id"];
    user.facebookID = dict[@"facebook_id"];
    user.deviceID = dict[@"device_id"];
    user.dateCreated = dict[@"date_created"];
    user.dateUpdated = dict[@"date_updated"];
    user.loggedIn = dict[@"is_online"];
    return user;
}

- (NSDictionary *)toDictionary {
    return @{@"id": self.name,
             @"facebook_id": self.facebookID,
             @"device_id": self.deviceID,
             @"date_created": self.dateCreated,
             @"date_updated": self.dateUpdated,
             @"is_online": (self.loggedIn) ? @"true" : @"false"};
}

- (NSString *)description {
    return [NSString stringWithFormat:@"id:%@ created: %@ updated: %@ online: %d facebook: %@ device: %@",
                                      self.name, self.dateCreated,self.dateUpdated, self.loggedIn, self.facebookID, self.deviceID];
}

#pragma mark - private helper methods

@end
