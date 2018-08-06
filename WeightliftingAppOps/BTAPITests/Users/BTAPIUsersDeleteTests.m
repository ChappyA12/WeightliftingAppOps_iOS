//
//  BTAPIUsersManagerTests.m
//  BTAPITests
//
//  Created by Chappy Asel on 8/5/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BTAPI.h"

@interface BTAPIUsersDeleteTests : XCTestCase
@property (nonatomic) BTAPIUser *user;
@end

@implementation BTAPIUsersDeleteTests

- (void)setUp {
    
}

- (void)tearDown {
    
}

// (1) get username
// (2) insert user
// (3) delete user
- (void)testDelete {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Delete"];
    expectation.expectedFulfillmentCount = 3;
    [BTAPI.users getUsername:^(NSString *username) {
        XCTAssertNotNil(username);
        [expectation fulfill];
        [BTAPI.users insert:username completion:^(bool success) {
            XCTAssertTrue(success);
            [expectation fulfill];
            [BTAPI.users delete:username completion:^(bool deleted) {
                XCTAssertTrue(deleted);
                [expectation fulfill];
            }];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

// (1) get username
// (2) delete user
- (void)testBadDelete {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Bad Delete"];
    expectation.expectedFulfillmentCount = 2;
    [BTAPI.users getUsername:^(NSString *username) {
        XCTAssertNotNil(username);
        [expectation fulfill];
        [BTAPI.users delete:username completion:^(bool deleted) {
            XCTAssertFalse(deleted);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
