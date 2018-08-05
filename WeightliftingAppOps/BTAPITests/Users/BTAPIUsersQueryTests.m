//
//  BTAPIUsersQueryTests.m
//  BTAPITests
//
//  Created by Chappy Asel on 8/5/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BTAPI.h"

@interface BTAPIUsersQueryTests : XCTestCase
@end

@implementation BTAPIUsersQueryTests

- (void)setUp {
    
}

- (void)tearDown {
    
}

- (void)testQueryExists {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Query Exists"];
    expectation.expectedFulfillmentCount = 2;
    [BTAPI.users exists:@"Bob" completion:^(bool success, bool exists) {
        XCTAssertTrue(success);
        XCTAssertTrue(exists);
        [expectation fulfill];
    }];
    [BTAPI.users exists:@"#BAD" completion:^(bool success, bool exists) {
        XCTAssertTrue(success);
        XCTAssertFalse(exists);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testQueryGet {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Query Get"];
    [BTAPI.users get:@"Bob" completion:^(BTAPIUser *user) {
        XCTAssertNotNil(user);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

- (void)testQueryAll {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Query All"];
    [BTAPI.users all:^(NSArray<BTAPIUser *> *users) {
        XCTAssertNotNil(users);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
