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

- (void)getUsername:(void(^)(NSString *username))completion {
    [self performRequest:[BTAPIRequest method:GET path:@"users/username.php"]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  completion(response[@"username"]);
              }];
}

- (void)insert:(NSString *)username completion:(void(^)(bool success))completion {
    [self performRequest:[BTAPIRequest method:POST path:@"users/insert.php" params:@{@"username": username}]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(false);
                      return;
                  }
                  completion(true);
              }];
}

- (void)changeUsernameFrom:(NSString *)from to:(NSString *)to completion:(void(^)(bool success))completion {
    [self performRequest:[BTAPIRequest method:POST path:@"users/username.php" params:@{@"username_from": from,
                                                                                       @"username_to": to}]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(false);
                      return;
                  }
                  completion([response[@"username"] isEqualToString:to]);
              }];
}

- (void)update:(BTAPIUser *)user completion:(void(^)(bool success))completion {
    NSLog(@"%@", user.toDictionary);
    [self performRequest:[BTAPIRequest method:POST path:@"users/update.php" body:@{@"user": user.toDictionary}]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(false);
                      return;
                  }
                  completion(true);
              }];
}

- (void)logActivity:(NSString *)username completion:(void(^)(bool logged))completion {
    [self performRequest:[BTAPIRequest method:POST path:@"users/update.php" body:@{@"user": @{@"username": username,
                                                                                              @"active_now": @YES}}]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(false);
                      return;
                  }
                  completion(true);
              }];
}

- (void)logOut:(NSString *)username completion:(void(^)(bool loggedOut))completion {
    [self performRequest:[BTAPIRequest method:POST path:@"users/update.php" body:@{@"user": @{@"username": username,
                                                                                              @"active_now": @NO}}]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(false);
                      return;
                  }
                  completion(true);
              }];
}

- (void)delete:(NSString *)username completion:(void(^)(bool deleted))completion {
    [self performRequest:[BTAPIRequest method:DELETE path:@"users/delete.php" params:@{@"username": username}]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error) {
                      NSLog(@"%@",error);
                      completion(false);
                      return;
                  }
                  completion(true);
              }];
}

- (void)exists:(NSString *)username completion:(void(^)(bool success, bool exists))completion {
    [self performRequest:[BTAPIRequest method:POST path:@"users/query.php" body:@{@"query":@{@"username": username,
                                                                                             @"mode": @"exists"}}]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error || !response[@"exists"]) {
                      NSLog(@"%@",error);
                      completion(false, false);
                      return;
                  }
                  completion(true, [response[@"exists"] boolValue]);
              }];
}

- (void)get:(NSString *)username completion:(void(^)(BTAPIUser *user))completion {
    [self performRequest:[BTAPIRequest method:POST path:@"users/query.php" body:@{@"query":@{@"username": username,
                                                                                             @"mode": @"profile"}}]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error || !response[@"users"]) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  NSDictionary *rawUser = response[@"users"];
                  NSError *jsonError;
                  BTAPIUser *user = [[BTAPIUser alloc] initWithDictionary:rawUser error:&jsonError];
                  if (jsonError) {
                      NSLog(@"error");
                      completion(nil);
                      return;
                  }
                  completion(user);
              }];
}

- (void)all:(void(^)(NSArray<BTAPIUser *> *users))completion {
    [self performRequest:[BTAPIRequest method:POST path:@"users/query.php" body:@{@"query":@{@"mode": @"all"}}]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error || !response[@"users"]) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  NSArray <NSDictionary *> *rawUsers = response[@"users"];
                  NSError *jsonError;
                  NSArray <BTAPIUser *> *users = [BTAPIUser arrayOfModelsFromDictionaries:rawUsers error:&jsonError];
                  if (jsonError) {
                      NSLog(@"error");
                      completion(nil);
                      return;
                  }
                  completion(users);
              }];
}

- (void)leaderboard:(BTAPIUserLeaderboardType)type completion:(void(^)(NSArray<BTAPIUser *> *users))completion {
    NSString *sort = (type == BTAPIUserLeaderboardTypeXP) ? @"xp" : @"xp";
    NSString *order = (type == BTAPIUserLeaderboardTypeXP) ? @"DESC" : @"ASC";
    [self performRequest:[BTAPIRequest method:POST path:@"users/query.php" body:@{@"query":@{@"sort": sort,
                                                                                             @"order": order,
                                                                                             @"mode": @"basic"}}]
              completion:^(NSDictionary *response, NSError *error) {
                  if (error || !response[@"users"]) {
                      NSLog(@"%@",error);
                      completion(nil);
                      return;
                  }
                  NSArray <NSDictionary *> *rawUsers = response[@"users"];
                  NSError *jsonError;
                  NSArray <BTAPIUser *> *users = [BTAPIUser arrayOfModelsFromDictionaries:rawUsers error:&jsonError];
                  if (jsonError) {
                      NSLog(@"error");
                      completion(nil);
                      return;
                  }
                  completion(users);
              }];
}

@end
