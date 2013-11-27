//
//  rootViewController.m
//  GoTu
//
//  Created by vince.wang on 13-11-26.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "rootViewController.h"
#import "drawingBoardView.h"

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
    
    drawingBoardView *drawV = [[drawingBoardView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:drawV];
//    [self.view setTransform:<#(CGAffineTransform)#>];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
