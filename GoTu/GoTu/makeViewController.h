//
//  makeViewController.h
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface makeViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UIImagePickerController *imagePC;
    
    IBOutlet UIView *customCameraView;
    IBOutlet UIButton *closeBtn;
    IBOutlet UIButton *takePhotoBtn;
    IBOutlet UIButton *changeCameraBtn;
    IBOutlet UIButton *cameraFlashModeBtn;
    IBOutlet UIButton *showAlumbBtn;
    IBOutlet UIButton *showCameraBtn;
}

@end
