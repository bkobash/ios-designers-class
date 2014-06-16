//
//  LoginViewController.m
//  hw2-fblogin
//
//  Created by Brian Kobashikawa on 6/12/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "LoginViewController.h"
#import "NewsFeedViewController.h"
#import "RequestsViewController.h"
#import "MoreViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *loginFormView;
@property (weak, nonatomic) IBOutlet UIView *loginMiscView;
@property (weak, nonatomic) IBOutlet UIView *facebookLogoView;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;

- (IBAction)onUsernameEdit:(id)sender;
- (IBAction)onPasswordEdit:(id)sender;
- (IBAction)onLoginTap:(id)sender;
- (IBAction)onBodyTap:(id)sender;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

- (void)checkToEnableLogin;
- (void)checkLoginFields;
- (void)switchToLoggingIn:(BOOL)loggingIn;

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Register the methods for the keyboard hide/show events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self checkToEnableLogin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onUsernameEdit:(id)sender {
    [self checkToEnableLogin];
}
- (IBAction)onPasswordEdit:(id)sender {
    [self checkToEnableLogin];
}
- (IBAction)onLoginTap:(id)sender {
    [self.view endEditing:YES];
    
    [self switchToLoggingIn:YES];
    
    [self performSelector:@selector(checkLoginFields) withObject:nil afterDelay:2];
}

- (IBAction)onBodyTap:(id)sender {
    [self.view endEditing:YES];
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    // NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.facebookLogoView.frame = CGRectMake(73, 60, 172, 43);
                         self.loginFormView.frame = CGRectMake(13, 140, 295, 145);
                         self.loginMiscView.frame = CGRectMake(20, 315, 280, 69);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.facebookLogoView.frame = CGRectMake(73, 129, 172, 43);
                         self.loginFormView.frame = CGRectMake(13, 212, 295, 145);
                         self.loginMiscView.frame = CGRectMake(20, 476, 280, 69);
                     }
                     completion:nil];
}

- (void)checkToEnableLogin {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    if ([username isEqualToString:@""] || [password isEqualToString:@""]) {
        self.loginButton.enabled = NO;
        self.loginButton.layer.opacity = 0.5;
    } else {
        self.loginButton.enabled = YES;
        self.loginButton.layer.opacity = 1;
    }
}

- (void)checkLoginFields {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [self switchToLoggingIn:NO];
    
    if ([username isEqualToString:@"bkobash"] && [password isEqualToString:@"password"]) {
        
        // clear out username/password fields
        self.usernameField.text = @"";
        self.passwordField.text = @"";
        [self checkToEnableLogin];
        
        // set up tab view controllers
        NewsFeedViewController *newsFeedViewController = [[NewsFeedViewController alloc] init];
        RequestsViewController *requestsViewController = [[RequestsViewController alloc] init];
        RequestsViewController *messengerViewController = [[RequestsViewController alloc] init];
        RequestsViewController *notificationsViewController = [[RequestsViewController alloc] init];
        MoreViewController *moreViewController = [[MoreViewController alloc] init];
        
        // add a nav controller to the news tab
        UINavigationController *newsFeedNavController = [[UINavigationController alloc] initWithRootViewController:newsFeedViewController];
        newsFeedNavController.navigationBar.tintColor = [UIColor whiteColor];
        newsFeedNavController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        newsFeedNavController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:77.0/255.0 green:106.0/255.0 blue:164.0/255.0 alpha:1];
        newsFeedNavController.navigationBar.translucent = NO;
        
        // add a nav controller to the more tab
        UINavigationController *moreNavController = [[UINavigationController alloc] initWithRootViewController:moreViewController];
        moreNavController.navigationBar.tintColor = [UIColor whiteColor];
        moreNavController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        moreNavController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:77.0/255.0 green:106.0/255.0 blue:164.0/255.0 alpha:1];
        moreNavController.navigationBar.translucent = NO;
        
        // add a tab controller
        UITabBarController *tabBarView = [[UITabBarController alloc] init];
        tabBarView.viewControllers = @[newsFeedNavController, requestsViewController, messengerViewController, notificationsViewController, moreNavController];
        tabBarView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        newsFeedNavController.tabBarItem.title = @"News Feed";
        newsFeedNavController.tabBarItem.image = [UIImage imageNamed:@"tabNewsFeed"];
        requestsViewController.tabBarItem.title = @"Requests";
        requestsViewController.tabBarItem.image = [UIImage imageNamed:@"tabRequests"];
        messengerViewController.tabBarItem.title = @"Messenger";
        messengerViewController.tabBarItem.image = [UIImage imageNamed:@"tabMessenger"];
        notificationsViewController.tabBarItem.title = @"Notifications";
        notificationsViewController.tabBarItem.image = [UIImage imageNamed:@"tabNotifications"];
        moreNavController.tabBarItem.title = @"More";
        moreNavController.tabBarItem.image = [UIImage imageNamed:@"tabMore"];
        
        // present the tab controller as a modal view
        [self presentViewController:tabBarView animated:YES completion:nil];
    } else {
        // show alert dialog
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"The password you entered is incorrect. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (void)switchToLoggingIn:(BOOL)loggingIn {
    if (loggingIn) {
        [self.loginButton setTitle:@"Logging In" forState:UIControlStateDisabled];
        self.loginButton.enabled = NO;
        self.loginButton.layer.opacity = 0.5;
        
        [self.loadingSpinner startAnimating];
    } else {
        [self.loginButton setTitle:@"Log In" forState:UIControlStateDisabled];
        self.loginButton.enabled = YES;
        self.loginButton.layer.opacity = 1;
        
        [self.loadingSpinner stopAnimating];
    }
}

@end
