//
//  pushRefreshViewController.m
//  GoTu
//
//  Created by vincy.vince on 13-12-29.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "pushRefreshViewController.h"
#import "pushRefreshView.h"

@interface pushRefreshViewController ()

@end

@implementation pushRefreshViewController
@synthesize delegate;

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
    [self setAnchorPointWidthView:headerV];
    [self setAnchorPointWidthView:headerImgV];
    isRefresh = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setAnchorPointWidthView:(UIView*)target
{
    CGRect _frame = target.frame;
    target.layer.anchorPoint = CGPointMake(0.5, 0.2);
    [target setFrame:_frame];
}



//接收处理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    tableV = (UITableView *)object;
    CGPoint _offSize_ = [tableV contentOffset];
    CGSize _size_ = [tableV contentSize];
    
    
    CGSize _offSizeMin = CGSizeMake(0, 100);
    
    if (_offSize_.y < 0)
    {
        CGFloat _r =  fabsf(_offSize_.y);
        _r = MIN(headerV.bounds.size.width, MAX(_r, 10));
        CGFloat scale = _r / headerV.bounds.size.width;
//        scale = MIN(1, MAX(scale, .5));
        CGFloat _offy = (fabsf(_offSize_.y) - _r) / 2;
        
        CGAffineTransform _transform = CGAffineTransformConcat(
                                                               CGAffineTransformMakeTranslation(0, _offy),
                                                               CGAffineTransformMakeScale(scale, scale)
                                                               );
        [headerV setTransform:_transform];
        [headerImgV setTransform:_transform];
        headerV.angle =fabsf(_offSize_.y) / 100 * 360;
        
        if (!isRefresh && headerV.angle >= 390.0f)
        {
            isRefresh = YES;
            [tableV setContentInset:UIEdgeInsetsMake(100, 0, 0, 0)];
            [delegate headerRefresh];
        }
        
//        [headerV setFrame:_frame];
//        [headerImgV setFrame:_frame];
        
//        [headerV setValue:(id)  forKey:@"angle"];
//        NSLog(@"header:%f",_r);
//        if (!tableV.isDragging  && _r > 120)
//        {
//            [tableV setContentInset:UIEdgeInsetsMake(100, 0, 0, 0)];
//            [delegate headerRefresh];
//        }
        
    }
    else if ((_size_.height -  _offSize_.y - tableV.frame.size.height) < 0)
    {
        CGFloat _r =  fabsf((_size_.height -  _offSize_.y - tableV.frame.size.height));
        CGRect _frame = CGRectMake((320 - _r) / 2, footerV.frame.size.height - _r, _r, _r);
        [footerV setFrame:_frame];
        [footerImgV setFrame:_frame];
        
//        NSLog(@"footer:%f",_r);
        if (!tableV.isDragging && _r > 120)
        {
            [tableV setContentInset:UIEdgeInsetsMake(0, 0, 100, 0)];
//            [delegate footerRefresh];
        }
        
    }
}

-(void)refreshOver
{
    NSLog(@"refreshOver");
    if (tableV)
    {
        [UIView animateWithDuration:.5 animations:^{
            [tableV setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        } completion:^(BOOL finished) {
            
        }];
        isRefresh = NO;
    }
    
}

@end
