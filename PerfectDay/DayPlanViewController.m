//
//  DayPlanViewController.m
//  PerfectDay
//
//  Created by Rachel on 12/15/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import "DayPlanViewController.h"
#import "DBKeys.h"
#import "Common.h"

@interface DayPlanViewController ()
@property (strong, nonatomic) IBOutlet UILabel *cityNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *creatorLabel;
@property (strong, nonatomic) IBOutlet UILabel *numLikesLabel;
@property (strong, nonatomic) IBOutlet UILabel *likedLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property BOOL hasLoadedActivities;
@property NSArray *activities;

/* LIKES */
/* YES if current user has liked this plan, NO otherwise */
@property BOOL currentUserLiked;
@property (strong, nonatomic) IBOutlet UIButton *likeButton;
/* If the current user liked this day plan, this object stores that like */
@property PFObject *like;
@property NSUInteger numLikes;
@end

@implementation DayPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cityNameLabel.text = [self.dayPlan objectForKey:PLAN_CITY];
    PFUser *creator = [self.dayPlan objectForKey:PLAN_CREATOR];
    self.creatorLabel.text = [creator objectForKey:USER_FULL_NAME];
    self.likeButton.enabled = NO;
    
    /* Load activities */
    PFQuery *activityQuery = [PFQuery queryWithClassName:ACTIVITY_CLASS_NAME];
    [activityQuery whereKey:ACTIVITY_PLAN equalTo:self.dayPlan];
    [activityQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.activities = objects;
        } else {
            self.activities = [[NSArray alloc] init];
        }
        self.hasLoadedActivities = YES;
        [self.tableView reloadData];
    }];
    
    /* Load likes */
    PFQuery *likeQuery = [PFQuery queryWithClassName:LIKE_CLASS_NAME];
    [likeQuery whereKey:LIKE_PLAN equalTo:self.dayPlan];
    [likeQuery findObjectsInBackgroundWithBlock:^(NSArray *likes, NSError *error) {
        if (!error) {
            self.numLikes = likes.count;
            self.numLikesLabel.text = [NSString stringWithFormat:@"%lu", likes.count];
        }
    }];
    
    /* See if current user has liked this page */
    PFQuery *currentUserLikedQuery = [PFQuery queryWithClassName:LIKE_CLASS_NAME];
    [currentUserLikedQuery whereKey:LIKE_PLAN equalTo:self.dayPlan];
    [currentUserLikedQuery whereKey:LIKE_LIKER equalTo:[PFUser currentUser]];
    [currentUserLikedQuery getFirstObjectInBackgroundWithBlock:^(PFObject *obj, NSError *err) {
        if (obj && !err) {
            self.currentUserLiked = YES;
            self.like = obj;
            self.likedLabel.text = @"Liked";
            [self.likeButton setTitle:@"Unlike this plan" forState:UIControlStateNormal];
        } else {
            self.currentUserLiked = NO;
            self.likedLabel.text = @"Unliked";
            [self.likeButton setTitle:@"Like this plan" forState:UIControlStateNormal];
        }
        self.likeButton.enabled = YES;
    }];
}

/* Disable the like button. */
- (IBAction)pressedLike:(id)sender {
    self.likeButton.enabled = NO;
    if (self.currentUserLiked) {
        // delete like
        self.currentUserLiked = NO;
        self.likedLabel.text = @"Unliked";
        [self.likeButton setTitle:@"Like this plan" forState:UIControlStateNormal];
        self.numLikes--;
        [self.like deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            self.likeButton.enabled = YES;
        }];
    } else {
        // create like
        self.currentUserLiked = YES;
        self.likedLabel.text = @"Liked";
        [self.likeButton setTitle:@"Unlike this plan" forState:UIControlStateNormal];
        self.numLikes++;
        PFObject *like = [PFObject objectWithClassName:LIKE_CLASS_NAME];
        [like setObject:[PFUser currentUser] forKey:LIKE_LIKER];
        [like setObject:self.dayPlan forKey:LIKE_PLAN];
        [like saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            self.like = like;
            self.likeButton.enabled = YES;
        }];
    }
    self.numLikesLabel.text = [NSString stringWithFormat:@"%lu", self.numLikes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableView delegate and data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.hasLoadedActivities) {
        return 0;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.hasLoadedActivities) {
        return 0;
    } else {
        return self.activities.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activityCell" forIndexPath:indexPath];
    PFObject *activity = [self.activities objectAtIndex:indexPath.row];
    cell.textLabel.text = [activity objectForKey:ACTIVITY_NAME];
    NSString *startTime = [Common hourMinuteStringFromDate:[activity objectForKey:ACTIVITY_START_TIME]];
    NSString *endTime = [Common hourMinuteStringFromDate:[activity objectForKey:ACTIVITY_END_TIME]];
    NSString *time = [NSString stringWithFormat:@"%@ - %@", startTime, endTime];
    cell.detailTextLabel.text = time;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {

    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
