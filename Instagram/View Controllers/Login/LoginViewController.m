//
//  ViewController.m
//  Instagram
//
//  Created by Andrea Gonzalez on 6/27/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)registerUser:(id)sender {
    // Initialize a user object
    PFUser *newUser = [PFUser user];
    
    // Set user properties
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
        
    // Check if the user left either the username and/or password fields empty
    if ([self.usernameTextField.text isEqual:@""] || [self.passwordTextField.text isEqual:@""]) {
        // Create alert controller for empty username and/or password text fields
        UIAlertController *emptyFieldAlert = [UIAlertController alertControllerWithTitle:@"Username and Password Required" message:@"Please enter your username and password" preferredStyle:(UIAlertControllerStyleAlert)];

        // Create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // handle response here.
        }];
        
        // Add the OK action to the alert controller
        [emptyFieldAlert addAction:okAction];
        
        [self presentViewController:emptyFieldAlert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
    
    // Call sign up function on the user object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            // Manually segue to logged in view
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (IBAction)loginUser:(id)sender {
    // Retrieve user-entered username and password from text fields
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    // Check if the user left either the username and/or password fields empty
    if ([username isEqual:@""] || [password isEqual:@""]) {
        // Create alert controller for empty username and/or password text fields
        UIAlertController *emptyFieldAlert = [UIAlertController alertControllerWithTitle:@"Username and Password Required" message:@"Please enter your username and password" preferredStyle:(UIAlertControllerStyleAlert)];

        // Create an OK action
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // handle response here.
        }];
        
        // Add the OK action to the alert controller
        [emptyFieldAlert addAction:okAction];
        
        [self presentViewController:emptyFieldAlert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
        
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            // Display view controller that needs to be shown after successful login
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
