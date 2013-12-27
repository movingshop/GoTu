//
//  rootViewController.m
//  GoTu
//
//  Created by vince.wang on 13-11-26.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "rootViewController.h"
#import "drawBoardViewController.h"
#import "feedViewController.h"
#import "makeViewController.h"
#import "dataBasicTool.h"

@interface rootViewController ()

@end

@implementation rootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [dataBasicTool sharedTool];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customInit];
}

-(void)showBoxBtn
{
    // 动画不完整
    [boxBtn setHidden:!boxBtn.hidden];
    if (!boxBtn.hidden) [boxBtn setAlpha:0];
    [UIView animateWithDuration:1 animations:^{
        if (!boxBtn.hidden) [boxBtn setAlpha:1];
    }];
}

-(void)toFeed
{
    
}

-(void)toPerfeed
{
    
}

-(void)toMessage
{
    
}


-(void)toMake
{
    makeViewController *makeVC = [[makeViewController alloc] init];
    UINavigationController *makeNavVC = [[UINavigationController alloc] initWithRootViewController:makeVC];
    makeNavVC.navigationBarHidden = YES;
    [self presentViewController:makeNavVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)customInit
{
    // topBar btn 初始化
    for (int i = 1; i<=2 ; i++) {
        UIButton *btn = (UIButton *)[boxTopbar viewWithTag:i];
        switch (i) {
            case 1:
                // 显示boxBtn
                [btn addTarget:self action:@selector(showBoxBtn) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                //前往Make界面
                [btn addTarget:self action:@selector(toMake) forControlEvents:UIControlEventTouchUpInside];
                break;
            default:
                break;
        }
        
    }
    
    // 发现 消息 我的 切换按钮
    [boxBtn setHidden:YES];
    for (int i = 1; i<=2 ; i++) {
        UIButton *btn = (UIButton *)[boxBtn viewWithTag:i];
        switch (i) {
            case 1:
                // 发现
                [btn addTarget:self action:@selector(toFeed) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                //我的
                [btn addTarget:self action:@selector(toPerfeed) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 3:
                //消息
                [btn addTarget:self action:@selector(toMessage) forControlEvents:UIControlEventTouchUpInside];
                break;
            default:
                break;
        }
        
    }
    
    //rootViews init
    
    feedVC =[[feedViewController alloc] init];
    [self addChildViewController:feedVC];
    CGRect _frame = boxRootView.frame;
    _frame.origin.y = 0;
    [feedVC.view setFrame:_frame];
    [boxRootView addSubview:feedVC.view];
    
    
}

@end
