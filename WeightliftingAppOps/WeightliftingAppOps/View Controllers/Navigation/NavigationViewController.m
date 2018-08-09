//
//  NavigationViewController.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 8/8/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "NavigationViewController.h"
#import "MainViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MainViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"m"];
    [self pushViewController:vc animated:YES];
}

@end
