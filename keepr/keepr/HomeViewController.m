//
//  HomeViewController.m
//  keepr
//
//  Created by Brian Kobashikawa on 7/7/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "HomeViewController.h"
#import "ListLinksViewController.h"
#import "ListShoppingViewController.h"
#import "ListNotesViewController.h"
#import "ListImagesViewController.h"
#import "ListFilesViewController.h"
#import "ListSecureViewController.h"
#import "ListTodosViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *tabScrollView;

@property (strong, nonatomic) ListLinksViewController *listLinksViewController;
@property (strong, nonatomic) ListShoppingViewController *listShoppingViewController;
@property (strong, nonatomic) ListNotesViewController *listNotesViewController;
@property (strong, nonatomic) ListImagesViewController *listImagesViewController;
@property (strong, nonatomic) ListFilesViewController *listFilesViewController;
@property (strong, nonatomic) ListSecureViewController *listSecureViewController;
@property (strong, nonatomic) ListTodosViewController *listTodosViewController;

@property (nonatomic, strong) NSArray *viewControllers;

@property (strong, nonatomic) UIPageViewController *homePageViewController;

@property (weak, nonatomic) IBOutlet UIButton *tabLinks;
@property (weak, nonatomic) IBOutlet UIButton *tabShopping;
@property (weak, nonatomic) IBOutlet UIButton *tabNotes;
@property (weak, nonatomic) IBOutlet UIButton *tabImages;
@property (weak, nonatomic) IBOutlet UIButton *tabFiles;
@property (weak, nonatomic) IBOutlet UIButton *tabSecure;
@property (weak, nonatomic) IBOutlet UIButton *tabTodos;
@property (weak, nonatomic) IBOutlet UIImageView *tabSelected;

- (IBAction)onLinksTap:(id)sender;
- (IBAction)onShoppingTap:(id)sender;
- (IBAction)onNotesTap:(id)sender;
- (IBAction)onImagesTap:(id)sender;
- (IBAction)onFilesTap:(id)sender;
- (IBAction)onSecureTap:(id)sender;
- (IBAction)onTodosTap:(id)sender;

- (void)selectTab:(UIButton*)tab;

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.listLinksViewController = [[ListLinksViewController alloc] init];
        self.listShoppingViewController = [[ListShoppingViewController alloc] init];
        self.listNotesViewController = [[ListNotesViewController alloc] init];
        self.listImagesViewController = [[ListImagesViewController alloc] init];
        self.listFilesViewController = [[ListFilesViewController alloc] init];
        self.listSecureViewController = [[ListSecureViewController alloc] init];
        self.listTodosViewController = [[ListTodosViewController alloc] init];
        
        self.viewControllers = @[
                                 self.listLinksViewController,
                                 self.listShoppingViewController,
                                 self.listNotesViewController,
                                 self.listImagesViewController,
                                 self.listFilesViewController,
                                 self.listSecureViewController,
                                 self.listTodosViewController
                                 ];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tabScrollView.contentSize = CGSizeMake(500, 60);
    
    self.homePageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.homePageViewController.dataSource = self;
    self.homePageViewController.delegate = self;
    [self.homePageViewController setViewControllers:@[self.listLinksViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    self.listLinksViewController.view.frame = self.contentView.bounds;
    self.listShoppingViewController.view.frame = self.contentView.bounds;
    self.listNotesViewController.view.frame = self.contentView.bounds;
    self.listImagesViewController.view.frame = self.contentView.bounds;
    self.listFilesViewController.view.frame = self.contentView.bounds;
    self.listSecureViewController.view.frame = self.contentView.bounds;
    self.listTodosViewController.view.frame = self.contentView.bounds;
    
    self.homePageViewController.view.frame = self.contentView.bounds;
    
    [self.contentView addSubview:self.homePageViewController.view];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    int index = [self.viewControllers indexOfObject:viewController];
    
    if (index > 0) {
        return self.viewControllers[index - 1];
    }
    
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    int index = [self.viewControllers indexOfObject:viewController];
    
    if (index < (self.viewControllers.count - 1)) {
        return self.viewControllers[index + 1];
    }
    
    return nil;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed) {
        int index = [self.viewControllers indexOfObject:pageViewController.viewControllers[0]];
        NSArray *buttons = @[self.tabLinks, self.tabShopping, self.tabNotes, self.tabImages, self.tabFiles, self.tabSecure, self.tabTodos];
        //NSLog(@"index %d", index);
        [self selectTab:buttons[index] withViewController:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectTab:(UIButton *)tab withViewController:(UIViewController *)vc {
    
    CGPoint destScrollViewOffset = self.tabScrollView.contentOffset;
    int tabPageXPosition = tab.center.x - destScrollViewOffset.x;
    int selectedTabWidth = self.tabSelected.frame.size.width;
    // NSLog(@"%d", tabPageXPosition);
    
    // reposition the scroll view contents if the selected tab is beyond
    // the fold
    if (tabPageXPosition - (selectedTabWidth / 2) < 0) {
        destScrollViewOffset.x = 0;
    } else if (tabPageXPosition + (selectedTabWidth / 2) > 320) {
        destScrollViewOffset.x = 160;
    }
    
    // animate both the scrollview and the circle around the selected tab
    [UIView animateWithDuration:0.2 animations:^{
        self.tabSelected.center = CGPointMake(tab.center.x, tab.center.y);
        [self.tabScrollView setContentOffset:destScrollViewOffset animated:YES];
    }];
    
    if (vc) {
        // set the direction based on where the current tab's x-position relative to the target tab
        if (tab.center.x < self.tabSelected.center.x) {
            [self.homePageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
            
//            self.homePageViewController.dataSource = nil;
//            self.homePageViewController.dataSource = self;
            
        } else {
            [self.homePageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
            
            
//            self.homePageViewController.dataSource = nil;
//            self.homePageViewController.dataSource = self;
        }
    }
}

- (IBAction)onLinksTap:(id)sender {
    [self selectTab:self.tabLinks withViewController:self.listLinksViewController];
}

- (IBAction)onShoppingTap:(id)sender {
    [self selectTab:self.tabShopping withViewController:self.listShoppingViewController];
}

- (IBAction)onNotesTap:(id)sender {
    [self selectTab:self.tabNotes withViewController:self.listNotesViewController];
}

- (IBAction)onImagesTap:(id)sender {
    [self selectTab:self.tabImages withViewController:self.listImagesViewController];
}

- (IBAction)onFilesTap:(id)sender {
    [self selectTab:self.tabFiles withViewController:self.listFilesViewController];
}

- (IBAction)onSecureTap:(id)sender {
    [self selectTab:self.tabSecure withViewController:self.listSecureViewController];
}

- (IBAction)onTodosTap:(id)sender {
    [self selectTab:self.tabTodos withViewController:self.listTodosViewController];
}
@end
