//
//  DetailPostViewController.h
//  Instagram
//
//  Created by Andrea Gonzalez on 6/29/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PostDetailViewControllerDelegate
@end

@interface DetailPostViewController : UIViewController
@property (nonatomic, strong) Post *detailPost;
@property (weak, nonatomic) IBOutlet UILabel *detailTimeAgoLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailPostUsernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailPostCaptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailPostImageView;
@property (nonatomic, weak) id<PostDetailViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
