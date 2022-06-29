//
//  ComposeViewController.h
//  Instagram
//
//  Created by Andrea Gonzalez on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didPost:(Post *)post;

@end

@interface ComposeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;
@property (weak, nonatomic) IBOutlet UITextView *composeCaptionTextField;
@property (weak, nonatomic) IBOutlet UIImageView *composePostImageView;
@property (nonatomic, strong) id<ComposeViewControllerDelegate> delegate;
@property (nonatomic, strong) Post *post;

@end

NS_ASSUME_NONNULL_END
