//
//  Common.m
//  PerfectDay
//
//  Created by Rachel on 12/6/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (void)setBackgroundGradientColorForView:(UIView *)view {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    UIColor *firstColor = [UIColor colorWithRed:36.f/255.f green:102.f/255.f blue:110.f/255.f alpha:1.0];
    UIColor *secondColor = [UIColor colorWithRed:24.f/255.f green:49.f/255.f blue:50.f/255.f alpha:1.0];
    gradient.colors = [NSArray arrayWithObjects:(id)[firstColor CGColor], (id)[secondColor CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:0];
}

+ (void)setBorder:(UIView *)view withColor:(UIColor *)color {
    view.layer.masksToBounds = YES;
    view.layer.borderColor = [color CGColor];
    view.layer.borderWidth = 1.0f;
}

+ (int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}

+ (UIColor *)getNavy {
    return [UIColor colorWithRed:24.f/255.f green:49.f/255.f blue:50.f/255.f alpha:1.0];
}

+ (UIColor *)getGray {
    return [UIColor colorWithRed:189.f/255.f green:199.f/255.f blue:204.f/255.f alpha:1.0];
}

+ (NSArray *)getAllLikeOptions {
    NSArray *arr = [[NSArray alloc] initWithObjects:@"coffee", @"books", @"theater", @"soccer", @"basketball", @"football", @"baseball", @"squash", @"volleyball", @"swimming", @"beaches", @"fine dining", @"local eateries", @"hiking", @"running", @"biking", @"history", @"art", @"museums", @"music", @"live music", @"shopping", @"spa", @"bars", @"clubs", @"dancing", @"street art", @"modern art", nil];
    NSArray *sortedArray = [arr sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    return sortedArray;
}

+ (NSString *)hourMinuteStringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    return stringFromDate;
}

@end
