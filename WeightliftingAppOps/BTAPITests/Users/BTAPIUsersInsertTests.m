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

// (1) Can get username
// (2) User doesn't already exist
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
// (3) User now exists
// (4) Inserting again doesn't work
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
            [BTAPI.users insert:self.username completion:^(bool success) {
                XCTAssertFalse(success);
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

@end
