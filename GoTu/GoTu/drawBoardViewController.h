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

@interface drawBoardViewController : UIViewController<colorSelectDelegate>
{
    IBOutlet drawingBoardView *drawBoardV;
    IBOutlet UIView *colorViewBox;
    IBOutlet UIButton *backToBtn;
    IBOutlet UIImageView *colorV;
    
    
    BOOL isRootViewController;
}
@property (strong,nonatomic) UIImage *editImage;

@end
