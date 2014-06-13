//
//  LoadingViewController.m
//  warmup-week2
//
//  Created by Brian Kobashikawa on 6/12/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()

// if you want to specify a variable...
// always use nonatomic
// try to use strong as second argument. if you can't use strong, use "assign"

@property (nonatomic, assign) BOOL loading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;
@property (weak, nonatomic) IBOutlet UILabel *optionLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)onToggleLoadingTap:(id)sender;
- (IBAction)onAlertTap:(id)sender;
- (IBAction)onActionTap:(id)sender;

@end

@implementation LoadingViewController

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
    self.optionLabel.text = @"No option yet";
    // Do any additional setup after loading the view from its nib.
    
    // set up the scroll view
    self.scrollView.contentSize = CGSizeMake(320, 1000);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onToggleLoadingTap:(id)sender {
    if (self.loading) {
        [self.loadingSpinner stopAnimating];
        self.loading = NO;
    } else {
        [self.loadingSpinner startAnimating];
        self.loading = YES;
    }
    
//    if (self.loadingSpinner.isAnimating) {
//        [self.loadingSpinner stopAnimating];
//    } else {
//        [self.loadingSpinner startAnimating];
//    }
}

- (IBAction)onAlertTap:(id)sender {
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle: @"Hello" message: @"This is the message" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Option A", @"Option B", nil];
    [errorView show];
    
    // to capture those events, set the delegate from "nil" to "self"
    // also, modify the .h file to include <UIAlertViewDelegate>
    // cmd+click on UIAlertViewDelegate from there to find the (void)alertView method, and paste down below here
}

- (IBAction)onActionTap:(id)sender {
    UIActionSheet *actionView = [[UIActionSheet alloc] initWithTitle:@"Hello" delegate:self cancelButtonTitle:@"OK" destructiveButtonTitle:@"Destructo" otherButtonTitles:@"Option A", @"Option B", nil];
    [actionView showInView:self.view];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        self.optionLabel.text = @"Option A";
    } else if (buttonIndex == 2) {
        self.optionLabel.text = @"Option B";
    } else {
        self.optionLabel.text = @"No option selected";
    }
    NSLog(@"clicked the alert: %d", buttonIndex);
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clicked the sheet: %d", buttonIndex);
}
@end
