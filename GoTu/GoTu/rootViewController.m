//
//  rootViewController.m
//  GoTu
//
//  Created by vince.wang on 13-11-26.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "rootViewController.h"
#import "drawBoardViewController.h"

@interface rootViewController ()

@end

@implementation rootViewController

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
//    [self.view setFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width * 2, [[UIScreen mainScreen] bounds].size.height * 2)];
    
    
//    [self.view setTransform:(CGAffineTransform)];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)showDrawV:(id)sender
{
    drawBoardViewController *drawV = [[drawBoardViewController alloc] init];
    drawV.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:drawV animated:YES completion:nil];
//    [UIView beginAnimations:@"animationID" context:nil];
//    [UIView setAnimationDuration:0.7];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:drawV.view cache:YES];
//    
//    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
