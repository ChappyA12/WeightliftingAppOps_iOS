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

// (1) get username
// (2) query exists
- (void)testQueryExists {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Query Exists"];
    expectation.expectedFulfillmentCount = 2;
    [BTAPI.users getUsername:^(NSString *username) {
        XCTAssertNotNil(username);
        [expectation fulfill];
        [BTAPI.users exists:username completion:^(bool success, bool exists) {
            XCTAssertTrue(success);
            XCTAssertFalse(exists);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

// (1) query all
// (2) query exists
- (void)testBadQueryExists {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Bad Query Exists"];
    expectation.expectedFulfillmentCount = 2;
    [BTAPI.users all:^(NSArray<BTAPIUser *> *users) {
        XCTAssertNotNil(users);
        XCTAssert(users.count > 0);
        [expectation fulfill];
        [BTAPI.users exists:users[0].username completion:^(bool success, bool exists) {
            XCTAssertTrue(success);
            XCTAssertTrue(exists);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

// (1) get all
// (2) get user
- (void)testQueryGet {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Query Get"];
    expectation.expectedFulfillmentCount = 2;
    [BTAPI.users all:^(NSArray<BTAPIUser *> *users) {
        XCTAssertNotNil(users);
        XCTAssertTrue(users.count > 0);
        [expectation fulfill];
        [BTAPI.users get:users[0].username completion:^(BTAPIUser *user) {
            XCTAssertNotNil(user);
            XCTAssertEqualObjects(user.username, users[0].username);
            XCTAssertNil(user.deviceUuid);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

// (1) get username
// (2) get user
- (void)testBadQueryGet {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Bad Query Get"];
    expectation.expectedFulfillmentCount = 2;
    [BTAPI.users getUsername:^(NSString *username) {
        XCTAssertNotNil(username);
        [expectation fulfill];
        [BTAPI.users get:username completion:^(BTAPIUser *user) {
            XCTAssertNil(user);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

// (1) get all
- (void)testQueryAll {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Query All"];
    [BTAPI.users all:^(NSArray<BTAPIUser *> *users) {
        XCTAssertNotNil(users);
        XCTAssert(users.count > 0);
        XCTAssert(users.count < 101);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

// (1) get leaderboard
- (void)testQueryXPLeaderboard {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Query XP Leaderboard"];
    [BTAPI.users leaderboard:BTAPIUserLeaderboardTypeXP completion:^(NSArray<BTAPIUser *> *users) {
        XCTAssertNotNil(users);
        XCTAssert(users.count > 0);
        XCTAssert(users.count < 101);
        XCTAssert(users[0].xp > 0);
        XCTAssert(users[0].xp >= users[1].xp);
        XCTAssert(users[1].xp >= users[2].xp);
        XCTAssert(users[0].deviceUuid == nil);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
