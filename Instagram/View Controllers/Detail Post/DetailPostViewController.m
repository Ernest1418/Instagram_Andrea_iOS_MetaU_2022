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
    self.detailPostUsernameLabel.text = [@"@" stringByAppendingString:self.detailPost.author.username];
    self.detailPostCaptionLabel.text = self.detailPost.caption;

    // Set up image view
    Post *post = self.detailPost;
    PFFileObject* obj = post.image;
    NSData* postData = obj.getData;
        
    self.detailPostImageView.image = [UIImage imageWithData:postData];
    
    // Format and set createdAtDate
    NSDate *createdAtOriginalDate = self.detailPost.createdAt;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // Configure the input format to parse the date string in a format like "Wed Aug 27 13:08:45 +0000 2008”
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    
    // Set up date text label
    self.detailTimeAgoLabel.text = [formatter stringFromDate:createdAtOriginalDate];;
    
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
