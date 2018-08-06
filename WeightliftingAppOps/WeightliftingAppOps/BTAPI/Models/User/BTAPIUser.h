//
//  BTAPIUser.h
//  WeightliftingAppOps
//
//  Created by Chappy Asel on 8/3/18.
//  Copyright © 2018 CA. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BTAPIUser : JSONModel

@property (nonatomic) NSString *        username;
@property (nonatomic) NSString *        imageUrl;           //optional
@property (nonatomic) NSString *        deviceUuid;         //optional

@property (nonatomic) NSDate *          dateCreated;        //optional
@property (nonatomic) NSDate *          lastActivity;       //optional
@property (nonatomic) bool              loggedIn;           //optional

@property (nonatomic) float             weight;             //optional
@property (nonatomic) bool              weightInLbs;        //optional

@property (nonatomic) NSInteger         xp;                 //optional

@property (nonatomic) NSInteger         totalDuration;      //optional
@property (nonatomic) NSInteger         totalVolume;        //optional
@property (nonatomic) NSInteger         totalWorkouts;      //optional
@property (nonatomic) NSInteger         totalSets;          //optional
@property (nonatomic) NSInteger         totalExercises;     //optional
@property (nonatomic) NSInteger         powerliftingTotal;  //optional

@property (nonatomic) NSInteger         currentStreak;      //optional
@property (nonatomic) NSInteger         longestStreak;      //optional

@property (nonatomic) NSDictionary *    metadata;           //optional

+ (BTAPIUser *)username:(NSString *)username;

@end
