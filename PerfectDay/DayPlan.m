//
//  DayPlan.m
//  PerfectDay
//
//  Created by Rachel on 12/6/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import "DayPlan.h"

@interface DayPlan()
@end

@implementation DayPlan

- (id) initWithTitle:(NSString *)title numberOfLikes:(NSNumber *)numLikes tags:(NSArray *)tags            profilePic:(UIImage *)profPic userFullname:(NSString *)userFullname {
    self = [super init];
    if (self) {
        self.title = title;
        self.numLikes = numLikes;
        self.tags = tags;
        self.profPic = profPic;
        self.userFullname = userFullname;
    }
    return self;
}

@end
