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

@end
