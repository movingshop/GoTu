//
//  penButton.h
//  GoTu
//
//  Created by vince.wang on 14-1-10.
//  Copyright (c) 2014年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface penButton : UIControl
{
    CGAffineTransform transformMin;
    CGAffineTransform transformMax;
    
    CGSize sizeMin;
    CGSize sizeMax;
    
    CGRect frameMin;
    CGRect frameMax;
    
}

@property (strong,nonatomic) UIImageView *defaultImgV;
@property (strong,nonatomic) UIImageView *selectedImgV;

@end
