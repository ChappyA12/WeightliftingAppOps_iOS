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

- (void)update:(BTAPIUser *)user completion:(void(^)(bool success))completion {
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
    [self performRequest:[BTAPIRequest method:POST path:@"users/query.php" body:@{@"query":@{}}]
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
