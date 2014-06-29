//
//  ComposeViewController.m
//  hw4-tumblr
//
//  Created by Brian Kobashikawa on 6/28/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "ComposeViewController.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *composeTextView;
@property (weak, nonatomic) IBOutlet UIImageView *composePhotoView;
@property (weak, nonatomic) IBOutlet UIImageView *composeQuoteView;
@property (weak, nonatomic) IBOutlet UIImageView *composeLinkView;
@property (weak, nonatomic) IBOutlet UIImageView *composeChatView;
@property (weak, nonatomic) IBOutlet UIImageView *composeVideoView;

- (IBAction)onCancelTap:(id)sender;

- (void)bounceActionsIn;
- (void)bounceActionsOut;
- (void)dismissCompose;

@end

@implementation ComposeViewController

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
    [self bounceActionsOut];
    
    [self performSelector:@selector(dismissCompose) withObject:nil afterDelay:0.5];
}

- (void)bounceActionsIn {
    
    self.composeTextView.center = CGPointMake(self.composeTextView.center.x, 1000);
    self.composePhotoView.center = CGPointMake(self.composePhotoView.center.x, 1000);
    self.composeQuoteView.center = CGPointMake(self.composeQuoteView.center.x, 1000);
    self.composeLinkView.center = CGPointMake(self.composeLinkView.center.x, 1000);
    self.composeChatView.center = CGPointMake(self.composeChatView.center.x, 1000);
    self.composeVideoView.center = CGPointMake(self.composeVideoView.center.x, 1000);
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.composeTextView.center = CGPointMake(self.composeTextView.center.x, 210);
    } completion:^(BOOL finished) { }];
    
    [UIView animateWithDuration:1 delay:0.5 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.composePhotoView.center = CGPointMake(self.composePhotoView.center.x, 210);
    } completion:^(BOOL finished) { }];
    
    [UIView animateWithDuration:1 delay:0.25 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.composeQuoteView.center = CGPointMake(self.composeQuoteView.center.x, 210);
    } completion:^(BOOL finished) { }];
    
    [UIView animateWithDuration:1 delay:0.75 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.composeLinkView.center = CGPointMake(self.composeLinkView.center.x, 330);
    } completion:^(BOOL finished) { }];
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.composeChatView.center = CGPointMake(self.composeChatView.center.x, 330);
    } completion:^(BOOL finished) { }];
    
    [UIView animateWithDuration:1 delay:0.5 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.composeVideoView.center = CGPointMake(self.composeVideoView.center.x, 330);
    } completion:^(BOOL finished) { }];
}

- (void)bounceActionsOut {
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.composeTextView.center = CGPointMake(self.composeTextView.center.x, -100);
    } completion:^(BOOL finished) { }];
    
    [UIView animateWithDuration:0.5 delay:0.1 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.composePhotoView.center = CGPointMake(self.composePhotoView.center.x, -100);
    } completion:^(BOOL finished) { }];
    
    [UIView animateWithDuration:0.75 delay:0.1 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.composeQuoteView.center = CGPointMake(self.composeQuoteView.center.x, -100);
    } completion:^(BOOL finished) { }];
    
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.composeLinkView.center = CGPointMake(self.composeLinkView.center.x, -100);
    } completion:^(BOOL finished) { }];
    
    [UIView animateWithDuration:0.75 delay:0.1 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.composeChatView.center = CGPointMake(self.composeChatView.center.x, -100);
    } completion:^(BOOL finished) { }];
    
    [UIView animateWithDuration:0.5 delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.composeVideoView.center = CGPointMake(self.composeVideoView.center.x, -100);
    } completion:^(BOOL finished) { }];
}

- (void) dismissCompose {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
