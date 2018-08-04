//
//  BTAPIBase.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 7/13/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "BTAPIBase.h"

@implementation BTAPIBase

- (void)performRequest:(BTAPIRequest *)request completion:(void (^)(NSDictionary *response, NSError *error))completion {
    NSMutableURLRequest *requestObj = [NSMutableURLRequest requestWithURL:[self urlWithPath:request.path]
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                          timeoutInterval:10];
    requestObj.HTTPMethod = request.method;
    if (request.body) requestObj.HTTPBody = [NSKeyedArchiver archivedDataWithRootObject:request.body];
    [self addAuthToRequest:requestObj];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task =
        [session dataTaskWithRequest:requestObj
                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                       NSInteger statusCode = 200;
                       if ([response respondsToSelector:@selector(statusCode)])
                           statusCode = [(NSHTTPURLResponse *)response statusCode];
                       if (error || statusCode < 200 || statusCode > 299) {
                           completion(nil, error);
                           return;
                       }
                       NSError *jsonError;
                       NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                       if (jsonError) {
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
