//
//  HomeViewController.m
//  PerfectDay
//
//  Created by Rachel on 12/6/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "Common.h"
#import "ProfileViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self navigationController] setNavigationBarHidden:YES];
    [Common setBackgroundGradientColorForView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutPressed:(id)sender {
    if ([PFUser currentUser]) {
        [PFUser logOut];
        [self performSegueWithIdentifier:@"toLogIn" sender:self];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toBrowse"]) {
        // pass current user
    } else if ([segue.identifier isEqualToString:@"toProfile"]) {
        ProfileViewController *dest = segue.destinationViewController;
        dest.userToDisplay = [PFUser currentUser];
    }
}


@end
