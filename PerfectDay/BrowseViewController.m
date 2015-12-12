//
//  BrowseViewController.m
//  PerfectDay
//
//  Created by Rachel on 12/6/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import "BrowseViewController.h"
#import "PlanTableViewCell.h"
#import "Common.h"
#import "DayPlan.h"

@interface BrowseViewController ()
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property NSArray *plansToShow;
@end

@implementation BrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES];
    [Common setBackgroundGradientColorForView:self.view];
    UIFont *font = [UIFont fontWithName:@"Avenir Next Ultra Light" size:12.0f];
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    [self.segmentedControl setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
    
    NSArray *tags = [NSArray arrayWithObjects:@"brunch", @"mission burritos", @"live music", nil];
    NSArray *zooeyTags = [NSArray arrayWithObjects:@"coffee", @"walking", @"theater", nil];
    
    DayPlan *tswiftPlan = [[DayPlan alloc] initWithTitle:@"SF Title" numberOfLikes:@12345 tags:tags profilePic:[UIImage imageNamed:@"tswift.jpg"] userFullname:@"Taylor Swift"];
    DayPlan *zooeyPlan = [[DayPlan alloc] initWithTitle:@"Hi" numberOfLikes:@9249 tags:zooeyTags profilePic:[UIImage imageNamed:@"zooey.jpg"] userFullname:@"Zooey Deschanel"];
    
    self.plansToShow = [NSArray arrayWithObjects:tswiftPlan, zooeyPlan, nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table View stuff

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.plansToShow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"planCell" forIndexPath:indexPath];
    DayPlan *planToShow = [self.plansToShow objectAtIndex:indexPath.row];
    [cell setUpCellWithPlan:planToShow];
    return cell;
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
