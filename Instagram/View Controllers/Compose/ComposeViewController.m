//
//  ComposeViewController.m
//  Instagram
//
//  Created by Andrea Gonzalez on 6/27/22.
//

#import "ComposeViewController.h"
#import "HomeFeedViewController.h"
#import "SceneDelegate.h"

@interface ComposeViewController ()

@end

@implementation ComposeViewController

- (IBAction)didTapCancel:(id)sender {
    SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects.firstObject.delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    HomeFeedViewController *homeFeedViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeFeedViewController"];
    sceneDelegate.window.rootViewController = homeFeedViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
