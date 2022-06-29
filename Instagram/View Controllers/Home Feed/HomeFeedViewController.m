//
//  HomeFeedViewController.m
//  Instagram
//
//  Created by Andrea Gonzalez on 6/27/22.
//

#import "HomeFeedViewController.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import "ComposeViewController.h"
#import "Post.h"
#import "HomeFeedTableViewCell.h"
#import "DetailPostViewController.h"

@interface HomeFeedViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *postTableView;


@end

@implementation HomeFeedViewController

- (IBAction)tapComposeButton:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    ComposeViewController *composeNavViewController = [storyboard instantiateViewControllerWithIdentifier:@"ComposeNav"];
    [self presentViewController:composeNavViewController animated:YES completion:^{
            
    }];
}

- (IBAction)tapLogoutButton:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
    }];
    SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    sceneDelegate.window.rootViewController = loginViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Table View Set Up
    self.postTableView.dataSource = self;
    self.postTableView.delegate = self;
    self.postTableView.rowHeight = UITableViewAutomaticDimension;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:true];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.postTableView insertSubview:refreshControl atIndex:0];
}

// Makes a query request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self refreshData];

    // Reload the tableView now that there is new data
    [self.postTableView reloadData];

    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];
}

- (void)didPost:(nonnull Post *)post {
    [self.arrayOfPosts insertObject:post atIndex:0];
    [self.postTableView reloadData];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // UINavigationController *navigationController = [segue destinationViewController];
    
    if([segue.identifier isEqualToString:@"DetailSegue"]) {
        Post *cell = sender;
        NSIndexPath *myIndexPath = [self.postTableView indexPathForCell:cell];
        
        Post *dataToPass = self.arrayOfPosts[myIndexPath.row];
        DetailPostViewController *detailVC = [segue destinationViewController];
        detailVC.detailPost = dataToPass;
    }
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    HomeFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeFeedTableViewCell" forIndexPath:indexPath];
    
    Post *post = self.arrayOfPosts[indexPath.row];
    PFFileObject* obj = post.image;
    
    NSData* postData = obj.getData;
        
    cell.instagramPostImageView.image = [UIImage imageWithData:postData];
    cell.postCaptionLabel.text = post.caption;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfPosts.count;
}

- (void)onTimer {
   // Add code to be run periodically
    [self refreshData];
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
            self.arrayOfPosts = [[NSMutableArray alloc] init];
            [self.arrayOfPosts addObjectsFromArray:posts];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        // Reload the tableView now that there is new data
        [self.postTableView reloadData];
    }];
}

@end
