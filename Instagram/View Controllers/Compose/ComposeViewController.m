//
//  ComposeViewController.m
//  Instagram
//
//  Created by Andrea Gonzalez on 6/27/22.
//

#import "ComposeViewController.h"
#import "HomeFeedViewController.h"
#import "SceneDelegate.h"
#import "Post.h"
#import <Parse/Parse.h>

@interface ComposeViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ComposeViewController

- (IBAction)didTapShare:(id)sender {
    [Post postUserImage:self.composePostImageView.image withCaption:self.composeCaptionTextField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"Error posting image: %@", error.localizedDescription);
        }
        else{
            [self.delegate didPost:self.post];
            NSLog(@"Posted Image, Success!");
        }
    }];
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)didTapSelectImage:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    //imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    //[self presentViewController:imagePickerVC animated:YES completion:nil];

    // The Xcode simulator does not support taking pictures, so let's first check that the camera is indeed supported on the device before trying to present it.
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];

    // Upload image into the compose post image view and also resize the image to be 150 by 150 dimensions
    [self.composePostImageView setImage:[self resizeImage:originalImage withSize:CGSizeMake(414,414)]];
    
    // Dismiss UIImagePickerController to go back to the original view controller (Compose)
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (IBAction)didTapCancel:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    HomeFeedViewController *navViewController = [storyboard instantiateViewControllerWithIdentifier:@"NavController"];
    sceneDelegate.window.rootViewController = navViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.composeCaptionTextField.delegate = self;
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
