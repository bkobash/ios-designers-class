//
//  SearchViewController.m
//  hw4-tumblr
//
//  Created by Brian Kobashikawa on 6/28/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *feedView;
@property (weak, nonatomic) IBOutlet UIImageView *loadingView;

- (void)showLoadingAnimation;
- (void)showFeed;

@end

@implementation SearchViewController

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
    self.scrollView.contentSize = CGSizeMake(320, 1500);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showLoadingAnimation {
    
    // hide the feed first
    self.feedView.alpha = 0;
    
    // set up loading animation using an array of image IDs
    NSMutableArray *loadingImages = [NSMutableArray arrayWithCapacity:3];
    for (NSInteger i = 0; i < 3; i++) {
        NSString *nameOfImage = [NSString stringWithFormat:@"Loading%d", i+1];
        UIImage *image = [UIImage imageNamed:nameOfImage];
        [loadingImages addObject:image];
    }
    self.loadingView.alpha = 1;
    self.loadingView.animationImages = loadingImages;
    self.loadingView.animationDuration = 0.5f;
    [self.loadingView startAnimating];
    
    // show the feed (and hide the loading animation) after 3 secs
    [self performSelector:@selector(showFeed) withObject:nil afterDelay:3];
}

- (void)showFeed {
    // stop the loading animation and hide it
    [self.loadingView stopAnimating];
    self.loadingView.alpha = 0;
    
    // show the feed
    self.feedView.alpha = 1;
}

@end
