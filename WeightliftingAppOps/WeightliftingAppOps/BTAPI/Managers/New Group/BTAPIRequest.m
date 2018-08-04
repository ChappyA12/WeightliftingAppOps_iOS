//
//  BTAPIRequest.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 8/3/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "BTAPIRequest.h"

@implementation BTAPIRequest

+ (BTAPIRequest *)method:(NSString *)method path:(NSString *)path body:(NSDictionary * _Nullable)body {
    BTAPIRequest *request = [[BTAPIRequest alloc] init];
    request.method = method;
    request.path = path;
    request.body = body;
    return request;
}

@end
