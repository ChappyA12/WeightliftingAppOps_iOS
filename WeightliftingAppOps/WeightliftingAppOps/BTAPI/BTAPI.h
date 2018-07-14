//
//  BTAPI.h
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 7/13/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTAPIUsersManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface BTAPI : NSObject

+ (BTAPI *)sharedInstance;

@property BTAPIUsersManager *users;

@end

NS_ASSUME_NONNULL_END
