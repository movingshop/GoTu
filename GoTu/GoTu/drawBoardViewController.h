//
//  drawBoardViewController.h
//  GoTu
//
//  Created by vince.wang on 13-11-27.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "colorViewController.h"

@class drawingBoardView;
@class penButton;

@interface drawBoardViewController : UIViewController<colorSelectDelegate>
{
    IBOutlet drawingBoardView *drawBoardV;
    IBOutlet UIView *colorViewBox;
    IBOutlet UIButton *backToBtn;
    IBOutlet UIView *colorCV;
    IBOutlet UIImageView *colorV;
    IBOutlet UIImageView *colorShowV;
    
    IBOutlet penButton *pen0;
    IBOutlet penButton *pen1;
    IBOutlet penButton *pen2;
    IBOutlet penButton *pen3;
    
    UIImage *pen_test;
    
    
    BOOL isRootViewController;
}
@property (strong,nonatomic) UIImage *editImage;

@end
