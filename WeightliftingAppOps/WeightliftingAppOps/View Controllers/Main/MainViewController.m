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
    [BTAPI.sharedInstance.users all:^(NSArray<BTAPIUser *> *users) {
        NSLog(@"%@", users);
    }];
}


@end
