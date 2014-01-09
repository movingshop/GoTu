//
//  makeViewController.m
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "makeViewController.h"
#import "drawBoardViewController.h"
#import "drawingBoardView.h"
#import "customImagePiclerController.h"

@interface makeViewController ()

@end

@implementation makeViewController

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
    [self customInit];
    
//    [self.view addSubview:showCameraBtn];
    // Do any additional setup after loading the view from its nib.
}

-(void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)changeCamera
{
    if (imagePC.cameraDevice ==UIImagePickerControllerCameraDeviceRear ) {
        imagePC.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }else {
        imagePC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
    
    CATransition *  tran=[CATransition animation];
    tran.type = @"oglFlip";
    tran.subtype = kCATransitionFromTop;
    tran.timingFunction=UIViewAnimationCurveEaseInOut;
    tran.duration= 1.0;
    [imagePC.view.layer addAnimation:tran forKey:@"swapCamera"];
}

-(void)swapFlashMode
{
    if (imagePC.cameraFlashMode == 1)
    {
        imagePC.cameraFlashMode = -1;
        [cameraFlashModeBtn setSelected:YES];
    }else {
        imagePC.cameraFlashMode = 1;
        [cameraFlashModeBtn setSelected:NO];
    }
}

-(void)showAlum
{
    
    [showAlumbBtn setHidden:YES];
    
    [imagePC setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    //
    //[imagePC.navigationBar addSubview:showCameraBtn];
    NSLog(@"%@",imagePC.navigationBar);
//    [imagePC.navigationBar.topItem.rightBarButtonItem setTitle:@"自定义" ];
    
    CATransition *  tran=[CATransition animation];
    tran.type = kCATransitionPush;
    tran.subtype = kCATransitionFromRight;
//    tran.duration= .5;
    tran.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [imagePC.view.layer addAnimation:tran forKey:@"swapCamera"];
}

-(void)showCamera
{
    [showAlumbBtn setHidden:NO];
    [imagePC setSourceType:UIImagePickerControllerSourceTypeCamera];
    
    CATransition *  tran=[CATransition animation];
    tran.type = kCATransitionPush;
    tran.subtype = kCATransitionFromLeft;
    //    tran.duration= .5;
    tran.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [imagePC.view.layer addAnimation:tran forKey:@"swapCamera"];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
//    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
//    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
//    {
//        //如果是 来自照相机的image，那么先保存
//        NSLog(@"图片来自于相机");
//        // Save the image to the album
//        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//        
//        
//    }
    
    
//    获得编辑过的图片
    UIImage *image = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    drawBoardViewController *drawBoardVC = [[drawBoardViewController alloc] init];
    drawBoardVC.editImage = image;
    [self.navigationController pushViewController:drawBoardVC animated:YES];
    NSLog(@"进入编辑模式");
//    [self dismissModalViewControllerAnimated:YES];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
{
    // Handle the end of the image write process
    if (!error) NSLog(@"Image written to photo album");
    else NSLog(@"Error writing to photo album: %@", [error localizedDescription]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}



-(void)customInit
{
    
    //初始化相机
    imagePC = [[customImagePiclerController alloc] init];
    imagePC.delegate = self;
    imagePC.allowsEditing = YES;
    
//    [imagePC.navigationBar addSubview:showCameraBtn];
    [showCameraBtn setHidden:YES];
    [showCameraBtn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    
    [imagePC setSourceType:UIImagePickerControllerSourceTypeCamera]; //相机模式
    [imagePC setCameraFlashMode:-1]; //默认关闭闪光灯
    
//    imagePC.showsCameraControls = NO;
//    imagePC.cameraOverlayView = customCameraView;
    [customCameraView setHidden:YES];
    
    [self addChildViewController:imagePC];
    [imagePC.view setFrame:customCameraView.frame];
    [self.view insertSubview:imagePC.view atIndex:0];
    
    
    
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside]; //关闭
    
    [changeCameraBtn addTarget:imagePC action:@selector(swapCamera) forControlEvents:UIControlEventTouchUpInside]; // swap 前后摄像头
    [takePhotoBtn addTarget:imagePC action:@selector(savePhoto) forControlEvents:UIControlEventTouchUpInside]; // 拍照
    
    [cameraFlashModeBtn setSelected:YES];
    [cameraFlashModeBtn addTarget:self action:@selector(swapFlashMode) forControlEvents:UIControlEventTouchUpInside]; //闪光灯
    
    [showAlumbBtn addTarget:self action:@selector(showAlum) forControlEvents:UIControlEventTouchUpInside];
}

-(void)test
{
//    NSLog(@"viewNum:%i",[imagePC._PLCameraView.subviews count]);
//    for (UIView *_view in imagePC._PLCameraView.subviews) {
//        NSLog(@"_view:%@",_view);
//        NSLog(@"_viewNum:%i",[_view.subviews count]);
//        for (UIView *_view0 in _view.subviews) {
//            NSLog(@"_view0:%@",_view0);
//            NSLog(@"_view0Num:%i",[_view0.subviews count]);
//            for (UIView *_view1 in _view0.subviews) {
//                NSLog(@"_view1:%@",_view1);
//            }
//        }
//    }
//    [closeBtn sendActionsForControlEvents:UIControlEventTouchUpInside];｀
    [imagePC.swapCameraBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
