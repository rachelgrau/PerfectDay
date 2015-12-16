//
//  DayPlan.h
//  PerfectDay
//
//  Created by Rachel on 12/6/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface DayPlan : NSObject
/* TEMP */
@property NSString *title;
@property NSNumber *numLikes;
@property NSArray *tags;
@property UIImage *profPic;
@property NSString *userFullname;

/* REAL */
@property PFUser *creator;
@property NSString *cityName;

//temp, get rid of
- (id) initWithTitle:(NSString *)title numberOfLikes:(NSNumber *)numLikes tags:(NSArray *)tags profilePic:(UIImage *)profPic userFullname:(NSString *)userFullname;

- (id) initWithCityName:(NSString *)cityName tags:(NSArray *)tags byCreator:(PFUser *)creator;

@end
