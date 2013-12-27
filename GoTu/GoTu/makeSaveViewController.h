//
//  makeSaveViewController.h
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface makeSaveViewController : UIViewController
{
    IBOutlet UIImageView *imageV;
    IBOutlet UIScrollView *scrollV;
    
    IBOutlet UIButton *backToBtn;
    IBOutlet UIButton *saveBtn;
}

@property (strong,nonatomic) UIImage *saveImg;

@end
