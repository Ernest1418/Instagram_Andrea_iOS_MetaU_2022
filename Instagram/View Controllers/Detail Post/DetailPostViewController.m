//
//  DetailPostViewController.m
//  Instagram
//
//  Created by Andrea Gonzalez on 6/29/22.
//

#import "DetailPostViewController.h"

@interface DetailPostViewController ()

@end

@implementation DetailPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set up all text labels (User name, post caption)
    self.detailPostUsernameLabel.text = self.detailPost.author.username;
    self.detailPostCaptionLabel.text = self.detailPost.caption;

    // Set up image view
    Post *post = self.detailPost;
    PFFileObject* obj = post.image;
    NSData* postData = obj.getData;
        
    self.detailPostImageView.image = [UIImage imageWithData:postData];
    
    // Set up date text label
    //self.detailTimeAgoLabel.text = self.detailPost.createdAtString;
    
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
