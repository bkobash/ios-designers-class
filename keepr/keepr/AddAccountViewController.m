//
//  AddAccountViewController.m
//  keepr
//
//  Created by Brian Kobashikawa on 7/7/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "AddAccountViewController.h"
#import "AddYahooAccountViewController.h"

@interface AddAccountViewController ()

@property (strong, nonatomic) AddYahooAccountViewController *addYahooAccountViewController;

- (IBAction)onYahooTap:(id)sender;

@end

@implementation AddAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.addYahooAccountViewController = [[AddYahooAccountViewController alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.addYahooAccountViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onYahooTap:(id)sender {
    [self.view.window.rootViewController presentViewController:self.addYahooAccountViewController animated:YES completion:nil];
}
@end
