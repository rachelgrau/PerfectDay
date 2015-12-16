//
//  Common.h
//  PerfectDay
//
//  Created by Rachel on 12/6/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Common : NSObject
/* Sets the background color of |view| to the gradient dark blue color used throughout the app. */
+ (void)setBackgroundGradientColorForView:(UIView *)view;
/* Sets the border of the given view to the given color. */
+ (void)setBorder:(UIView *)view withColor:(UIColor *)color;
/* Returns a random int between |from| and |to| */
+ (int)getRandomNumberBetween:(int)from to:(int)to;
/* Returns the navy-ish color used throughout the app */
+ (UIColor *)getNavy;
/* Returns the gray-ish color used throughout the app */
+ (UIColor *)getGray;
/* Returns a list of all options for likes */
+ (NSArray *)getAllLikeOptions;
/* Given a date, returns a string of the form "2:30 PM" (h:mm a)*/
+ (NSString *)hourMinuteStringFromDate:(NSDate *)date;
@end
