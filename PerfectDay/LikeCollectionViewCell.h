//
//  LikeCollectionViewCell.h
//  PerfectDay
//
//  Created by Rachel on 12/14/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LikeCollectionViewCell : UICollectionViewCell
- (void) setUpCellWithTitle:(NSString *)title setFilled:(BOOL)filled isGray:(BOOL)gray;
- (void) switchFilled;
@end
