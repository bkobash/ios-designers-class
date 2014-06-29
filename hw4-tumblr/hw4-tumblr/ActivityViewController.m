//
//  ActivityViewController.m
//  hw4-tumblr
//
//  Created by Brian Kobashikawa on 6/28/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "ActivityViewController.h"
#import "LoginViewController.h"

@interface ActivityViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) LoginViewController *loginViewController;

- (IBAction)onLoginTap:(id)sender;

@end

@implementation ActivityViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.loginViewController = [[LoginViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"Activity";
    
    self.scrollView.contentSize = CGSizeMake(320, 350);
    self.loginViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginTap:(id)sender {
    // NSLog(@"tapped login button");
    [self.view.window.rootViewController presentViewController:self.loginViewController animated:YES completion:nil];
    
    [self.loginViewController performSelector:@selector(bounceLoginBox) withObject:nil afterDelay:0.1];
}
@end
