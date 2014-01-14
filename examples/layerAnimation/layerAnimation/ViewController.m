//
//  ViewController.m
//  layerAnimation
//
//  Created by vince.wang on 14-1-14.
//  Copyright (c) 2014年 vince. All rights reserved.
//

#import "ViewController.h"
#import "CAKeyframeAnimation+AHEasing.h"

@interface ViewController ()

@end

@implementation ViewController

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
    [self setAnchorPointWidthView:view0];
//    view0.layer.speed = 0;
    [self reverse];
    // Do any additional setup after loading the view from its nib.
}

-(void)reverse
{
//    NSLog(@"%@",[view0.layer timeOffset);
//    view0.layer.timeOffset = .3;
    CGRect _frame = view0.frame;
    CGRect _toFrame = view0.frame;
    _toFrame.size.height = 300;
    _toFrame.size.width = 300;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale" function:BackEaseOut fromValue:1 toValue:2];
    
    animation.duration = 2.0;
    animation.fillMode = kCAFillModeBoth;
    
    [view0.layer addAnimation:animation forKey:@"position"];
    
}

-(void)setAnchorPointWidthView:(UIView*)target
{
    CGRect _frame = target.frame;
    target.layer.anchorPoint = CGPointMake(.5, 1);
    [target setFrame:_frame];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self reverse];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
