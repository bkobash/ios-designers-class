//
//  NewsFeedViewController.m
//  hw2-fblogin
//
//  Created by Brian Kobashikawa on 6/13/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "NewsFeedViewController.h"
#import "ProfileViewController.h"

@interface NewsFeedViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;

- (IBAction)onProfileButtonTap:(id)sender;

-(void)showFeed;

@end

@implementation NewsFeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // add title
    self.navigationItem.title = @"News Feed";
    
    // set up left/right buttons
    UIImage *leftButtonImage = [[UIImage imageNamed:@"navbarSearch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftButton;
    UIImage *rightButtonImage = [[UIImage imageNamed:@"navbarFriends"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:rightButtonImage style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    // set up the scroll view
    self.scrollView.contentSize = CGSizeMake(320, 1000);
    self.scrollView.frame = CGRectMake(0, 455, 320, 410);
    
    // show spinner first, then hide after 2 secs
    self.scrollView.hidden = YES;
    [self performSelector:@selector(showFeed) withObject:nil afterDelay:2];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onProfileButtonTap:(id)sender {
    ProfileViewController *profileViewController = [[ProfileViewController alloc] init];
    [self.navigationController pushViewController:profileViewController animated:YES];
}

- (void)showFeed {
    [self.loadingSpinner stopAnimating];
    self.scrollView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
         self.scrollView.frame = CGRectMake(0, 45, 320, 459);
    }
    completion:nil];
}

@end
