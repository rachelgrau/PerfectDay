
//
//  ProfileViewController.h
//  PerfectDay
//
//  Created by Rachel on 12/13/15.
//  Copyright © 2015 Rachel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ProfileViewController : UIViewController <UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate >
@property PFUser *userToDisplay;
@end
