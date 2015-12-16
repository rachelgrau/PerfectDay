//
//  DBKeys.m
//  PerfectDay
//
//  Created by Rachel on 12/6/15.
//  Copyright (c) 2015 Rachel. All rights reserved.
//

#import <Foundation/Foundation.h>

/* User table */
#define USER_EMAIL @"email"
#define USER_FULL_NAME @"fullName" // string
#define USER_PROF_PIC @"profilePicture" // PFFile
#define USER_HOMETOWN_CITY @"hometownCity" // string
#define USER_LIKES @"myLikes" // array

/* Perfect day plan table */
#define PLAN_CLASS_NAME @"DayPlan"
#define PLAN_CREATOR @"creator" // PFUser
#define PLAN_CITY @"cityName" // string

/* Activity table */
#define ACTIVITY_CLASS_NAME @"Activity"
#define ACTIVITY_NAME @"name" // string
#define ACTIVITY_DESCRIPTION @"description" // string
#define ACTIVITY_START_TIME @"startTime" // date
#define ACTIVITY_END_TIME @"endTime" // date
#define ACTIVITY_PLAN @"belongsToPlan" // DayPlan
#define ACTIVITY_CATEGORY @"category" //string

/* Like table */
#define LIKE_CLASS_NAME @"Like"
#define LIKE_LIKER @"liker"
#define LIKE_PLAN @"likedPlan"