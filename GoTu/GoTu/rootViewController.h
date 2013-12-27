//
//  rootViewController.h
//  GoTu
//
//  Created by vince.wang on 13-11-26.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>

@class feedViewController;

@interface rootViewController : UIViewController
{
    IBOutlet UIView *boxBtn;
    IBOutlet UIView *boxTopbar;
    IBOutlet UIView *boxRootView;
    
    feedViewController *feedVC;
}

@end
