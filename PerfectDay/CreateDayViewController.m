//
//  CreateDayViewController.m
//  PerfectDay
//
//  Created by Rachel on 12/15/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import "CreateDayViewController.h"
#import "DayPlan.h"
#import "DBKeys.h"

@interface CreateDayViewController ()
@property (strong, nonatomic) IBOutlet UITextField *cityNameTextField;

// Activity
@property (strong, nonatomic) IBOutlet UITextField *activityTextField;
@property (strong, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (strong, nonatomic) IBOutlet UITextField *startTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *endTimeTextField;
@property (strong, nonatomic) IBOutlet UITextField *categoryTextField;
@property BOOL hasCreatedActivity;
@property PFObject *plan;
@end

@implementation CreateDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hasCreatedActivity = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createButtonPressed:(id)sender {
    if (!self.hasCreatedActivity) {
        self.plan = [PFObject objectWithClassName:PLAN_CLASS_NAME];
        [self.plan setObject:self.cityNameTextField.text forKey:PLAN_CITY];
        [self.plan setObject:self.creator forKey:PLAN_CREATOR];
        [self.plan saveInBackground];
        self.hasCreatedActivity = YES;
    }
    PFObject *activity = [PFObject objectWithClassName:ACTIVITY_CLASS_NAME];
    [activity setObject:self.activityTextField.text forKey:ACTIVITY_NAME];
    [activity setObject:self.plan forKey:ACTIVITY_PLAN];
    [activity setObject:self.descriptionTextField.text forKey:ACTIVITY_DESCRIPTION];
    [activity setObject:self.categoryTextField.text forKey:ACTIVITY_CATEGORY];
    // start time
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    NSDate *startTime = [formatter dateFromString:self.startTimeTextField.text];
    // end time
    NSDate *endTime = [formatter dateFromString:self.endTimeTextField.text];
    
    [activity setObject:startTime forKey:ACTIVITY_START_TIME];
    [activity setObject:endTime forKey:ACTIVITY_END_TIME];
    
    [activity saveInBackground];
    
    self.activityTextField.text = @"";
    self.descriptionTextField.text = @"";
    self.startTimeTextField.text = @"";
    self.endTimeTextField.text = @"";
    self.categoryTextField.text = @"";
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
