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

NS_ASSUME_NONNULL_BEGIN

@interface BTAPIUsersManager : BTAPIBase

+ (BTAPIUsersManager *)sharedInstance;

- (void)update:(BTAPIUser *)user completion:(void(^)(bool))completion;

- (void)all:(void(^)(NSArray<BTAPIUser *> *users))completion;

@end

NS_ASSUME_NONNULL_END
