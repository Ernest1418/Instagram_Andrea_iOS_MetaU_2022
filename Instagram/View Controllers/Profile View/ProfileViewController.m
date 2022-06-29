//
//  ProfileViewController.m
//  Instagram
//
//  Created by Andrea Gonzalez on 6/27/22.
//

#import "ProfileViewController.h"
#import "ComposeViewController.h"
#import "SceneDelegate.h"
#import "ProfilePostCollectionViewCell.h"
#import "HomeFeedViewController.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation ProfileViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Register cell classes
    [self.postFeedCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do additional setup after loading the view.
    self.postFeedCollectionView.dataSource = self;
    self.postFeedCollectionView.delegate = self;
    
    [self refreshData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfilePostCollectionViewCell *cell = [self.postFeedCollectionView dequeueReusableCellWithReuseIdentifier:@"ProfilePostCell" forIndexPath:indexPath];
   
    Post *post = self.posts[indexPath.row];
    self.usernameProfileLabel.text = [@"@" stringByAppendingString:post.author.username];
    
    PFFileObject* obj = post.image;
    NSData* postImageData = obj.getData;
    cell.profilePostImage.image = [UIImage imageWithData:postImageData];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.posts.count;
}

- (void)refreshData {
    // Construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 20;
    
    // Instruct Parse to fetch the related user when we query for messages
    [query includeKey:@"author"];
    
    // Fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.posts = [[NSMutableArray alloc] init];
            [self.posts addObjectsFromArray:posts];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        // Reload the tableView now that there is new data
        [self.postFeedCollectionView reloadData];
    }];
}

@end
