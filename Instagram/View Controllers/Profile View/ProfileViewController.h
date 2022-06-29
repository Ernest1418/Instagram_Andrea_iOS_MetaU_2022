//
//  ProfileViewController.h
//  Instagram
//
//  Created by Andrea Gonzalez on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *postFeedCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *usernameProfileLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (nonatomic, strong) NSMutableArray *posts;


@end

NS_ASSUME_NONNULL_END
