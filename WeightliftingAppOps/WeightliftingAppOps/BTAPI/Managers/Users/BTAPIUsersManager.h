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

@interface BTAPIUsersManager : BTAPIBase

+ (BTAPIUsersManager *)sharedInstance;

- (void)getUsername:(void(^)(NSString *username))completion;

- (void)insert:(NSString *)username completion:(void(^)(bool success))completion;

- (void)update:(BTAPIUser *)user completion:(void(^)(bool success))completion;

- (void)delete:(NSString *)username completion:(void(^)(bool deleted))completion;

- (void)exists:(NSString *)username completion:(void(^)(bool success, bool exists))completion;

- (void)get:(NSString *)username completion:(void(^)(BTAPIUser *user))completion;

- (void)all:(void(^)(NSArray<BTAPIUser *> *users))completion;

@end
