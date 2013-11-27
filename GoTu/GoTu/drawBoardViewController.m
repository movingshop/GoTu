//
//  drawBoardViewController.m
//  GoTu
//
//  Created by vince.wang on 13-11-27.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "drawBoardViewController.h"
#import "drawingBoardView.h"
#import "colorViewController.h"

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
    [self addChildViewController:colorSilder];
    [colorViewBox addSubview:colorSilder.view];
    [colorSilder.view setFrame:CGRectMake(0, 0, 160, 160)];
    
    [drawBoardV.backGroundImageView setImage:[UIImage imageNamed:@"001"]];
    
    // Do any additional setup after loading the view from its nib.
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
