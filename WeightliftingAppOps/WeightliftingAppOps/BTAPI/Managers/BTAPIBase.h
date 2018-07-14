//
//  BTAPIBase.h
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 7/13/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BenchTrackerKeys.h"

NS_ASSUME_NONNULL_BEGIN

@interface BTAPIBase : NSObject

- (void)getRequestWithPath:(NSString *)path
                completion:(void (^)(NSDictionary *response, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
