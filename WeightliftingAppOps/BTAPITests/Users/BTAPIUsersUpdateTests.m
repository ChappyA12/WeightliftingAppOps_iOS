//
//  BTAPIUsersUpdateTests.m
//  BTAPITests
//
//  Created by Chappy Asel on 8/5/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BTAPI.h"

@interface BTAPIUsersUpdateTests : XCTestCase
@property (nonatomic) BTAPIUser *user;
@end

@implementation BTAPIUsersUpdateTests

- (void)setUp {
    
}

- (void)tearDown {
    
}

- (void)testUpdate {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Update"];
    self.user = [[BTAPIUser alloc] init];
    self.user.username = @"Bob";
    self.user.xp = 21;
    [BTAPI.users update:self.user completion:^(bool success) {
        XCTAssertTrue(success);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
