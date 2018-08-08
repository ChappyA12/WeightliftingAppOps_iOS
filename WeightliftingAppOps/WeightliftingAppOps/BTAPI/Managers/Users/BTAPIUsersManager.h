//
//  BTAPIUsersManager.h
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 7/13/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTAPIBase.h"
#import "BTAPIUser.h"

typedef enum {
    BTAPIUserLeaderboardTypeXP
} BTAPIUserLeaderboardType;

//TODO: log in / out helper, ops vs. user permissions

@interface BTAPIUsersManager : BTAPIBase

+ (BTAPIUsersManager *)sharedInstance;

- (void)getUsername:(void(^)(NSString *username))completion;

- (void)insert:(NSString *)username completion:(void(^)(bool inserted))completion;

- (void)changeUsernameFrom:(NSString *)from to:(NSString *)to completion:(void(^)(bool changed))completion;

- (void)update:(BTAPIUser *)user completion:(void(^)(bool updated))completion;

- (void)logActivity:(NSString *)username completion:(void(^)(bool logged))completion;

- (void)logOut:(NSString *)username completion:(void(^)(bool loggedOut))completion;

- (void)delete:(NSString *)username completion:(void(^)(bool deleted))completion;

- (void)exists:(NSString *)username completion:(void(^)(bool success, bool exists))completion;

- (void)get:(NSString *)username completion:(void(^)(BTAPIUser *user))completion;

- (void)all:(void(^)(NSArray<BTAPIUser *> *users))completion;

- (void)leaderboard:(BTAPIUserLeaderboardType)type completion:(void(^)(NSArray<BTAPIUser *> *users))completion;

@end
