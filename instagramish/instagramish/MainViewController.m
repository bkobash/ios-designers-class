//
//  MainViewController.m
//  instagramish
//
//  Created by Brian Kobashikawa on 7/11/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "MainViewController.h"
#import "PhotoCell.h"
#import "CommentCell.h"
#import "UIImageView+AFNetworking.h"
#import "TTTAttributedLabel.h"


@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *photos;

- (TTTAttributedLabel *)commentLabelWithText:(NSString *)comment withUsername:(NSString *)username;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?client_id=be9c77c3f005406093ec83d72e35a6c5"];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            self.photos = object[@"data"];
            [self.tableView reloadData];
        }];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"PhotoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"PhotoCell"];
    
    UINib *commentNib = [UINib nibWithNibName:@"CommentCell" bundle:nil];
    [self.tableView registerNib:commentNib forCellReuseIdentifier:@"CommentCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.tableView.rowHeight = 270;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// each section represents a photo
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.photos.count;
}

// for each section, show at least 1 row (for the photo), then allocate
// at most 3 more rows for comments
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *photoInfo = self.photos[section];
    NSInteger commentCount = [photoInfo[@"comments"][@"count"] intValue];
    //NSLog(@"Comment count: %d", commentCount);
    return MIN(commentCount + 1, 4);
}

// for each row, set the 1st row to a photo cell. set the remaining rows as
// comment cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *photoInfo = self.photos[indexPath.section];
    NSString *url = photoInfo[@"images"][@"standard_resolution"][@"url"];

    if (indexPath.row == 0) {
        PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
        [cell.photoView setImageWithURL:[NSURL URLWithString:url]];
        return cell;
    } else {
        NSDictionary *commentInfo = photoInfo[@"comments"][@"data"][indexPath.row - 1];
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        
        TTTAttributedLabel *commentLabel = [self commentLabelWithText:commentInfo[@"text"] withUsername:commentInfo[@"from"][@"username"]];
        
        [cell.commentView addSubview:commentLabel];
        
        return cell;
    }
}

// create a comment label. it's a standalone method because I'm calling it
// twice - first to calculate the row height, then to actually attach it
// to the cell's subview
- (TTTAttributedLabel *)commentLabelWithText:(NSString *)comment withUsername:(NSString *)username {
    
    NSString *commentText = [NSString stringWithFormat:@"%@  %@", username, comment];
    
    TTTAttributedLabel *commentLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(20, 5, 280, 100)];
    commentLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    commentLabel.font = [UIFont systemFontOfSize:14];
    commentLabel.textColor = [UIColor darkGrayColor];
    commentLabel.numberOfLines = 0;
    commentLabel.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    
    [commentLabel setText:commentText afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
        NSRange boldRange = [[mutableAttributedString string] rangeOfString:username options:NSCaseInsensitiveSearch];
        UIFont *boldSystemFont = [UIFont boldSystemFontOfSize:14];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
            CFRelease(font);
        }
        
        return mutableAttributedString;
    }];
    
    return commentLabel;
}

// set the height for the rows
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *photoInfo = self.photos[indexPath.section];
    NSInteger commentCount = [photoInfo[@"comments"][@"count"] intValue];
    NSInteger totalRows = MIN(commentCount + 1, 4);
    NSInteger verticalPadding = 10;
    
    if (indexPath.row == 0) {
        // it's a photo - return a static height
        return 270;
    } else {
        // it's a comment - calculate the height in a dummy view, and
        // then return it with some vertical padding
        NSDictionary *commentInfo = photoInfo[@"comments"][@"data"][indexPath.row - 1];
        TTTAttributedLabel *commentLabel = [self commentLabelWithText:commentInfo[@"text"] withUsername:commentInfo[@"from"][@"username"]];
        
        CGSize commentSize = [commentLabel sizeThatFits:CGSizeMake(280, CGFLOAT_MAX)];
        //NSLog(@"Comment height: %f", commentSize.height);
        
        // add some extra space on the bottom if it's the last comment
        if (indexPath.row == totalRows - 1) {
            verticalPadding = 30;
        }
        return commentSize.height + verticalPadding;
    }
}

// set up the header to show the photo's owner in a custom programmatically
// created view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSDictionary *photoInfo = self.photos[section];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    headerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    
    // add the username
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 14, 250, 30)];
    headerLabel.font = [UIFont boldSystemFontOfSize:16];
    headerLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    headerLabel.text = photoInfo[@"user"][@"username"];
    
    // add the user photo (in a circle)
    NSString *userPhotoUrl = photoInfo[@"user"][@"profile_picture"];
    UIImageView *userPhotoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    userPhotoView.layer.cornerRadius = 20.0;
    [userPhotoView setClipsToBounds:YES];
    [userPhotoView setImageWithURL:[NSURL URLWithString:userPhotoUrl]];
    
    // add a little rule on bottom
    UIView *headerRule = [[UIView alloc] initWithFrame:CGRectMake(0, 59, 320, 1)];
    headerRule.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    
    [headerView addSubview:headerLabel];
    [headerView addSubview:headerRule];
    [headerView addSubview:userPhotoView];
    
    return headerView;
}

// set the height for the section header
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 60;
}



@end
