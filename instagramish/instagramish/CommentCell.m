//
//  CommentCell.m
//  instagramish
//
//  Created by Brian Kobashikawa on 7/11/14.
//  Copyright (c) 2014 Brian Kobashikawa. All rights reserved.
//

#import "CommentCell.h"

@implementation CommentCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse {
    [super prepareForReuse];
    for(UIView *subview in [self.contentView subviews]) {
        [subview removeFromSuperview];
    }
}

@end
