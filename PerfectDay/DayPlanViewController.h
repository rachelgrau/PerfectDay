//
//  DayPlanViewController.h
//  PerfectDay
//
//  Created by Rachel on 12/15/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface DayPlanViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property PFObject *dayPlan;
@end