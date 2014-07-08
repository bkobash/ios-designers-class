//
//  AddYahooAccountViewController.m
//  keepr
//
//  Created by Brian Kobashikawa on 7/7/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "AddYahooAccountViewController.h"
#import "HomeViewController.h"

@interface AddYahooAccountViewController ()

@property (strong, nonatomic) HomeViewController *homeViewController;
- (IBAction)onYahooLoginTap:(id)sender;

@end

@implementation AddYahooAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.homeViewController = [[HomeViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.homeViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onYahooLoginTap:(id)sender {
    [self presentViewController:self.homeViewController animated:YES completion:nil];
}
@end
