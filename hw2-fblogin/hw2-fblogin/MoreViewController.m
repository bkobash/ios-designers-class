//
//  MoreViewController.m
//  hw2-fblogin
//
//  Created by Brian Kobashikawa on 6/13/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)onLogoutTap:(id)sender;

@end

@implementation MoreViewController

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
    self.navigationItem.title = @"More";
    
    // set up left/right buttons
    UIImage *leftButtonImage = [[UIImage imageNamed:@"navbarSearch"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftButton;
    UIImage *rightButtonImage = [[UIImage imageNamed:@"navbarFriends"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:rightButtonImage style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    // set up scroll view
    self.scrollView.contentSize = CGSizeMake(320, 1200);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLogoutTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
