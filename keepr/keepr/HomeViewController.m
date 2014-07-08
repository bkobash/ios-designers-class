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

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *tabScrollView;

@property (strong, nonatomic) ListLinksViewController *listLinksViewController;
@property (strong, nonatomic) ListShoppingViewController *listShoppingViewController;

//@property (strong, nonatomic) UIPageViewController *homePageViewController;

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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tabScrollView.contentSize = CGSizeMake(500, 60);

    // failed attempt at PageViewController...
    
//    self.homePageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
//    self.homePageViewController.dataSource = self;
//    [self.homePageViewController setViewControllers:@[self.listLinksViewController, self.listLinksViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
//    [[self.homePageViewController view] setFrame:CGRectMake(0, 200, 320, 300)];
    
    self.listLinksViewController.view.frame = self.contentView.frame;
    self.listShoppingViewController.view.frame = self.contentView.frame;
    
    [self.contentView addSubview:self.listLinksViewController.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)selectTab:(UIButton *)tab {
    [UIView animateWithDuration:0.2 animations:^{
        self.tabSelected.center = CGPointMake(tab.center.x, tab.center.y);
    }];
}

- (IBAction)onLinksTap:(id)sender {
    [self selectTab:self.tabLinks];
    [self.contentView addSubview:self.listLinksViewController.view];
}

- (IBAction)onShoppingTap:(id)sender {
    [self selectTab:self.tabShopping];
    [self.contentView addSubview:self.listShoppingViewController.view];
}

- (IBAction)onNotesTap:(id)sender {
    [self selectTab:self.tabNotes];
}

- (IBAction)onImagesTap:(id)sender {
    [self selectTab:self.tabImages];
}

- (IBAction)onFilesTap:(id)sender {
    [self selectTab:self.tabFiles];
}

- (IBAction)onSecureTap:(id)sender {
    [self selectTab:self.tabSecure];
}

- (IBAction)onTodosTap:(id)sender {
    [self selectTab:self.tabTodos];
}
@end
