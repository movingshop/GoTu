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

#import "makeSaveViewController.h"

@interface drawBoardViewController ()

@end

@implementation drawBoardViewController
@synthesize editImage;

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
    
    [self setNeedsStatusBarAppearanceUpdate]; //去掉statusBar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // 判断是否为根 view
    isRootViewController = NO;
    if(self.navigationController.viewControllers.count == 1)
    {
        isRootViewController = YES;
        CGAffineTransform at =CGAffineTransformMakeRotation(-M_PI/2); //逆时针旋转90
        [backToBtn setTransform:at];
    }
    
    colorViewController *colorSilder = [[colorViewController alloc] init];
    colorSilder.myDelegate = self;
    [colorViewBox setBackgroundColor:[UIColor clearColor]];
    [self addChildViewController:colorSilder];
    [colorViewBox addSubview:colorSilder.view];
    [drawBoardV.backGroundImageView setImage:editImage];
    
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
    if (isRootViewController) [self dismissViewControllerAnimated:YES completion:nil];
    else [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)toSave:(id)sender
{
    makeSaveViewController *makesaveVC = [[makeSaveViewController alloc] init];
    makesaveVC.saveImg = editImage;
    [self.navigationController pushViewController:makesaveVC animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}



@end
