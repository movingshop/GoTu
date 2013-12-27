//
//  makeSaveViewController.m
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "makeSaveViewController.h"

@interface makeSaveViewController ()

@end

@implementation makeSaveViewController

@synthesize saveImg;

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
    
    [self customInit];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)backTo
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)save
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)customInit
{
    [self setNeedsStatusBarAppearanceUpdate];
    [imageV setImage:saveImg]; //需要保存的图片 预览图
    
    [backToBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside]; //关闭
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside]; //保存
    
    [scrollV setContentSize:CGSizeMake(320, 360 + 90)];
    
}



- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
