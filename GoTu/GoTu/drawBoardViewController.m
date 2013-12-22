//
//  drawBoardViewController.m
//  GoTu
//
//  Created by vince.wang on 13-11-27.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#import "drawBoardViewController.h"
#import "drawingBoardView.h"
#import "colorViewController.h"
#import "UIImage+Tint.h"

@interface drawBoardViewController ()

@end

@implementation drawBoardViewController

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
    
    colorViewController *colorSilder = [[colorViewController alloc] init];
    colorSilder.myDelegate = self;
    [colorViewBox setBackgroundColor:[UIColor clearColor]];
    [self addChildViewController:colorSilder];
    [colorViewBox addSubview:colorSilder.view];
    [drawBoardV.backGroundImageView setImage:[UIImage imageNamed:@"001"]];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)changeColor:(UIColor *)color
{
    NSLog(@"changeColor");
    [drawBoardV setBrushColor:color];
}

-(IBAction)changeBrush:(id)sender
{
    NSLog(@"changeBrush");
    UIButton *btn = (UIButton *)sender;
    int brushMode = btn.tag - 2000;
    [drawBoardV setBrushMode:brushMode];
//    [drawBoardV setBrushColor:color];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backTo:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
