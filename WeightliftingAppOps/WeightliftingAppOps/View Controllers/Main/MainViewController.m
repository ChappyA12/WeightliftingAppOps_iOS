//
//  MainViewController.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 7/13/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "MainViewController.h"
#import "BTAPI.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BTAPIUser *user = [[BTAPIUser alloc] init];
    user.username = @"Bob";
    user.xp = 21;
    [BTAPI.users update:user completion:^(bool success) {
        NSLog(@"Update done");
    }];
    [BTAPI.users all:^(NSArray<BTAPIUser *> *users) {
        NSLog(@"%@", users);
    }];
    user = [[BTAPIUser alloc] init];
    user.username = @"joe";
    [BTAPI.users delete:user completion:^(bool success) {
        NSLog(@"Delete done");
    }];
}


@end
