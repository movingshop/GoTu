//
//  drawBoardViewController.h
//  GoTu
//
//  Created by vince.wang on 13-11-27.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>

@class drawingBoardView;

@interface drawBoardViewController : UIViewController
{
    IBOutlet drawingBoardView *drawBoardV;
    IBOutlet UIView *colorViewBox;
}


@end
