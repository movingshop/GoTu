//
//  penButton.m
//  GoTu
//
//  Created by vince.wang on 14-1-10.
//  Copyright (c) 2014年 vince. All rights reserved.
//

#import "penButton.h"
#import "CAKeyframeAnimation+AHEasing.h"

@implementation penButton

@synthesize defaultImgV,selectedImgV;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        self.selected = NO;
        defaultImgV = (UIImageView *)[self viewWithTag:1];
        selectedImgV = (UIImageView *)[self viewWithTag:4];
        
        [self addSubview:selectedImgV];
        [self addSubview:defaultImgV];
        [self addObserver:self forKeyPath:@"selected" options:NSKeyValueObservingOptionNew context:nil];
        [self setAnchorPointWidthView:self];
        
        transformMin= CGAffineTransformMakeScale(.2, .2);
        transformMax = CGAffineTransformIdentity;
        
        sizeMax = self.frame.size;
        sizeMin = CGSizeMake(self.frame.size.width * .8, self.frame.size.height * .8);
        
        frameMax = self.frame;
        frameMin = CGRectMake(0, 0, 100, 100);
        
//        [self addTarget:self action:@selector(selectedShow) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

//-(void)selectedShow
//{
//    [self setSelected:!self.selected];
//}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.selected){
        [UIView animateWithDuration:.5 animations:^{
            
            [defaultImgV setAlpha:0];
//            [self setTransform:transformMax];
            
            
        }];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"bounds" function:BackEaseOut fromSize:self.layer.bounds.size toSize:sizeMax];
        animation.duration = 0.5;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [self.layer addAnimation:animation forKey:@"bounds"];
    }else{
        [UIView animateWithDuration:.5 animations:^{
            
            
            [defaultImgV setAlpha:1];
//            [self setTransform:transformMin];
        }];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"bounds" function:BackEaseOut fromSize:self.layer.bounds.size toSize:sizeMin];
        animation.duration = 0.5;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [self.layer addAnimation:animation forKey:@"bounds"];
    }
}

-(void)setAnchorPointWidthView:(UIView*)target
{
    
    CGRect _frame = target.frame;
    target.layer.anchorPoint = CGPointMake(.5, 1);
    [target setFrame:_frame];
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
