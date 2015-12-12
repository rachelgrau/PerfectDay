//
//  PlanTableViewCell.m
//  PerfectDay
//
//  Created by Rachel on 12/6/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import "PlanTableViewCell.h"

@interface PlanTableViewCell()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *tagsLabel;
@property (strong, nonatomic) IBOutlet UILabel *likesLabel;
@end

@implementation PlanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUpCellWithPlan:(DayPlan *)plan {
    self.nameLabel.text = plan.userFullname;
    self.likesLabel.text = [plan.numLikes stringValue];
    NSMutableString *tags = [NSMutableString stringWithFormat:@"tags: %@ ", [plan.tags objectAtIndex:0]];
    for (int i=1; i<plan.tags.count; i++) {
        NSString *stringToAppend = [NSString stringWithFormat:@", %@", [plan.tags objectAtIndex:i]];
        [tags appendString:stringToAppend];
    }
    self.tagsLabel.text = tags;
    
    /* Circular image */
    self.imageView.image = plan.profPic;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.imageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
