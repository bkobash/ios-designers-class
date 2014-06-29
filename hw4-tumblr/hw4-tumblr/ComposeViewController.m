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

- (void)dismissCompose;
- (void)bounceActionsIn;
- (void)bounceActionsOut;
- (void)bounceAction:(UIImageView *)image withDelay:(float)delayTime toDestinationY:(int)destY fromBottom:(BOOL)bottom;

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
    // move the circles out (to the top)
    [self bounceActionsOut];
    
    // hide the modal dialog after animations complete
    [self performSelector:@selector(dismissCompose) withObject:nil afterDelay:0.5];
}

- (void)bounceActionsIn {
    // animate in the circles at semi-random intervals
    [self bounceAction:self.composeTextView withDelay:0 toDestinationY:210 fromBottom:YES];
    [self bounceAction:self.composePhotoView withDelay:0.5 toDestinationY:210 fromBottom:YES];
    [self bounceAction:self.composeQuoteView withDelay:0.25 toDestinationY:210 fromBottom:YES];
    [self bounceAction:self.composeLinkView withDelay:0.75 toDestinationY:330 fromBottom:YES];
    [self bounceAction:self.composeChatView withDelay:0 toDestinationY:330 fromBottom:YES];
    [self bounceAction:self.composeVideoView withDelay:0.5 toDestinationY:330 fromBottom:YES];
}

- (void)bounceActionsOut {
    // animate out the circles at semi-random intervals
    [self bounceAction:self.composeTextView withDelay:0 toDestinationY:0 fromBottom:NO];
    [self bounceAction:self.composePhotoView withDelay:0.1 toDestinationY:0 fromBottom:NO];
    [self bounceAction:self.composeQuoteView withDelay:0.1 toDestinationY:0 fromBottom:NO];
    [self bounceAction:self.composeLinkView withDelay:0.2 toDestinationY:0 fromBottom:NO];
    [self bounceAction:self.composeChatView withDelay:0.1 toDestinationY:0 fromBottom:NO];
    [self bounceAction:self.composeVideoView withDelay:0.2 toDestinationY:0 fromBottom:NO];
}

- (void)bounceAction:(UIImageView *)image withDelay:(float)delayTime toDestinationY:(int)destY fromBottom:(BOOL)bottom {
    float duration = 1;
    if (bottom) {
        // action comes from the bottom
        image.center = CGPointMake(image.center.x, 1000);
    } else {
        // action moves to the top, much quicker
        destY = -100;
        duration = 0.5;
    }
    [UIView animateWithDuration:duration delay:delayTime usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        image.center = CGPointMake(image.center.x, destY);
    } completion:^(BOOL finished) { }];
}

- (void) dismissCompose {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
