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

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *photos;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        NSURL *url = [NSURL URLWithString:@"https://api.instagram.com/v1/media/popular?access_token=1420818168.f59def8.31dc73aaaedc44d6801173d71a0c19fc"];
        
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
    
    //self.tableView.rowHeight = 270;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.photos.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *photoInfo = self.photos[section];
    NSInteger commentCount = [photoInfo[@"comments"][@"count"] intValue];
    NSLog(@"%d", commentCount);
    return MIN(commentCount, 4);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *photoInfo = self.photos[indexPath.section];
    NSString *url = photoInfo[@"images"][@"standard_resolution"][@"url"];
    NSDictionary *commentInfo = photoInfo[@"comments"][@"data"][indexPath.row];
    
    NSString *commentUser = commentInfo[@"from"][@"username"];
    NSString *commentText = commentInfo[@"text"];
    
    if (indexPath.row == 0) {
        PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoCell"];
        [cell.photoView setImageWithURL:[NSURL URLWithString:url]];
        return cell;
    } else {
        CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        cell.usernameLabel.text = commentUser;
        cell.commentLabel.text = commentText;
        return cell;
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSDictionary *photoInfo = self.photos[section];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    headerView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 13, 250, 30)];
    headerLabel.font = [UIFont boldSystemFontOfSize:16];
    headerLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    headerLabel.text = photoInfo[@"user"][@"username"];
    
    NSString *userPhotoUrl = photoInfo[@"user"][@"profile_picture"];
    UIImageView *userPhotoView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    userPhotoView.layer.cornerRadius = 20.0;
    [userPhotoView setClipsToBounds:YES];
    [userPhotoView setImageWithURL:[NSURL URLWithString:userPhotoUrl]];
    
    
    [headerView addSubview:headerLabel];
    [headerView addSubview:userPhotoView];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 270;
    } else {
        return 65;
    }
}


@end
