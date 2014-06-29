//
//  TabViewController.m
//  hw4-tumblr
//
//  Created by Brian Kobashikawa on 6/28/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "TabViewController.h"
#import "HomeViewController.h"
#import "SearchViewController.h"
#import "AccountViewController.h"
#import "ActivityViewController.h"
#import "ComposeViewController.h"

@interface TabViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) HomeViewController *homeViewController;
@property (strong, nonatomic) SearchViewController *searchViewController;
@property (strong, nonatomic) AccountViewController *accountViewController;
@property (strong, nonatomic) ActivityViewController *activityViewController;
@property (strong, nonatomic) ComposeViewController *composeViewController;

@property (nonatomic, strong) UINavigationController *homeNavigationController;
@property (nonatomic, strong) UINavigationController *activityNavigationController;

@property (weak, nonatomic) IBOutlet UIImageView *exploreBubbleView;
@property (weak, nonatomic) IBOutlet UIButton *tabHome;
@property (weak, nonatomic) IBOutlet UIButton *tabSearch;
@property (weak, nonatomic) IBOutlet UIButton *buttonCompose;
@property (weak, nonatomic) IBOutlet UIButton *tabAccount;
@property (weak, nonatomic) IBOutlet UIButton *tabActivity;

@property (nonatomic) BOOL firstLoaded;

- (IBAction)onHomeTap:(id)sender;
- (IBAction)onSearchTap:(id)sender;
- (IBAction)onComposeTap:(id)sender;
- (IBAction)onAccountTap:(id)sender;
- (IBAction)onActivityTap:(id)sender;

- (void) clearTabs;
- (void) showExploreBubble;
- (void) hideExploreBubble;


@end

@implementation TabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.homeViewController = [[HomeViewController alloc] init];
        self.searchViewController = [[SearchViewController alloc] init];
        self.accountViewController = [[AccountViewController alloc] init];
        self.activityViewController = [[ActivityViewController alloc] init];
        self.composeViewController = [[ComposeViewController alloc] init];
        
        self.homeNavigationController = [[UINavigationController alloc] initWithRootViewController:self.homeViewController];
        self.activityNavigationController = [[UINavigationController alloc] initWithRootViewController:self.activityViewController];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.homeNavigationController.view.frame = self.contentView.frame;
    self.searchViewController.view.frame = self.contentView.frame;
    self.accountViewController.view.frame = self.contentView.frame;
    self.activityNavigationController.view.frame = self.contentView.frame;
    
    self.homeNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.homeNavigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.homeNavigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:46.0/255.0 green:62.0/255.0 blue:83.0/255.0 alpha:1];
    self.homeNavigationController.navigationBar.translucent = NO;
    
    self.activityNavigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.activityNavigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.activityNavigationController.navigationBar.barTintColor = [[UIColor alloc] initWithRed:46.0/255.0 green:62.0/255.0 blue:83.0/255.0 alpha:1];
    self.activityNavigationController.navigationBar.translucent = NO;
    
    [self clearTabs];
    self.tabHome.selected = YES;
    
    [self.contentView addSubview:self.homeNavigationController.view];
    
    self.firstLoaded = YES;
    [self performSelector:@selector(showExploreBubble) withObject:nil afterDelay:0.1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearTabs {
    self.tabHome.selected = NO;
    self.tabSearch.selected = NO;
    self.tabAccount.selected = NO;
    self.tabActivity.selected = NO;
}

- (void) showExploreBubble {
    
    CGPoint originalLocation = CGPointMake(self.exploreBubbleView.center.x, 490);
    
    if (self.exploreBubbleView.alpha == 0 || self.firstLoaded) {
        self.firstLoaded = NO;
        // first, move up the bubble
        [UIView animateWithDuration:0.5 delay:0 options: UIViewAnimationOptionCurveEaseOut animations:^{
            self.exploreBubbleView.center = CGPointMake(originalLocation.x, originalLocation.y);
            self.exploreBubbleView.alpha = 1;
        } completion:^(BOOL finished) {
            // then, make it bob up and down
            [UIView animateWithDuration:1.5 delay:0 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat) animations:^{
                self.exploreBubbleView.center = CGPointMake(originalLocation.x, originalLocation.y + 10);
            } completion:nil];
        }];
    }
}

- (void) hideExploreBubble {
    
    CGPoint originalLocation = CGPointMake(self.exploreBubbleView.center.x, 490);
    
    if (self.exploreBubbleView.alpha == 1) {
        // fade the bubble out
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.exploreBubbleView.alpha = 0;
            self.exploreBubbleView.center = CGPointMake(originalLocation.x, 530);
        } completion:nil];
    }
}

- (IBAction)onHomeTap:(id)sender {
    [self clearTabs];
    self.tabHome.selected = YES;
    
    [self.contentView addSubview:self.homeNavigationController.view];
    [self showExploreBubble];
}

- (IBAction)onSearchTap:(id)sender {
    [self clearTabs];
    self.tabSearch.selected = YES;
    
    [self.contentView addSubview:self.searchViewController.view];
    [self.searchViewController showLoadingAnimation];
    
    [self hideExploreBubble];
}

- (IBAction)onComposeTap:(id)sender {
    [self presentViewController:self.composeViewController animated:NO completion:nil];
    [self.composeViewController performSelector:@selector(bounceActionsIn) withObject:nil afterDelay:0.1];
}

- (IBAction)onAccountTap:(id)sender {
    [self clearTabs];
    self.tabAccount.selected = YES;
    
    [self.contentView addSubview:self.accountViewController.view];
    [self showExploreBubble];
}

- (IBAction)onActivityTap:(id)sender {
    [self clearTabs];
    self.tabActivity.selected = YES;
    
    [self.contentView addSubview:self.activityNavigationController.view];
    [self showExploreBubble];
}
@end
