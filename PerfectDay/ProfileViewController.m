//
//  ProfileViewController.m
//  PerfectDay
//
//  Created by Rachel on 12/13/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import "ProfileViewController.h"
#import "Common.h"
#import "DBKeys.h"

@interface ProfileViewController ()
// Profile picture stuff
@property BOOL isDisplayingProfPic;
@property BOOL hasProfPic;
@property (strong, nonatomic) IBOutlet UIImageView *profPicImageView;
@property (strong, nonatomic) IBOutlet UIButton *flipProfPicButton;
@property UIImage *profPicImage;
@end

#define CHANGE_PROFILE_PIC_TAG 1

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flipProfPicButton.enabled = NO;
    [Common setBackgroundGradientColorForView:self.view];
    [self setUpProfilePic];
}

/* This method loads the current user's profile picture and displays it as a circle. If the user doesn't have a profile picture yet, then it uses the "ADD PROFILE PICTURE" image as the profile pic image. */
- (void)setUpProfilePic {
    PFFile *imageFile = [self.userToDisplay objectForKey:USER_PROF_PIC];
    if (imageFile) {
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (data && !error) {
                self.isDisplayingProfPic = YES;
                self.hasProfPic = YES;
                self.flipProfPicButton.enabled = YES;
                UIImage *profilePicture = [UIImage imageWithData:data];
                self.profPicImage = profilePicture;
                [self.profPicImageView setImage:profilePicture];
                /* Crop to circle */
                [self.profPicImageView setImage:self.profPicImage];
                self.profPicImageView.layer.cornerRadius = self.profPicImageView.frame.size.width / 2;
                self.profPicImageView.clipsToBounds = YES;
            }
        }];
    } else {
        self.isDisplayingProfPic = NO;
        self.hasProfPic = NO;
        self.flipProfPicButton.enabled = YES;
        UIImage *defaultProfPic = [UIImage imageNamed:@"addProfPic.png"];
        self.profPicImage = defaultProfPic;
        [self.profPicImageView setImage:defaultProfPic];
        /* Crop to circle */
        [self.profPicImageView setImage:self.profPicImage];
        self.profPicImageView.layer.cornerRadius = self.profPicImageView.frame.size.width / 2;
        self.profPicImageView.clipsToBounds = YES;
    }
}

/* This method is called when the user clicks on the profile picture. If a profile picture is currently being displayed, it flips over and displays the "change profile picture" image. If the "change profile picture image" is currently being displayed, then it displays an alert asking if the user wants to upload a new profile picture. Lastly, if the user doesn't have a profile picture and the "add profile picture" image is currently being displayed, then this method shows an alert asking if the user wants to upload a profile picture. */
- (IBAction)flipProfPicButtonPressed:(id)sender {
    if (self.isDisplayingProfPic && self.hasProfPic) {
        /* They clicked on their profile picture */
        self.isDisplayingProfPic = NO;
        UIImage *destImage = [UIImage imageNamed:@"changeProfPic.png"];
        self.flipProfPicButton.enabled = NO;
        [UIView transitionWithView:self.profPicImageView duration:.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.profPicImageView.image = destImage;
            self.flipProfPicButton.enabled = YES;
        } completion:nil];
    } else {
        /* They clicked change prof pic */
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Change profile picture?" message:nil delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        alert.tag = CHANGE_PROFILE_PIC_TAG;
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/* Flips the profile picture and displays the user's profile picture, if they have one. Does nothing if they don't. */
- (void) showProfPic {
    if (self.hasProfPic) {
        self.flipProfPicButton.enabled = NO;
        [UIView transitionWithView:self.profPicImageView duration:.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            self.profPicImageView.image = self.profPicImage;
            self.flipProfPicButton.enabled = YES;
        } completion:nil];
    }
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == CHANGE_PROFILE_PIC_TAG) {
        if (buttonIndex == 0) {
            self.isDisplayingProfPic = YES;
            // Change back to prof pic, or leave it as ADD PROFILE PIC pic if they don't have one
            [self showProfPic];
        } else if (buttonIndex == 1) {
            self.isDisplayingProfPic = YES;
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.hasProfPic = YES;
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    
    [picker dismissViewControllerAnimated:NO completion:NULL];
    
    self.profPicImage = chosenImage;
    NSData *imageData = UIImagePNGRepresentation(chosenImage);
    PFFile *imageFile = [PFFile fileWithName:@"profilePic" data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL success, NSError *err) {
        PFUser *user = [PFUser currentUser];
        [user setObject:imageFile forKey:USER_PROF_PIC];
        [user saveInBackground];
    }];
    
    [UIView transitionWithView:self.profPicImageView duration:.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        self.profPicImageView.image = chosenImage;
        self.flipProfPicButton.enabled = YES;
    } completion:nil];
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
