//
//  DayPlan.h
//  PerfectDay
//
//  Created by Rachel on 12/6/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DayPlan : NSObject
@property NSString *title;
@property NSNumber *numLikes;
@property NSArray *tags;
@property UIImage *profPic;
@property NSString *userFullname;

- (id) initWithTitle:(NSString *)title numberOfLikes:(NSNumber *)numLikes tags:(NSArray *)tags profilePic:(UIImage *)profPic userFullname:(NSString *)userFullname;
@end
