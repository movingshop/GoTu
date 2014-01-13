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
#import "messageViewController.h"
#import "personViewController.h"
#import "makeViewController.h"
#import "CATransform3DPerspect.h"
#import "CAKeyframeAnimation+AHEasing.h"

@interface rootViewController ()
{
    UIButton *rootV0;
    UIButton *rootV1;
    UIButton *rootV2;
}

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
    [self customInit];
    
    
    
//    if (object == _sharedNetworkQueue && [keyPath isEqualToString:@"operationCount"]) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible =
//        ([_sharedNetworkQueue.operations count] = 0);
//    }
}

-(void)showBoxBtn
{
//    动画不完整
//    [boxBtn setHidden:!boxBtn.hidden];
//    if (!boxBtn.hidden) [boxBtn setAlpha:0];
//    [UIView animateWithDuration:1 animations:^{
//        if (!boxBtn.hidden) [boxBtn setAlpha:1];
//    }];
    
//    [boxBtn setFrame:self.view.bounds];
    if (isBoxBtnShow) {
        isBoxBtnShow = NO;
        int _index = 0;
        for (UIView *tempView in [boxBtn subviews]) {
            CGFloat delay = 0.05 * _index;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position" function:BackEaseOut fromPoint:CGPointMake(160,-22.5) toPoint:CGPointMake(160, tempView.layer.frame.origin.y + 22.5) delay:delay];
            animation.duration = .75;
            animation.beginTime = CACurrentMediaTime()+delay;
            animation.fillMode = kCAFillModeBoth;
            animation.removedOnCompletion = NO;
            
            [tempView.layer addAnimation:animation forKey:@"show"];
            _index ++;
        }
    }else{
        isBoxBtnShow = YES;
        int _index = 0;
        for (UIView *tempView in [boxBtn subviews]) {
            CGFloat delay = 0.05 * _index;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position" function:BackEaseIn  fromPoint:CGPointMake(160, tempView.layer.frame.origin.y + 22.5) toPoint:CGPointMake(160,-22.5) delay:delay];
            animation.duration = .75;
            animation.beginTime = CACurrentMediaTime()+delay;
            animation.fillMode = kCAFillModeBoth;
            animation.removedOnCompletion = NO;
            
            [tempView.layer addAnimation:animation forKey:@"hide"];
            _index ++;
        }
    }
    
    
    
    
}

-(void)showAllView
{
    NSLog(@"showAllView");
    [boxRootView setContentSize:CGSizeMake(320, boxRootView.frame.size.height + 20)];
    
    [UIView animateWithDuration:0.5f animations:^{
        [feedVC.view setFrame:boxRootView.bounds];
        [messageVC.view setFrame:boxRootView.bounds];
        [personVC.view setFrame:boxRootView.bounds];
        
        [rootV0 setHidden:NO];
        [rootV0 setAlpha:1];
        [rootV1 setHidden:NO];
        [rootV1 setAlpha:1];
        [rootV2 setHidden:NO];
        [rootV2 setAlpha:1];
        
        
        [feedVC.view setClipsToBounds:YES];
        [messageVC.view setClipsToBounds:YES];
        [personVC.view setClipsToBounds:YES];
        
        feedVC.view.layer.transform = [self makeTransformWithTop:10];
        [boxRootView addSubview:feedVC.view];
//        [feedVC.view setHidden:YES];
        messageVC.view.layer.transform = [self makeTransformWithTop:boxRootView.frame.size.height / 3 + 10];
        [boxRootView addSubview:messageVC.view];
//        [messageVC.view setHidden:YES];
        personVC.view.layer.transform = [self makeTransformWithTop:boxRootView.frame.size.height / 3 * 2 + 10];
        [boxRootView addSubview:personVC.view];
    } completion:^(BOOL finished) {
        [feedVC.view setNeedsDisplay];
        [messageVC.view setNeedsDisplay];
        [personVC.view setNeedsDisplay];
    }];
}

-(void)showViewWithTag:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [boxRootView setContentSize:boxRootView.frame.size];
    [UIView animateWithDuration:0.5f animations:^{
        
        feedVC.view.layer.transform = CATransform3DIdentity;
        messageVC.view.layer.transform = CATransform3DIdentity;
        personVC.view.layer.transform = CATransform3DIdentity;
        
        CGRect _frame = boxRootView.bounds;
        
        NSLog(@"btnTag:%i",btn.tag);
        switch (btn.tag) {
            case 0:
                [feedVC.view setFrame:_frame];
                _frame.origin.y = _frame.size.height;
                [messageVC.view setFrame:_frame];
                _frame.origin.y = _frame.size.height * 2;
                [personVC.view setFrame:_frame];
                
                break;
            case 1:
                _frame.origin.y = -_frame.size.height;
                [feedVC.view setFrame:_frame];
                _frame.origin.y = 0;
                [messageVC.view setFrame:_frame];
                _frame.origin.y = _frame.size.height;
                [personVC.view setFrame:_frame];
                
                break;
                
            case 2:
                _frame.origin.y = -_frame.size.height * 2;
                [feedVC.view setFrame:_frame];
                _frame.origin.y = -_frame.size.height;
                [messageVC.view setFrame:_frame];
                _frame.origin.y = 0;
                [personVC.view setFrame:_frame];
                break;
                
            default:
                break;
        }
        
        [rootV0 setHidden:YES];
        [rootV0 setAlpha:0];
        [rootV1 setHidden:YES];
        [rootV1 setAlpha:0];
        [rootV2 setHidden:YES];
        [rootV2 setAlpha:0];
    }];
}

-(CATransform3D)makeTransformWithTop:(CGFloat)top
{
    
    
    CATransform3D rotation = CATransform3DMakeRotation(-M_PI/5, 1, 0, 0);
    
    
    CATransform3D translation =CATransform3DMakeTranslation(0, top, -100);
    
    CATransform3D mat = CATransform3DConcat(rotation,translation);
    
    return CATransform3DPerspect(mat, CGPointMake(0, 0), 1000);
//    return translation;
}

-(void)setAnchorPointWidthView:(UIView*)target
{
    CGRect _frame = target.frame;
    target.layer.anchorPoint = CGPointMake(0.5, 0.2);
    [target setFrame:_frame];
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
    self.view.backgroundColor = bgColor;
    
    // topBar btn 初始化
    for (int i = 1; i<=2 ; i++) {
        UIButton *btn = (UIButton *)[boxTopbar viewWithTag:i];
        switch (i) {
            case 1:
                // 显示boxBtn
//                [btn addTarget:self action:@selector(showAllView) forControlEvents:UIControlEventTouchUpInside];
                [btn addTarget:self action:@selector(showBoxBtn) forControlEvents:UIControlEventTouchUpInside];
                isBoxBtnShow = NO;
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
//    [boxBtn setHidden:YES];
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
    
    
    //动画
    
    
    
    //rootViews init
    [boxRootView setScrollsToTop:NO];
    
    
    
    personVC =[[personViewController alloc] init];
//    [self addChildViewController:personVC];
    CGRect _frame = boxRootView.frame;
    _frame.origin.y = boxRootView.frame.size.height * 2;
    [personVC.view setFrame:_frame];
    [boxRootView addSubview:personVC.view];
    
    messageVC =[[messageViewController alloc] init];
    //    [self addChildViewController:messageVC];
    _frame = boxRootView.frame;
    _frame.origin.y = boxRootView.frame.size.height;
    [messageVC.view setFrame:_frame];
    [boxRootView addSubview:messageVC.view];
    
    feedVC =[[feedViewController alloc] init];
    [self addChildViewController:feedVC];
    _frame = boxRootView.frame;
    _frame.origin.y = 0;
    [feedVC.view setFrame:_frame];
    [boxRootView addSubview:feedVC.view];
    
    [self setAnchorPointWidthView:feedVC.view];
    [self setAnchorPointWidthView:messageVC.view];
    [self setAnchorPointWidthView:personVC.view];
    
    rootV0 = [[UIButton alloc] initWithFrame:self.view.bounds];
    rootV0.tag = 0;
    [rootV0 setImage:[UIImage imageNamed:@"tapBg"] forState:UIControlStateNormal];
    [feedVC.view addSubview:rootV0];
    [rootV0 setHidden:YES];
    [rootV0 setAlpha:0];
    
    [rootV0 addTarget:self action:@selector(showViewWithTag:) forControlEvents:UIControlEventTouchUpInside];
    
    rootV1 = [[UIButton alloc] initWithFrame:self.view.bounds];
    rootV1.tag = 1;
    [rootV1 setImage:[UIImage imageNamed:@"tapBg"] forState:UIControlStateNormal];
    [messageVC.view addSubview:rootV1];
    [rootV1 setHidden:YES];
    [rootV1 setAlpha:0];
    
    [rootV1 addTarget:self action:@selector(showViewWithTag:) forControlEvents:UIControlEventTouchUpInside];
    
    rootV2 = [[UIButton alloc] initWithFrame:self.view.bounds];
    rootV2.tag = 2;
    [rootV2 setImage:[UIImage imageNamed:@"tapBg"] forState:UIControlStateNormal];
    [personVC.view addSubview:rootV2];
    [rootV2 setHidden:YES];
    [rootV2 setAlpha:0];
    
    [rootV2 addTarget:self action:@selector(showViewWithTag:) forControlEvents:UIControlEventTouchUpInside];
    
}

@end
