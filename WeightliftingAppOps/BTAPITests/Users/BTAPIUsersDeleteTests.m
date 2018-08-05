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

- (void)testDelete {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Delete"];
    expectation.expectedFulfillmentCount = 2;
    [BTAPI.users delete:@"Harrison" completion:^(bool deleted) {
        XCTAssertTrue(deleted);
        [expectation fulfill];
    }];
    [BTAPI.users delete:@"#BAD" completion:^(bool deleted) {
        XCTAssertFalse(deleted);
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

@end
