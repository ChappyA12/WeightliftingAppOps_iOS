//
//  MainViewController.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 7/13/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "MainViewController.h"
#import "UserTableViewCell.h"
#import "BTAPI.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray<BTAPIUser *> *users;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.users = @[];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [BTAPI.users all:^(NSArray<BTAPIUser *> *users) {
        self.users = users;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - tableView dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = (UserTableViewCell *)[[NSBundle mainBundle] loadNibNamed:@"UserTableViewCell" owner:self options:nil].firstObject;
    }
    cell.user = self.users[indexPath.row];
    return cell;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
