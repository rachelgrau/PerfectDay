//
//  LogInViewController.m
//  PerfectDay
//
//  Created by Rachel on 12/6/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import "LogInViewController.h"
#import "Common.h"
#import <Parse/Parse.h>

@interface LogInViewController ()
@property (strong, nonatomic) IBOutlet UILabel *bonVoyageLabel;
@property NSArray *bonVoyageStrings;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation LogInViewController

- (void) changeLabel:(NSTimer *)timer
{
    [UIView animateWithDuration:1 animations:^{
        self.bonVoyageLabel.alpha = 0;
    } completion:^(BOOL finished) {
        int random = [Common getRandomNumberBetween:0 to:(int)(self.bonVoyageStrings.count - 1)];
        self.bonVoyageLabel.text = [self.bonVoyageStrings objectAtIndex:random];
        [UIView animateWithDuration:1 animations:^{
            self.bonVoyageLabel.alpha = 1.0;
        }];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* Set up array of "bon voyage" in different languages */
    self.bonVoyageStrings = [NSArray arrayWithObjects:@"bon voyage", @"buen viaje", @"happy travels", @"gute reise", @"buon viaggio", @"一路順風", @"शुभ यात्रा", @"Среќен пат", @"Счастливого пути", @"Hyvää matkaa", @"Szczęśliwej drogi", nil];
    int random = [Common getRandomNumberBetween:0 to:(int)(self.bonVoyageStrings.count - 1)];

    /*  */
    self.bonVoyageLabel.text = [self.bonVoyageStrings objectAtIndex:random];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0f
                                     target:self selector:@selector(changeLabel:) userInfo:nil repeats:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    if ([PFUser currentUser]) {
        [self performSegueWithIdentifier:@"toHome" sender:self];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logInPressed:(id)sender {
    NSString *email = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    [PFUser logInWithUsernameInBackground:email password:password block:^(PFUser *user, NSError *error) {
        if (user) {
            [self performSegueWithIdentifier:@"toHome" sender:self];
        }
        else {
            [[[UIAlertView alloc] initWithTitle:@"Login Failed"
                                        message:@"Incorrect username or password."
                                       delegate:nil
                              cancelButtonTitle:@"ok"
                              otherButtonTitles:nil] show];
            
        }
    }];
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
