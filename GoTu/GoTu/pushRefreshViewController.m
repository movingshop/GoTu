//
//  pushRefreshViewController.m
//  GoTu
//
//  Created by vincy.vince on 13-12-29.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "pushRefreshViewController.h"

@interface pushRefreshViewController ()

@end

@implementation pushRefreshViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//接收处理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    UITextView *mTrasView = object;
//    
//    CGFloat topCorrect = ([mTextbounds].size.height - [mTextcontentSize].height);
//    
//    topCorrect = (topCorrect <0.0 ?0.0 : topCorrect);
//    
//    mText.contentOffset = (CGPoint){.x =0, .y = -topCorrect/2};
    NSLog(@"movingshop:%@",keyPath);
    
}

@end
