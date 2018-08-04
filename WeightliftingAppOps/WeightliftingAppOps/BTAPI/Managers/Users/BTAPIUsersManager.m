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

- (void)update:(BTAPIUser *)user completion:(void(^)(bool))completion {
    [self performRequest:[BTAPIRequest method:POST path:@"users/update.php" body:user.toDictionary]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(false);
                      return;
                  }
                  completion(true);
              }];
}

- (void)all:(void(^)(NSArray<BTAPIUser *> *users))completion {
    [self performRequest:[BTAPIRequest method:GET path:@"users/query.php" body:nil]
              completion:^(NSDictionary *response, NSError *error) {
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
                      completion(nil);
                      return;
                  }
                  completion(users);
              }];
}

@end
