//
//  SignUpViewController.m
//  PerfectDay
//
//  Created by Rachel on 12/11/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import "SignUpViewController.h"
#import "DBKeys.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()
@property (strong, nonatomic) IBOutlet UITextField *fullNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* Checks if the password is valid. If it is not, returns a string describing the error. If it is, returns the empty string. */
- (NSString *)passwordIsValid {
    if (![self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        return @"Passwords don't match.";
    } else if (self.passwordTextField.text.length < 4) {
        return @"Password must be at least 4 characters.";
    } else if (self.passwordTextField.text.length > 20) {
        return @"Password must be less than 20 characters.";
    } else {
        return @"";
    }
}


- (IBAction)signUpPressed:(id)sender {
    /* Check password first */
    NSString *passwordValidString = [self passwordIsValid];
    if (![passwordValidString isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid password" message:passwordValidString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    PFUser *user = [PFUser user];
    user.username = self.emailTextField.text;
    user.email = self.emailTextField.text;
    user.password = self.passwordTextField.text;
    user[USER_FULL_NAME] = self.fullNameTextField.text;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {   // Hooray! Let them use the app now.
            [self performSegueWithIdentifier:@"toHome" sender:self];
        } else {
            NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            NSLog(@"%@", errorString);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:errorString message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
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
