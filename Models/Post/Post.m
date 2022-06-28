//
//  Post.m
//  Instagram
//
//  Created by Andrea Gonzalez on 6/28/22.
//

#import "Post.h"

@implementation Post
    
@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;
@dynamic likeCount;
@dynamic commentCount;

+ (nonnull NSString *)parseClassName {
    return @"Post";
}


/* Method to add a user post to Parse (uploading image file) that has a parameter image: Image that the user wants upload to parse, parameter caption: Caption text input by the user, and parameter completion: Block to be executed after save operation is complete */

+ (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion {
    
    Post *newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = [PFUser currentUser];
    newPost.caption = caption;
    newPost.likeCount = @(0);
    newPost.commentCount = @(0);
    
    [newPost saveInBackgroundWithBlock: completion];
}

/* Method to convert UIImage to PFFile that takes in a parameter image: Image that the user wants to upload to parse and returns: PFFile for the the data in the image */

+ (PFFileObject *)getPFFileFromImage: (UIImage * _Nullable)image {
 
    // Check if image is not nil
    if (!image) {
        return nil;
    }
    
    // Get image data and check if it is not nil
    NSData *imageData = UIImagePNGRepresentation(image);

    if (!imageData) {
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}


@end
