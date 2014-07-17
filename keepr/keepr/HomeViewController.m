//
//  HomeViewController.m
//  keepr
//
//  Created by Brian Kobashikawa on 7/7/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIView *chromeView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (weak, nonatomic) IBOutlet UIButton *tabAll;
@property (weak, nonatomic) IBOutlet UIButton *tabLinks;
@property (weak, nonatomic) IBOutlet UIButton *tabNotes;
@property (weak, nonatomic) IBOutlet UIButton *tabImages;
@property (weak, nonatomic) IBOutlet UIButton *tabTodos;
@property (weak, nonatomic) IBOutlet UIButton *tabMore;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenuMail;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenuSettings;

@property (nonatomic, strong) NSArray *tabs;
@property (nonatomic, strong) NSArray *cards;
@property (nonatomic, strong) NSMutableArray *cardOffsets;
@property (nonatomic, strong) NSMutableArray *cardViews;

@property (nonatomic) int selectedCardId;
@property (nonatomic, strong) UIImageView *selectedCard;
@property (nonatomic) CGPoint selectedCardOriginalPosition;
@property (nonatomic) BOOL cardLifted;

@property (nonatomic) int chromeHeight;

- (IBAction)onTabAll:(id)sender;
- (IBAction)onTabLinks:(id)sender;
- (IBAction)onTabNotes:(id)sender;
- (IBAction)onTabImages:(id)sender;
- (IBAction)onTabTodos:(id)sender;
- (IBAction)onTabMore:(id)sender;

- (void) deselectTabsWithAnimation:(BOOL)isAnimated;

@end

@implementation HomeViewController

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
    
    self.tabs = @[
                  self.tabAll,
                  self.tabLinks,
                  self.tabNotes,
                  self.tabImages,
                  self.tabTodos,
                  self.tabMore
                  ];
    self.cards = @[
                   @{ @"image" :    @"z3_Todo",
                      @"height" :   @"310",
                      @"type":      @"todo" },
                   @{ @"image" :    @"z2_Note",
                      @"height" :   @"390",
                      @"type":      @"note" },
                   @{ @"image" :    @"z1_Link2",
                      @"height" :   @"349",
                      @"type":      @"link" },
                   @{ @"image" :    @"0712_Photo",
                      @"height" :   @"385",
                      @"type":      @"photo" },
                   @{ @"image" :    @"0712_Link",
                      @"height" :   @"365",
                      @"type":      @"link" },
                   @{ @"image" :    @"0707_Link",
                      @"height" :   @"330",
                      @"type":      @"link" },
                   @{ @"image" :    @"0706_Photo",
                      @"height" :   @"424",
                      @"type":      @"photo" },
                   @{ @"image" :    @"0703_Note",
                      @"height" :   @"330",
                      @"type":      @"note" },
                   @{ @"image" :    @"0629_Link",
                      @"height" :   @"367",
                      @"type":      @"link" },
                   @{ @"image" :    @"0619_Photo",
                      @"height" :   @"182",
                      @"type":      @"photo" },
                   @{ @"image" :    @"0608_Photo",
                      @"height" :   @"424",
                      @"type":      @"photo" },
                   @{ @"image" :    @"0607_Todo",
                      @"height" :   @"292",
                      @"type":      @"todo" },
                   @{ @"image" :    @"0601_Photo",
                      @"height" :   @"221",
                      @"type":      @"photo" },
                   @{ @"image" :    @"0517_Todo",
                      @"height" :   @"379",
                      @"type":      @"todo" },
                   @{ @"image" :    @"0510_Photo",
                      @"height" :   @"323",
                      @"type":      @"photo" },
                   @{ @"image" :    @"0510_Note",
                      @"height" :   @"263",
                      @"type":      @"note" },
                   @{ @"image" :    @"0406_Photo",
                      @"height" :   @"424",
                      @"type":      @"photo" },
                   @{ @"image" :    @"0403_Link",
                      @"height" :   @"378",
                      @"type":      @"link" },
                   @{ @"image" :    @"0402_Photo",
                      @"height" :   @"424",
                      @"type":      @"photo" },
                   @{ @"image" :    @"0401_Todo",
                      @"height" :   @"383",
                      @"type":      @"todo" },
                   @{ @"image" :    @"0330_Photo",
                      @"height" :   @"424",
                      @"type":      @"photo" },
                   @{ @"image" :    @"0330_Link",
                      @"height" :   @"346",
                      @"type":      @"link" },
                   @{ @"image" :    @"0319_Link",
                      @"height" :   @"346",
                      @"type":      @"link" },
                   @{ @"image" :    @"0220_Link",
                      @"height" :   @"301",
                      @"type":      @"link" },
                   @{ @"image" :    @"0203_Note",
                      @"height" :   @"120",
                      @"type":      @"note" },
                   @{ @"image" :    @"0103_Note",
                      @"height" :   @"138",
                      @"type":      @"note" },
                   @{ @"image" :    @"12262013_Todo",
                      @"height" :   @"292",
                      @"type":      @"todo" },
                   @{ @"image" :    @"10012013_Note",
                      @"height" :   @"138",
                      @"type" :     @"note" },
                   @{ @"image" :    @"09132013_Note",
                      @"height" :   @"209",
                      @"type" :     @"note"}
                   ];
    self.cardViews = [NSMutableArray array];
    self.cardOffsets = [NSMutableArray array];
    
    self.chromeHeight = 176;
    
    self.contentScrollView.alwaysBounceVertical = YES;
    [self.contentScrollView setDelegate:self];
    
    [self deselectTabsWithAnimation:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [self selectTab:self.tabAll];
    [self populateTab:@"all"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTabAll:(id)sender {
    [self selectTab:self.tabAll];
    [self populateTab:@"all"];
}

- (IBAction)onTabLinks:(id)sender {
    [self selectTab:self.tabLinks];
    [self populateTab:@"link"];
}

- (IBAction)onTabNotes:(id)sender {
    [self selectTab:self.tabNotes];
    [self populateTab:@"note"];
}

- (IBAction)onTabImages:(id)sender {
    [self selectTab:self.tabImages];
    [self populateTab:@"photo"];
}

- (IBAction)onTabTodos:(id)sender {
    [self selectTab:self.tabTodos];
    [self populateTab:@"todo"];
}

- (IBAction)onTabMore:(id)sender {
    // [self selectTab:self.tabMore];
    // no more menu yet
}

- (void) deselectTabsWithAnimation:(BOOL)isAnimated {
    for (int i = 0; i < self.tabs.count; i++) {
        UIButton *button = self.tabs[i];
        CGFloat duration = 0;
        CGFloat scale = 0.75;
        if (isAnimated) {
            duration = 0.25;
        }
        [UIView animateWithDuration:duration animations:^{
            button.alpha = 0.5;
            button.transform = CGAffineTransformMakeScale(scale, scale);
        }];
    }
}

- (void) selectTab:(UIButton *)tab {
    [self deselectTabsWithAnimation:YES];
    [UIView animateWithDuration:0.25 animations:^{
        tab.alpha = 1;
        tab.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void) populateTab:(NSString *)tab {
    // clear all the arrays and subviews out
    [self.cardViews removeAllObjects];
    [self.cardOffsets removeAllObjects];
    for (UIView *subview in [self.contentScrollView subviews]) {
        [subview removeFromSuperview];
    }
    
    // populate with cards
    int height = 0;
    int y = self.chromeHeight;
    int totalCards = 0;
    int count = 0;
    
    // only show the most recent 5 cards if the user selects "all"
    if ([tab isEqualToString:@"all"]) {
        totalCards = 5;
    } else {
        totalCards = self.cards.count;
    }
    
    // loop through all the cards. if the user did not select "all",
    // only the ones that have a matching "type" property will be
    // added to the stack.
    for (int i = 0; i < totalCards; i++) {
        if ([tab isEqualToString:@"all"] || [tab isEqualToString:self.cards[i][@"type"]]) {
            
            height = [self.cards[i][@"height"] intValue];
            
            // generate a new imageview
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 600, 320, height)];
            imageView.alpha = 0;
            [imageView setImage:[UIImage imageNamed:self.cards[i][@"image"]]];
            [imageView setUserInteractionEnabled:YES];
            
            // add pan gesture recognizer to all these cards
            UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onCustomPan:)];
            [panGestureRecognizer setDelegate:self];
            [imageView addGestureRecognizer:panGestureRecognizer];
            
            // update mutablearrays with the matching card.
            // self.cardOffsets will store all the heights for the currently
            // visible cards, so that we'll be able to pinpoint the card's
            // location later on (in the pangesturerecognizer).
            [self.cardViews addObject:imageView];
            [self.cardOffsets addObject:[NSNumber numberWithInt:height]];
            
            [self.contentScrollView addSubview:self.cardViews[count]];
            [self.contentScrollView sendSubviewToBack:self.cardViews[count]];
            
            // update the y-position so the next card will stack underneath
            y = y + height;
            count++;
        }
    }
    
    // add more stuff on the bottom?
    
    // update the contentsize so all the content fits
    [self.contentScrollView setContentSize:CGSizeMake(320, y)];
    
    // scroll to the top when the user switches tabs
    [UIView animateWithDuration:0.2 animations:^{
        self.contentScrollView.contentOffset = CGPointMake(0, 0);
    }];
    [self resetCardPositions];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat frameOffsetY = MIN(scrollView.contentOffset.y, 50);
    CGFloat frameAlpha = ((50 - frameOffsetY) / 1000) + .9;
    CGFloat buttonAlpha = (50 - frameOffsetY) / 50;
    CGFloat chromeShade = (frameOffsetY - 50) / 1000 + 1;
    //NSLog(@"%f", buttonAlpha);
    
    // move the chrome based on content position
    self.chromeView.frame = CGRectMake(0, 0 - frameOffsetY, 320, self.chromeHeight);
    
    // fade out the chrome
    self.chromeView.backgroundColor = [UIColor colorWithRed:chromeShade green:chromeShade blue:chromeShade alpha:frameAlpha];
    self.buttonMenuMail.alpha = buttonAlpha;
    self.buttonMenuSettings.alpha = buttonAlpha;
}

- (void)onCustomPan:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint translation = [panGestureRecognizer translationInView:self.view];
    CGPoint point = [panGestureRecognizer locationInView:self.view];
    CGPoint velocity = [panGestureRecognizer velocityInView:self.view];
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Gesture began at: %@", NSStringFromCGPoint(point));
        
        // figure out which card the user tapped, then store it so that
        // we know who to manipulate in the changed and ended states
        self.selectedCardId = [self getCardAtYPosition:point.y];
        self.selectedCard = self.cardViews[self.selectedCardId];
        self.selectedCardOriginalPosition = self.selectedCard.frame.origin;

    } else if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        //NSLog(@"Gesture changed: %@", NSStringFromCGPoint(point));
        
        // move the card around based on simple translation
        // but require a little bit of "give" before the user can drag
        // left/right - since they might be scrolling
        if (!self.cardLifted && (translation.x > 20 || translation.x < -20)) {
            self.cardLifted = YES;
            [UIView animateWithDuration:0.2 animations:^{
                self.selectedCard.frame = CGRectMake(self.selectedCardOriginalPosition.x + translation.x, self.selectedCardOriginalPosition.y, self.selectedCard.frame.size.width, self.selectedCard.frame.size.height);
            }];
        } else if (self.cardLifted) {
            self.selectedCard.frame = CGRectMake(self.selectedCardOriginalPosition.x + translation.x, self.selectedCardOriginalPosition.y, self.selectedCard.frame.size.width, self.selectedCard.frame.size.height);
        }
        
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"Gesture ended: %@", NSStringFromCGPoint(point));
        
        // if the user angrily swiped, then push the card out of the way
        //NSLog(@"velocity %@", NSStringFromCGPoint(velocity));
        
        self.cardLifted = NO;
        
        int offsetX;
        if (velocity.x > 1000) {
            offsetX = 320;
        } else if (velocity.x < -1000) {
            offsetX = -320;
        } else {
            offsetX = 0;
        }
        [UIView animateWithDuration:0.2 animations:^{
            self.selectedCard.frame = CGRectMake(offsetX, self.selectedCardOriginalPosition.y, self.selectedCard.frame.size.width, self.selectedCard.frame.size.height);
        } completion:^(BOOL finished) {
            // once offscreen, remove the card from the mutablearrays.
            // then reset the card positions, which should know that that
            // card is now missing.
            if (offsetX != 0) {
                [self.cardOffsets removeObjectAtIndex:self.selectedCardId];
                [self.cardViews removeObjectAtIndex:self.selectedCardId];
                [self resetCardPositions];
            }
        }];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES; //otherGestureRecognizer is your custom pan gesture
}

- (int)getCardAtYPosition:(CGFloat)yPos {
    
    // probably not a good way to figure out which card is being tapped on.
    // it's using a combination of the scrollview content offset and the
    // location of the scrollview to figure this out. it would get very
    // imprecise pretty quickly.
    int card = 0;
    int cardHeight = 0;
    int yOffset = self.chromeHeight - self.contentScrollView.contentOffset.y + self.contentScrollView.frame.origin.y;
    for (int i = 0; i < self.cardOffsets.count; i++) {
        cardHeight = [self.cardOffsets[i] intValue];
        //NSLog(@"%d", cardHeight);
        yOffset = yOffset + cardHeight;
        if (yPos < yOffset) {
            card = i;
            break;
        }
    }
    //NSLog(@"%d", card);
    return card;
}

- (void)resetCardPositions {
    
    // once a card has been deleted, reset the card positions with a
    // smooth animation.
    int y = self.chromeHeight;
    int height = 0;
    UIImageView *card;
    for (int i = 0; i < self.cardViews.count; i++) {
        card = self.cardViews[i];
        height = [self.cardOffsets[i] intValue];
        [UIView animateWithDuration:0.3 animations:^{
            card.frame = CGRectMake(0, y, 320, height);
            card.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
        y = y + height;
    }
    
    // also animate the contentsize of the scrollview once everything has
    // been rearranged.
    [UIView animateWithDuration:0.3 delay:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentScrollView.contentSize = CGSizeMake(320, y);
    } completion:^(BOOL finished) {
        // done
    }];
    
}


@end
