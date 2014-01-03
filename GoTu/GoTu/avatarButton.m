//
//  avatarButton.m
//  GoTu
//
//  Created by vince.wang on 13-12-31.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "avatarButton.h"

@implementation avatarButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //圆形头像
        
        
    }
    return self;
}

-(void)didMoveToSuperview
{
    [self setClipsToBounds:YES];
    [self.layer setCornerRadius:self.frame.size.height/2];
    [self.layer setBorderWidth:1.5f];
    [self.layer setBorderColor:[UIColor whiteColor].CGColor];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
