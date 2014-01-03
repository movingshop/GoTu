//
//  feedBottomCell.m
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "feedBottomCell.h"
#import "UzysRadialProgressActivityIndicator.h"

@implementation feedBottomCell
@synthesize data,delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(void)didMoveToSuperview
{
    [self addObserver:self forKeyPath:@"data" options:NSKeyValueObservingOptionNew context:nil];
    [picB setContentMode:UIViewContentModeScaleAspectFit];
    [picB.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [picB addTarget:self action:@selector(showImage) forControlEvents:UIControlEventTouchUpInside];
}

-(void)showImage
{
//    [picB ]
    [delegate showContentWithData:data];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (data)
    {
        [avatarB setImageWithURL:[data objectForKey:@"avatar"] forState:UIControlStateNormal ];
        [picB setImageWithURL:[[data objectForKey:@"image"] objectForKey:@"url"] forState:UIControlStateNormal];
        [self setNeedsDisplay];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
