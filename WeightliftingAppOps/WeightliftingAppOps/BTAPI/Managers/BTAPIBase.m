//
//  BTAPIBase.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 7/13/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "BTAPIBase.h"

@implementation BTAPIBase

- (void)getRequestWithPath:(NSString *)path completion:(void (^)(NSDictionary *response, NSError *error))completion {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self urlWithPath:path]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10];
    request.HTTPMethod = @"GET";
    [self addAuthToRequest:request];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        NSError *jsonError;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (jsonError) {
            //NSString *stringResponse = [[NSString alloc] initWithData: data encoding: NSISOLatin1StringEncoding]);
            completion(nil, error);
            return;
        }
        completion(jsonResponse, nil);
    }];
    [task resume];
}

#pragma mark - private helper methods

- (NSURL *)urlWithPath:(NSString *)path {
    return [NSURL URLWithString:[BASE_URL stringByAppendingString:path]];
}

- (void)addAuthToRequest:(NSMutableURLRequest *)request {
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", BASE_USERNAME, BASE_PASSWORD];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
    [request addValue:authValue forHTTPHeaderField:@"Authorization"];
}

@end
