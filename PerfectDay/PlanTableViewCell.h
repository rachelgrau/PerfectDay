//
//  PlanTableViewCell.h
//  PerfectDay
//
//  Created by Rachel on 12/6/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayPlan.h"

@interface PlanTableViewCell : UITableViewCell
- (void)setUpCellWithPlan:(DayPlan *)plan;
@end
