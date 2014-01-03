//
//  pushRefreshView.m
//  GoTu
//
//  Created by vince.wang on 14-1-3.
//  Copyright (c) 2014年 vince. All rights reserved.
//

#import "pushRefreshView.h"

@implementation pushRefreshView
@synthesize angle;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)didMoveToSuperview
{
    [self setBackgroundColor:[UIColor clearColor]];
    color= [UIColor colorWithPatternImage:[UIImage imageNamed:@"100"]];
    angle = 45;
    [self addObserver:self forKeyPath:@"angle" options:NSKeyValueObservingOptionNew context:nil];
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [object setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 //获得处理的上下文
     CGContextRef context = UIGraphicsGetCurrentContext();
 
 //设置颜色
// CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
//     CGContextSetFillColor(context, [UIColor colorWithRed:0.561 green:1.000 blue:0.808 alpha:1.000].CGColor);
     CGContextSetFillColorWithColor(context, color.CGColor);
     
     CGContextMoveToPoint(context, 25, 25);
     CGContextAddArc(context, 25, 25, 25, 0, -angle * M_PI / 180, 1);
     CGContextAddLineToPoint(context, 25, 25);
     
     CGContextFillPath(context);
//     CGContextStrokePath(context);
 }


@end
