//
//  LoginViewController.m
//  hw4-tumblr
//
//  Created by Brian Kobashikawa on 6/28/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *loginBoxView;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)onCancelTap:(id)sender;

- (void)bounceLoginBox;

@end

@implementation LoginViewController

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCancelTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)bounceLoginBox {
    // add focus to the first textfield to show keyboard
    [self.emailTextField becomeFirstResponder];
    
    // move the textfields up with spring-like motion
    self.loginBoxView.center = CGPointMake(160, 600);
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.loginBoxView.center = CGPointMake(160, 200);
    } completion:^(BOOL finished) {
        // done
    }];
}
@end
