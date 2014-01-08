//
//  customImagePiclerController.h
//  GoTu
//
//  Created by vince.wang on 14-1-8.
//  Copyright (c) 2014年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customImagePiclerController : UIImagePickerController
{
    
}

@property (strong,nonatomic) UIButton *saveBtn;

@property (strong,nonatomic) UIView *topBar;

@property (strong,nonatomic) UIButton *swapCameraBtn;

@property (strong,nonatomic) UIButton *CAMFlipButton;

@property (strong,nonatomic) UIView *PLCameraView;

-(void)swapCamera;

@end
