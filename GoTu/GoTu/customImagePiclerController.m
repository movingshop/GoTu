//
//  customImagePiclerController.m
//  GoTu
//
//  Created by vince.wang on 14-1-8.
//  Copyright (c) 2014年 vince. All rights reserved.
//

#import "customImagePiclerController.h"

@interface customImagePiclerController ()

@end

@implementation customImagePiclerController

@synthesize swapCameraBtn,PLCameraView,CAMFlipButton,topBar;

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
    
	// Do any additional setup after loading the view.
}

-(void)swapCamera
{
    self.showsCameraControls = YES;
    PLCameraView=[self findsubView:self.view withName:@"PLCameraView"];
    swapCameraBtn = (UIButton *)[self findsubView:PLCameraView withName:@"CAMFlipButton"];
    if (swapCameraBtn) {
        [swapCameraBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    self.showsCameraControls = NO;
}

-(void)savePhoto
{
    self.showsCameraControls = YES;
    PLCameraView=[self findsubView:self.view withName:@"PLCameraView"];
    UIButton *savePhotoBtn = [self findsubView:PLCameraView withName:@"CAMShutterButton"];
    if (savePhotoBtn) {
        [savePhotoBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
//    self.showsCameraControls = NO;
    [self.cameraOverlayView setHidden:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Add the motion view here, PLCameraView and picker.view are both OK
    
//    [PLCameraView setHidden:YES];
//    topBar = [self findsubView:PLCameraView withName:@"CAMTopBar"];
//    self.showsCameraControls = YES;
    PLCameraView=[self findsubView:self.view withName:@"PLCameraView"];
    UIView *bottomBar = [self findsubView:PLCameraView withName:@"PLCropOverlayBottomBar"];
    NSLog(@"Num:%i",[PLCameraView.subviews count]);
    for (UIView *_view in PLCameraView.subviews) {
        NSLog(@"   _view:%@",_view);
//        NSLog(@"   _viewNum:%i",[_view.subviews count]);
        for (UIView *_view0 in _view.subviews) {
            NSLog(@"      _view0:%@",_view0);
//            [_view0 setFrame:CGRectMake(0, 0, 10, 10)];
//            NSLog(@"_view0Num:%i",[_view0.subviews count]);
            for (UIView *_view1 in _view0.subviews) {
                NSLog(@"         _view1:%@",_view1);
            }
        }
    }

//    UIImageView *bottomBarImageForSave = [bottomBar.subviews objectAtIndex:0];
//    UIImageView *bottomBarImageForSave = [bottomBar.subviews objectAtIndex:0];
//    NSLog(@"%@",bottomBarImageForSave);
//    [bottomBarImageForSave setHidden:YES];
    
    
//    UIImageView *bottomBarImageForCamera = [bottomBar.subviews objectAtIndex:1];
//    UIButton *cameraButton=[bottomBarImageForCamera.subviews objectAtIndex:0];
    
    
    
//    [swapCameraBtn setHidden:YES];
    //Get Bottom Bar
    
    
    //Get Top Bar
//    UIView *topBar

//    //Get ImageView For Save
    
//    NSLog(@"bottomBarImageForSave:%@",bottomBarImageForSave);
//
//    
//    //Get ImageView For Camera
//    UIImageView *bottomBarImageForCamera = [bottomBar.subviews objectAtIndex:1];
//    
//    //Get Button 0 (The Capture Action)
//    UIButton *CaptureButton=[bottomBarImageForCamera.subviews objectAtIndex:0];
//    CaptureButton addTarget:<#(id)#> action:<#(SEL)#> forControlEvents:(UIControlEvents)];
//    
//    
//    //Get Button 1 (The cancel Action)
//    UIButton *cancelButton=[bottomBarImageForCamera.subviews objectAtIndex:1];
//    cancelButton.hidden = YES;
}

-(UIView *)findsubView:(UIView *)aView withName:(NSString *)name{
    Class cl = [aView class];
    NSString *desc = [cl description];
    
    if ([name isEqualToString:desc]) return aView;
    
    for (NSUInteger i = 0; i < [aView.subviews count]; i++)
    {
        UIView *subView = [aView.subviews objectAtIndex:i];
        subView = [self findsubView:subView withName:name];
        if (subView) return subView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
