//
//  NewsFeedViewController.m
//  bookface
//
//  Created by Brian Kobashikawa on 6/4/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "NewsFeedViewController.h"
#import "PostViewController.h"

@interface NewsFeedViewController ()
- (IBAction)newsFeedButton:(id)sender;

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
    
    // add title
    self.navigationItem.title = @"News Feed";
    
    // fix the back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newsFeedButton:(id)sender {
    PostViewController *newsPost = [[PostViewController alloc] init];
    [self.navigationController pushViewController:newsPost animated:YES];
}
@end
