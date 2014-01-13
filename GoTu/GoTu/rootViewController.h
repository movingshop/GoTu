//
//  rootViewController.h
//  GoTu
//
//  Created by vince.wang on 13-11-26.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>

@class feedViewController;
@class personViewController;
@class messageViewController;

@interface rootViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIView *boxBtn;
    BOOL isBoxBtnShow;
    IBOutlet UIView *boxTopbar;
    IBOutlet UIScrollView *boxRootView;
    
    feedViewController *feedVC;
    messageViewController *messageVC;
    personViewController *personVC;;
}

@end
