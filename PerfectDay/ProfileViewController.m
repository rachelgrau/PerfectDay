//
//  ProfileViewController.m
//  PerfectDay
//
//  Created by Rachel on 12/13/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import "ProfileViewController.h"
#import "LikeCollectionViewCell.h"
#import "ChooseLikesView.h"
#import "Common.h"
#import "DBKeys.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIButton *hometownButton;
@property BOOL hasHometown;
// Profile picture stuff
@property BOOL isDisplayingProfPic;
@property BOOL hasProfPic;
@property (strong, nonatomic) IBOutlet UIImageView *profPicImageView;
@property (strong, nonatomic) IBOutlet UIButton *flipProfPicButton;
@property UIImage *profPicImage;
// Likes
@property (strong, nonatomic) IBOutlet UICollectionView *likesCollectionView;
@property NSArray *likes;
@property (strong, nonatomic) IBOutlet ChooseLikesView *chooseLikesView;
@property UIButton *translucentBlackButton;
// Choose like view
@property (strong, nonatomic) IBOutlet UICollectionView *chooseLikeCollectionView;
@property NSMutableArray *editedLikes; // for when they are adding new likes. includes old ones.
@property NSArray *likeOptions; // all the options for likes
@property (strong, nonatomic) IBOutlet UIButton *saveLikesButton;
@property (strong, nonatomic) IBOutlet UIButton *exitButton;
@end

#define CHANGE_PROFILE_PIC_TAG 1

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* Prof pic */
    self.flipProfPicButton.enabled = NO;
    [Common setBackgroundGradientColorForView:self.view];
    [self setUpProfilePic];

    /* Name label */
    self.nameLabel.text = [self.userToDisplay objectForKey:USER_FULL_NAME];
    
    /* Hometown label */
    NSString *addHometown = @"Add a hometown +";
    if ([PFUser currentUser] == self.userToDisplay) {
        self.hometownButton.enabled = YES;
    } else {
        self.hometownButton.enabled = NO;
        addHometown = @"No hometown to display.";
    }
    
    NSString *hometown = [self.userToDisplay objectForKey:USER_HOMETOWN_CITY];
    if (!hometown || (hometown.length == 0)) {
        [self.hometownButton setTitle:addHometown forState:UIControlStateNormal];
        self.hasHometown = NO;
    } else {
        [self.hometownButton setTitle:hometown forState:UIControlStateNormal];
        self.hasHometown = YES;
    }
    
    /* Likes */
    // temp
    self.likes = [self.userToDisplay objectForKey:USER_LIKES];
    if (!self.likes) {
        self.likes = [[NSArray alloc] init];
    }
    self.likesCollectionView.backgroundColor = [UIColor clearColor];
    self.chooseLikesView.hidden = YES;
    self.chooseLikeCollectionView.backgroundColor = [UIColor clearColor];
    [Common setBorder:self.exitButton withColor:[Common getNavy]];
}

/* This method loads the "user to display"'s profile picture and displays it as a circle. If the user doesn't have a profile picture yet, then it uses the "ADD PROFILE PICTURE" image as the profile pic image. When done, it enables the flip prof pic button if the user to display is the user that's currently logged in (i.e. if the user is viewing his/her own profile) */
- (void)setUpProfilePic {
    PFFile *imageFile = [self.userToDisplay objectForKey:USER_PROF_PIC];
    if (imageFile) {
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (data && !error) {
                self.isDisplayingProfPic = YES;
                self.hasProfPic = YES;
                UIImage *profilePicture = [UIImage imageWithData:data];
                self.profPicImage = profilePicture;
                [self.profPicImageView setImage:profilePicture];
                /* Crop to circle */
                [self.profPicImageView setImage:self.profPicImage];
                self.profPicImageView.layer.cornerRadius = self.profPicImageView.frame.size.width / 2;
                self.profPicImageView.clipsToBounds = YES;
                if ([PFUser currentUser] == self.userToDisplay) {
                    self.flipProfPicButton.enabled = YES;
                }
            }
        }];
    } else {
        self.isDisplayingProfPic = NO;
        self.hasProfPic = NO;
        UIImage *defaultProfPic = [UIImage imageNamed:@"addProfPic.png"];
        self.profPicImage = defaultProfPic;
        [self.profPicImageView setImage:defaultProfPic];
        /* Crop to circle */
        [self.profPicImageView setImage:self.profPicImage];
        self.profPicImageView.layer.cornerRadius = self.profPicImageView.frame.size.width / 2;
        self.profPicImageView.clipsToBounds = YES;
        if ([PFUser currentUser] == self.userToDisplay) {
            self.flipProfPicButton.enabled = YES;
        }
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


#pragma mark - UICollectionView Delegate & Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    if (collectionView == self.likesCollectionView) {
        return 1;
    } else if (collectionView == self.chooseLikeCollectionView) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.likesCollectionView) {
        return self.likes.count + 1; // + 1 for the "add likes"
    } else if (collectionView == self.chooseLikeCollectionView) {
        return self.likeOptions.count;
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.likesCollectionView) {
        LikeCollectionViewCell *newCell = [self.likesCollectionView dequeueReusableCellWithReuseIdentifier:@"likeCell"
                                                                                              forIndexPath:indexPath];
        NSString *likeString = @"";
        if (indexPath.item == self.likes.count) {
            likeString = @"Add +";
        } else {
            likeString = [self.likes objectAtIndex:indexPath.item];
        }
        [newCell setUpCellWithTitle:likeString setFilled:YES];
        return newCell;
    } else if (collectionView == self.chooseLikeCollectionView) {
        LikeCollectionViewCell *newCell = [self.chooseLikeCollectionView dequeueReusableCellWithReuseIdentifier:@"chooseLikeCell"
                                                                                            forIndexPath:indexPath];
        NSString *likeString = [self.likeOptions objectAtIndex:indexPath.item];
        if ([self.editedLikes containsObject:likeString]) {
            [newCell setUpCellWithTitle:likeString setFilled:YES];
        } else {
            [newCell setUpCellWithTitle:likeString setFilled:NO];
        }
        return newCell;
    } else return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.likesCollectionView) {
        if (indexPath.item == self.likes.count) {
            /* They clicked "add like" so show choose likes view */
            self.chooseLikesView.hidden = NO;
            if (!self.translucentBlackButton) {
                self.translucentBlackButton = [[UIButton alloc] initWithFrame:self.view.frame];
                [self.translucentBlackButton setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
            }
            [self.view addSubview:self.translucentBlackButton];
            [self.view bringSubviewToFront:self.chooseLikesView];
            
            self.likeOptions = [Common getAllLikeOptions];
            if (!self.editedLikes) {
                self.editedLikes = [[NSMutableArray alloc] init];
            }
            self.editedLikes = [self.likes mutableCopy];
            [self.chooseLikeCollectionView reloadData];
        }
    } else if (collectionView == self.chooseLikeCollectionView) {
        LikeCollectionViewCell *cell = (LikeCollectionViewCell *)[self.chooseLikeCollectionView cellForItemAtIndexPath:indexPath];
        [cell switchFilled];
        NSString *likeString = [self.likeOptions objectAtIndex:indexPath.item];
        if ([self.editedLikes containsObject:likeString]) {
            [self.editedLikes removeObject:likeString];
        } else {
            [self.editedLikes addObject:likeString];
        }
    }
}

#pragma mark - choose likes stuff

- (IBAction)saveLikesPressed:(id)sender {
    self.likes = self.editedLikes;
    [self.userToDisplay setObject:self.likes forKey:USER_LIKES];
    /* Disable buttons and hide collection view while saving...*/
    self.chooseLikeCollectionView.hidden = YES;
    self.exitButton.enabled = NO;
    self.saveLikesButton.enabled = NO;
    [self.userToDisplay saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [self.likesCollectionView reloadData];
        /* Enable buttons and show collection view again */
        self.chooseLikeCollectionView.hidden = NO;
        self.exitButton.enabled = YES;
        self.saveLikesButton.enabled = YES;
        /* Hide choose likes view & translucent black button */
        self.chooseLikesView.hidden = YES;
        [self.translucentBlackButton removeFromSuperview];
    }];
}

- (IBAction)exitPressed:(id)sender {
    self.chooseLikesView.hidden = YES;
    [self.translucentBlackButton removeFromSuperview];
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
