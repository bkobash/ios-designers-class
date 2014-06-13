//
//  PostViewController.m
//  bookface
//
//  Created by Brian Kobashikawa on 6/8/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()
@property (weak, nonatomic) IBOutlet UIView *postPhoto;
@property (weak, nonatomic) IBOutlet UIView *postCard;
@property (weak, nonatomic) IBOutlet UIView *postInput;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

- (IBAction)postInputBox:(id)sender;
- (IBAction)onBodyTap:(id)sender;
- (IBAction)onLikeButton:(id)sender;

- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@end

@implementation PostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // update titlebar
    self.navigationItem.title = @"Post";
    
    // style the card background
    self.postCard.layer.borderWidth = 1.0f;
    self.postCard.layer.borderColor = [[UIColor alloc] initWithRed:190.0/255.0 green:193.0/255.0 blue:198.0/255.0 alpha:1].CGColor;
    self.postCard.layer.cornerRadius = 3.0f;
    
    // style the photo
    self.postPhoto.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.postPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
    self.postPhoto.layer.shadowRadius = 1.5f;
    self.postPhoto.layer.shadowOpacity = 0.5f;
    
    // reposition input box - not working...
    self.postInput.frame = CGRectMake(0, self.view.frame.size.height - self.postInput.frame.size.height - 49, self.postInput.frame.size.width, self.postInput.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)postInputBox:(id)sender {
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    // NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.postInput.frame = CGRectMake(0, self.view.frame.size.height - kbSize.height - self.postInput.frame.size.height, self.postInput.frame.size.width, self.postInput.frame.size.height);
                     }
                     completion:nil];
}

- (void)willHideKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.postInput.frame = CGRectMake(0, self.view.frame.size.height - self.postInput.frame.size.height - 49, self.postInput.frame.size.width, self.postInput.frame.size.height);
                     }
                     completion:nil];
}

- (IBAction)onBodyTap:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)onLikeButton:(id)sender {
    if (self.likeButton.selected == NO) {
        self.likeButton.selected = YES;
    } else {
        self.likeButton.selected = NO;
    }
}

@end
