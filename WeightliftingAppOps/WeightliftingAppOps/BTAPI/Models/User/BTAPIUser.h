//
//  BTAPIUser.h
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 7/13/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BTAPIUser : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *deviceID;
@property (nonatomic) NSString *facebookID;

@property (nonatomic) NSDate *dateCreated;
@property (nonatomic) NSDate *dateUpdated;
@property (nonatomic) bool loggedIn;

+ (BTAPIUser *)userForDictionary:(NSDictionary *)dict;

- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
