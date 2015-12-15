//
//  LikeCollectionViewCell.m
//  PerfectDay
//
//  Created by Rachel on 12/14/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import "LikeCollectionViewCell.h"

@interface LikeCollectionViewCell ()
@property (strong, nonatomic) IBOutlet UILabel *likeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property BOOL filled;
@end

@implementation LikeCollectionViewCell

- (void) setUpCellWithTitle:(NSString *)title setFilled:(BOOL)filled isGray:(BOOL)gray {
    self.filled = filled;
    self.likeLabel.text = title;
    if (gray) {
        [self.imageView setImage:[UIImage imageNamed:@"grayCircle.png"]];
    } else if (filled) {
        [self.imageView setImage:[UIImage imageNamed:@"filledCircle.png"]];
    } else {
        [self.imageView setImage:[UIImage imageNamed:@"outlineCircle.png"]];
    }
}

- (void) switchFilled {
    if (self.filled) {
        [self.imageView setImage:[UIImage imageNamed:@"outlineCircle.png"]];
        self.filled = NO;
    } else {
        [self.imageView setImage:[UIImage imageNamed:@"filledCircle.png"]];
        self.filled = YES;
    }
}

@end
