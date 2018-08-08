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

// (1) get valid username
// (2) insert user
// (3) update user
// (4) get user
- (void)testUpdate {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Update"];
    expectation.expectedFulfillmentCount = 4;
    [BTAPI.users getUsername:^(NSString *username) {
        XCTAssertNotNil(username);
        [expectation fulfill];
        [BTAPI.users insert:username completion:^(bool success) {
            XCTAssertTrue(success);
            [expectation fulfill];
            self.user = [BTAPIUser username:username];
            self.user.imageUrl = @"abc/a_b-c.com";
            self.user.deviceUuid = UIDevice.currentDevice.identifierForVendor.UUIDString;
            self.user.activeNow = true;
            self.user.weightInLbs = false;
            self.user.weight = 115.23;
            self.user.xp = 120;
            self.user.totalVolume = 2048;
            self.user.powerliftingTotal = 1024;
            [BTAPI.users update:self.user completion:^(bool success) {
                XCTAssertTrue(success);
                [expectation fulfill];
                [BTAPI.users get:self.user.username completion:^(BTAPIUser *user) {
                    XCTAssertNotNil(user);
                    XCTAssertEqualObjects(self.user, user);
                    XCTAssertEqualObjects(self.user.imageUrl, user.imageUrl);
                    XCTAssertEqual(self.user.activeNow, user.activeNow);
                    XCTAssertEqual(self.user.weightInLbs, user.weightInLbs);
                    XCTAssertEqual(self.user.weight, user.weight);
                    XCTAssertEqual(self.user.xp, user.xp);
                    XCTAssertEqual(self.user.totalVolume, user.totalVolume);
                    XCTAssertEqual(self.user.powerliftingTotal, user.powerliftingTotal);
                    [expectation fulfill];
                }];
            }];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        [BTAPI.users delete:self.user.username completion:^(bool deleted) {
            XCTAssertTrue(deleted);
        }];
    }];
}

// (1) get username
// (2) update user
- (void)testBadUpdateDNE {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Bad Update - User DNE"];
    expectation.expectedFulfillmentCount = 2;
    [BTAPI.users getUsername:^(NSString *username) {
        XCTAssertNotNil(username);
        [expectation fulfill];
        self.user = [BTAPIUser username:username];
        self.user.xp = 120;
        [BTAPI.users update:self.user completion:^(bool success) {
            XCTAssertFalse(success);
            [expectation fulfill];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:nil];
}

// (1) get username
// (2) insert user
// (3) log in
// (4) get user
- (void)testLogActivity {
    __block NSString *usernameDel;
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Log Activity"];
    expectation.expectedFulfillmentCount = 4;
    [BTAPI.users getUsername:^(NSString *username) {
        XCTAssertNotNil(username);
        [expectation fulfill];
        [BTAPI.users insert:username completion:^(bool success) {
            XCTAssertTrue(success);
            usernameDel = username;
            [expectation fulfill];
            [BTAPI.users logActivity:username completion:^(bool logged) {
                XCTAssertTrue(logged);
                [expectation fulfill];
                [BTAPI.users get:username completion:^(BTAPIUser *user) {
                    XCTAssertNotNil(user);
                    XCTAssertTrue(user.activeNow);
                    XCTAssertEqualWithAccuracy([NSDate.date timeIntervalSinceReferenceDate],
                                               [user.lastActivity timeIntervalSinceReferenceDate], 1);
                    [expectation fulfill];
                }];
            }];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        [BTAPI.users delete:usernameDel completion:^(bool deleted) {
            XCTAssertTrue(deleted);
        }];
    }];
}

// (1) get username
// (2) log in
// (3) get user
- (void)testBadLogIn {
    
}

// (1) get username
// (2) insert user
// (3) update user
// (4) get user
// (5) log out
// (6) get user
- (void)testLogOut {
    __block NSString *usernameDel;
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Log Out"];
    expectation.expectedFulfillmentCount = 6;
    [BTAPI.users getUsername:^(NSString *username) {
        XCTAssertNotNil(username);
        [expectation fulfill];
        [BTAPI.users insert:username completion:^(bool success) {
            XCTAssertTrue(success);
            usernameDel = username;
            [expectation fulfill];
            BTAPIUser *user = [BTAPIUser username:username];
            user.activeNow = true;
            [BTAPI.users update:user completion:^(bool updated) {
                XCTAssertTrue(updated);
                [expectation fulfill];
                [BTAPI.users get:username completion:^(BTAPIUser *user) {
                    XCTAssertNotNil(user);
                    XCTAssertTrue(user.activeNow);
                    [expectation fulfill];
                    [BTAPI.users logOut:username completion:^(bool logged) {
                        XCTAssertTrue(logged);
                        [expectation fulfill];
                        [BTAPI.users get:username completion:^(BTAPIUser *user) {
                            XCTAssertNotNil(user);
                            XCTAssertFalse(user.activeNow);
                            XCTAssertEqualWithAccuracy([NSDate.date timeIntervalSinceReferenceDate],
                                                       [user.lastActivity timeIntervalSinceReferenceDate], 1);
                            [expectation fulfill];
                        }];
                    }];
                }];
            }];
        }];
    }];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
//        [BTAPI.users delete:usernameDel completion:^(bool deleted) {
//            XCTAssertTrue(deleted);
//        }];
    }];
}

// (1) get username
// (2) log out
// (3) get user
- (void)testBadLogOut {
    
}

@end
