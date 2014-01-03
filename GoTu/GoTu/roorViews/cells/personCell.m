//
//  personCell.m
//  GoTu
//
//  Created by vince.wang on 13-12-31.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "personCell.h"

@implementation personCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
