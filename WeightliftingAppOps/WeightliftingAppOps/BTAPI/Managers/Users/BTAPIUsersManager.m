//
//  BTAPIUsersManager.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 7/13/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "BTAPIUsersManager.h"

@implementation BTAPIUsersManager

+ (BTAPIUsersManager *)sharedInstance {
    static BTAPIUsersManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (void)all:(void(^)(NSArray<BTAPIUser *> *users))completion {
    [self getRequestWithPath:@"users/query.php" completion:^(NSDictionary *response, NSError *error) {
        if (error || !response[@"users"]) {
            NSLog(@"%@",error);
            completion(nil);
            return;
        }
        NSArray <NSDictionary *> *rawUsers = response[@"users"];
        NSError *jsonError;
        NSArray <BTAPIUser *> *users = [BTAPIUser arrayOfModelsFromDictionaries:rawUsers error:&jsonError];
        if (error) {
            NSLog(@"error");
        }
        completion(users);
    }];
}

@end
