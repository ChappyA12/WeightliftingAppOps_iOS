//
//  JSONValueTransformer+NSDate.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 8/3/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "JSONValueTransformer+NSDate.h"

@implementation JSONValueTransformer (NSDate)

- (NSDate *)NSDateFromNSString:(NSString *)string {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone localTimeZone];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter dateFromString:string];
}

- (NSString *)JSONObjectFromNSDate:(NSDate *)date {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return [formatter stringFromDate:date];
}

@end
