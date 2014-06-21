//
//  PaperViewController.m
//  hw3-fbpaper
//
//  Created by Brian Kobashikawa on 6/20/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "PaperViewController.h"

@interface PaperViewController ()

@property (weak, nonatomic) IBOutlet UIView *mainScreenView;
@property (weak, nonatomic) IBOutlet UIScrollView *slideScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *headlineView1;
@property (weak, nonatomic) IBOutlet UIImageView *headlineView2;
@property (weak, nonatomic) IBOutlet UIImageView *headlineView3;
@property (weak, nonatomic) IBOutlet UIImageView *headlineView4;
@property (weak, nonatomic) IBOutlet UIImageView *slidesBigView;

@property (nonatomic) CGPoint originalMainScreenLocation;
@property (nonatomic) BOOL mainScreenDragged;
@property (nonatomic) BOOL mainScreenCollapsed;
@property (nonatomic) BOOL slidesDragged;
@property (nonatomic) BOOL slidesExpanded;

- (IBAction)onMainScreenDrag:(UIPanGestureRecognizer *)sender;
- (void) cycleImages;
- (void) resetSlidePositions;

@end

@implementation PaperViewController

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
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    self.slideScrollView.contentSize = CGSizeMake(1445, 254);
    self.slideScrollView.frame = CGRectMake(0, 314, 320, 254);
    
    self.headlineView2.alpha = 0;
    self.headlineView3.alpha = 0;
    self.headlineView4.alpha = 0;
    
    [self cycleImages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onMainScreenDrag:(UIPanGestureRecognizer *)sender {
    
    CGPoint location = [sender locationInView:self.view];
    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];

    int mainWidth = self.view.frame.size.width;
    int mainHeight = self.view.frame.size.height;
    int collapsedMainHeight = 44;
    int topMainY = mainHeight / 2;
    int bottomMainY = (mainHeight * 1.5) - collapsedMainHeight;
    int slideDefaultHeight = 254;
    int slideDefaultY = mainHeight - slideDefaultHeight;
    CGFloat slideScale = 2.23;
    CGPoint mainCenter = self.mainScreenView.center;
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        if (self.slidesExpanded) {
            // user had previously expanded the slides
            self.slidesDragged = YES;
        } else if (location.y < slideDefaultY || self.mainScreenCollapsed) {
            // user started dragging on headline area
            self.originalMainScreenLocation = mainCenter;
            self.mainScreenDragged = YES;
        } else {
            // user started dragged on the slides area
            self.slidesDragged = YES;
        }
        
    } else if (sender.state == UIGestureRecognizerStateChanged) {
        
        if (self.mainScreenDragged) {
            
            // user is dragging the headline area around
            if (mainCenter.y < topMainY) {
                // user dragged too high - add resistance
                mainCenter.y = topMainY + (translation.y * 0.3);
            } else if (mainCenter.y > bottomMainY) {
                // user dragged too low - add resistance, but more fuzzy
                mainCenter.y = bottomMainY + (translation.y * 0.5);
            } else {
                // user drags as normal
                mainCenter.y = self.originalMainScreenLocation.y + translation.y;
            }
            self.mainScreenView.center = mainCenter;
            
        } else if (self.slidesDragged) {
            
            // if the user started off expanded, make the base scale big
            CGFloat baseScale = self.slidesExpanded ? slideScale : 1;
            
            // as the user drags up/down, scale the slides accordingly
            CGFloat scale = baseScale - (translation.y / 200);
            
            // but don't let the user drag that low
            if (scale < 0.5) {
                scale = 0.5;
            }
            
            // set up the scrollview so that it scales up/down accordingly
            CGFloat slideWidth = MAX(mainWidth - (translation.x * scale), mainWidth);
            CGFloat slideHeight = slideDefaultHeight * scale;
            CGFloat slideX = MIN(0, translation.x * scale);
            CGFloat slideY = self.view.frame.size.height - slideHeight;
            
            self.slideScrollView.transform = CGAffineTransformMakeScale(scale, scale);
            self.slideScrollView.frame = CGRectMake(slideX, slideY, slideWidth, slideHeight);
            
            // fade in the "more detailed" slides as the user scales up
            self.slidesBigView.alpha = scale / 2 - .25;
        }
        
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        
        if (self.mainScreenDragged) {
            
            // user stopped dragging the headline area
            self.mainScreenDragged = NO;
            
            if (velocity.y > 0) {
                
                // user dragged down, collapse the main screen
                [UIView animateWithDuration:0.3 animations:^{
                    self.mainScreenView.center = CGPointMake(mainWidth / 2, bottomMainY);
                }];
                self.mainScreenCollapsed = YES;
                
            } else {
                
                // user dragged up, show the main screen
                [UIView animateWithDuration:0.3 animations:^{
                    self.mainScreenView.center = CGPointMake(mainWidth / 2, topMainY);
                }];
                self.mainScreenCollapsed = NO;
                
            }
            
        } else if (self.slidesDragged) {
            
            // user stopped dragging the slides area
            self.slidesDragged = NO;
            
            [self resetSlidePositions];
            
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                if (velocity.y < 0) {
                    
                    // the user moved up enough, blow it up
                    self.slideScrollView.transform =CGAffineTransformMakeScale(slideScale, slideScale);
                    self.slideScrollView.frame = CGRectMake(0, 0, mainWidth, mainHeight);
                    self.slidesBigView.alpha = 1;
                    
                } else {
                    
                    // the user didn't move up enough, settle it back down
                    self.slideScrollView.transform = CGAffineTransformMakeScale(1, 1);
                    self.slideScrollView.frame = CGRectMake(0, slideDefaultY, mainWidth, slideDefaultHeight);
                    self.slidesBigView.alpha = 0;
                    
                }
            } completion:^(BOOL finished) {
                // done
                if (velocity.y < 0) {
                    self.slidesExpanded = YES;
                } else {
                    self.slidesExpanded = NO;
                }
            }];
            
        }
    }
}

- (void)cycleImages {
    // convoluted way to cycle through headline images
    [UIView animateWithDuration:1 delay:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.headlineView2.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1 delay:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.headlineView3.alpha = 1;
        } completion:^(BOOL finished) {
            self.headlineView2.alpha = 0;
            [UIView animateWithDuration:1 delay:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.headlineView4.alpha = 1;
            } completion:^(BOOL finished) {
                self.headlineView3.alpha = 0;
                [UIView animateWithDuration:1 delay:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.headlineView4.alpha = 0;
                } completion:^(BOOL finished) {
                    [self cycleImages];
                }];
            }];
        }];
    }];
}

- (void) resetSlidePositions {
    
    // once enlarged, the slide scrollview snaps to the nearest slide position.
    // currently doubling the numbers because of the modulus operator only works
    // on integers.
    
    int slideWidth = 289;
    int slideOffsetX = (int) self.slideScrollView.contentOffset.x * 2;
    int slideOffset = slideOffsetX % slideWidth;
    CGPoint destOffset;
    
    if (slideOffset > slideWidth / 2) {
        destOffset = CGPointMake(((slideOffsetX - slideOffset + slideWidth) / 2), 0);
    } else {
        destOffset = CGPointMake(((slideOffsetX - slideOffset) / 2), 0);
    }
    
    [self.slideScrollView setContentOffset:destOffset animated:YES];
}

@end
