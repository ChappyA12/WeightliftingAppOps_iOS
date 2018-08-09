//
//  UserTableViewCell.m
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 8/8/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import "UserTableViewCell.h"
#import "BTAPIUser.h"

@interface UserTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation UserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setUser:(BTAPIUser *)user {
    _user = user;
    self.titleLabel.text = user.username;
    self.detailLabel.text = user.lastActivity.description;
}

@end
