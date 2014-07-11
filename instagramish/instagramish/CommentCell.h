//
//  CommentCell.h
//  instagramish
//
//  Created by Brian Kobashikawa on 7/11/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@end
