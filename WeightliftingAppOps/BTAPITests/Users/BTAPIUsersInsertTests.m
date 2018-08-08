//
//  BTAPIUsersInsertTests.m
//  BTAPITests
//
//  Created by Chappy Asel on 8/5/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BTAPI.h"

@interface BTAPIUsersInsertTests : XCTestCase
@property (nonatomic) NSString *username;
@end

@implementation BTAPIUsersInsertTests

- (void)setUp {

}

- (void)tearDown {
    
}

// (1) Get username
// (2) Insert user
// (3) User exists
// (4) Get user
- (void)testInsert {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Insert"];
    expectation.expectedFulfillmentCount = 4;
    [BTAPI.users getUsername:^(NSString *username) {
        XCTAssertNotNil(username);
        self.username = username;
        [expectation fulfill];
        [BTAPI.users insert:self.username completion:^(bool success) {
            XCTAssertTrue(success);
            [expectation fulfill];
            [BTAPI.users exists:self.username completion:^(bool success, bool exists) {
                XCTAssertTrue(success);
                XCTAssertTrue(exists);
                [expectation fulfill];
            }];
            [BTAPI.users get:self.username completion:^(BTAPIUser *user) {
                XCTAssertNotNil(user);
                XCTAssertEqualWithAccuracy([NSDate.date timeIntervalSinceReferenceDate],
                                           [user.dateCreated timeIntervalSinceReferenceDate], 1);
                XCTAssertEqualWithAccuracy([NSDate.date timeIntervalSinceReferenceDate],
                                           [user.lastActivity timeIntervalSinceReferenceDate], 1);
                [expectation fulfill];
            }];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        [BTAPI.users delete:self.username completion:^(bool deleted) {
            XCTAssertTrue(deleted);
        }];
    }];
}

// (1) Query all
// (2) Insert user
- (void)testBadInsert {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Bad Insert"];
    expectation.expectedFulfillmentCount = 2;
    [BTAPI.users all:^(NSArray<BTAPIUser *> *users) {
        XCTAssertNotNil(users);
        XCTAssertTrue(users.count > 0);
        [expectation fulfill];
        [BTAPI.users insert:users[0].username completion:^(bool success) {
            XCTAssertFalse(success);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
