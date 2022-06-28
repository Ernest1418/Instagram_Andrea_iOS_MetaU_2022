//
//  ComposeViewController.h
//  Instagram
//
//  Created by Andrea Gonzalez on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;

@property (weak, nonatomic) IBOutlet UITextView *composeCaptionTextField;

@property (weak, nonatomic) IBOutlet UIImageView *composePostImageView;

@end

NS_ASSUME_NONNULL_END
