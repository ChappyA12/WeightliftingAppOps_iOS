//
//  BTAPIUsersUsernameTests.m
//  BTAPITests
//
//  Created by Chappy Asel on 8/5/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BTAPI.h"

@interface BTAPIUsersUsernameTests : XCTestCase
@property (nonatomic) NSString *username;
@end

@implementation BTAPIUsersUsernameTests

- (void)setUp {

}

- (void)tearDown {
    
}

// (1) Get username
// (2) User exists
- (void)testGetUsername {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Get Username"];
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

// (1) Get username
// (2) Insert user
// (3) Get username
// (4) Change username
// (5) User exists (old)
// (6) User exists (new)
- (void)testChangeUsername {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Change Username"];
    expectation.expectedFulfillmentCount = 6;
    [BTAPI.users getUsername:^(NSString *username) {
        XCTAssertNotNil(username);
        self.username = username;
        [expectation fulfill];
        [BTAPI.users insert:self.username completion:^(bool success) {
            XCTAssertTrue(success);
            [expectation fulfill];
            [BTAPI.users getUsername:^(NSString *username2) {
                XCTAssertNotNil(username2);
                NSString *oldUsername = self.username;
                self.username = username2;
                [expectation fulfill];
                [BTAPI.users changeUsernameFrom:oldUsername to:self.username completion:^(bool success) {
                    XCTAssertTrue(success);
                    [expectation fulfill];
                    [BTAPI.users exists:self.username completion:^(bool success, bool exists) {
                        XCTAssertTrue(success);
                        XCTAssertTrue(exists);
                        [expectation fulfill];
                    }];
                    [BTAPI.users exists:oldUsername completion:^(bool success, bool exists) {
                        XCTAssertTrue(success);
                        XCTAssertFalse(exists);
                        [expectation fulfill];
                    }];
                }];
            }];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        [BTAPI.users delete:self.username completion:^(bool deleted) {
            XCTAssertTrue(deleted);
        }];
    }];
}

// (1) Get username
// (2) Get username
// (3) Change username
// (4) User exists
- (void)testBadChangeUsernameDNE {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Bad Change Username - User Doesn't Exist"];
    expectation.expectedFulfillmentCount = 4;
    [BTAPI.users getUsername:^(NSString *username) {
        XCTAssertNotNil(username);
        [expectation fulfill];
        [BTAPI.users getUsername:^(NSString *newUsername) {
            XCTAssertNotNil(newUsername);
            [expectation fulfill];
            [BTAPI.users changeUsernameFrom:username to:newUsername completion:^(bool success) {
                XCTAssertFalse(success);
                [expectation fulfill];
                [BTAPI.users exists:newUsername completion:^(bool success, bool exists) {
                    XCTAssertTrue(success);
                    XCTAssertFalse(exists);
                    [expectation fulfill];
                }];
            }];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

// (1) Get username
// (2) Insert user
// (3) Get all
// (4) Change username
// (5) User exists
- (void)testBadChangeUsernameExists {
    __block NSString *usernameDel;
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Bad Change Username - User Exists"];
    expectation.expectedFulfillmentCount = 5;
    [BTAPI.users getUsername:^(NSString *username) {
        XCTAssertNotNil(username);
        usernameDel = username;
        [expectation fulfill];
        [BTAPI.users insert:username completion:^(bool success) {
            XCTAssertTrue(success);
            [expectation fulfill];
            [BTAPI.users all:^(NSArray<BTAPIUser *> *users) {
                XCTAssertNotNil(users);
                XCTAssertTrue(users.count > 0);
                [expectation fulfill];
                [BTAPI.users changeUsernameFrom:username to:users[0].username completion:^(bool success) {
                    XCTAssertFalse(success);
                    [expectation fulfill];
                    [BTAPI.users exists:username completion:^(bool success, bool exists) {
                        XCTAssertTrue(success);
                        XCTAssertTrue(exists);
                        [expectation fulfill];
                    }];
                }];
            }];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError * _Nullable error) {
        [BTAPI.users delete:usernameDel completion:^(bool deleted) {
            XCTAssertTrue(deleted);
        }];
    }];
}

@end
