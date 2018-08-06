//
//  BTAPIUser.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 8/3/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "BTAPIUser.h"

@implementation BTAPIUser

+ (BTAPIUser *)username:(NSString *)username {
    BTAPIUser *user = [[BTAPIUser alloc] init];
    user.username = username;
    return user;
}

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"name"])
        return NO;
    return YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [JSONKeyMapper mapperForSnakeCase];
}

- (BOOL)isEqual:(BTAPIUser *)other {
    return [self.username isEqualToString:other.username];
}

@end
