//
//  BTAPIRequest.h
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 8/3/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GET @"GET"
#define POST @"POST"
#define DELETE @"DELETE"

NS_ASSUME_NONNULL_BEGIN

@interface BTAPIRequest : NSObject

@property (nonatomic) NSString *method;
@property (nonatomic) NSString *path;
@property (nonatomic) NSDictionary *body;

+ (BTAPIRequest *)method:(NSString *)method path:(NSString *)path body:(NSDictionary * _Nullable)body;

@end

NS_ASSUME_NONNULL_END
