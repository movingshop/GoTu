//
//  drawBoardViewController.m
//  GoTu
//
//  Created by vince.wang on 13-11-27.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#import "drawBoardViewController.h"
#import "drawingBoardView.h"
#import "colorViewController.h"
#import "UIImage+Tint.h"

#import "makeSaveViewController.h"

@interface drawBoardViewController ()

@end

@implementation drawBoardViewController
@synthesize editImage;

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
    
    [self setNeedsStatusBarAppearanceUpdate]; //去掉statusBar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // 判断是否为根 view
    isRootViewController = NO;
    if(self.navigationController.viewControllers.count == 1)
    {
        isRootViewController = YES;
        CGAffineTransform at =CGAffineTransformMakeRotation(-M_PI/2); //逆时针旋转90
        [backToBtn setTransform:at];
    }
    
    colorViewController *colorSilder = [[colorViewController alloc] init];
    colorSilder.myDelegate = self;
    [colorViewBox setBackgroundColor:[UIColor clearColor]];
    [self addChildViewController:colorSilder];
    [colorViewBox addSubview:colorSilder.view];
    [drawBoardV.backGroundImageView setImage:editImage];
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.maximumNumberOfTouches = 1;
    pan.minimumNumberOfTouches = 1;
    [colorV addGestureRecognizer:pan];
    UITapGestureRecognizer *pan1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [colorV addGestureRecognizer:pan1];
    
    colorV.userInteractionEnabled = YES;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    NSLog(@"colorChange:%d",pan.state);
    CGPoint p = [pan locationInView:colorV];
    p.x = p.x *2;
    p.y = p.y *2;
    [self changeColor:[self getPixelColorAtLocation:p]];
}

-(void)changeColor:(UIColor *)color
{
    NSLog(@"changeColor");
    [drawBoardV setBrushColor:color];
}

-(IBAction)changeBrush:(id)sender
{
    NSLog(@"changeBrush");
    UIButton *btn = (UIButton *)sender;
    int brushMode = btn.tag - 2000;
    [drawBoardV setBrushMode:brushMode];
    for (int i = 2000; i< 2004; i++) {
        UIButton *_btn = (UIButton *)[self.view viewWithTag:i];
        [_btn setSelected:NO];
    }
    [sender setSelected:YES];
    
//    [drawBoardV setBrushColor:color];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backTo:(id)sender
{
    if (isRootViewController) [self dismissViewControllerAnimated:YES completion:nil];
    else [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)toSave:(id)sender
{
    makeSaveViewController *makesaveVC = [[makeSaveViewController alloc] init];
    makesaveVC.saveImg = editImage;
    [self.navigationController pushViewController:makesaveVC animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (UIColor*) getPixelColorAtLocation:(CGPoint)point {
    UIColor* color = nil;
    
    
    
    CGImageRef inImage = colorV.image.CGImage;
    // Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
    CGContextRef cgctx = [self createARGBBitmapContextFromImage:inImage];
    if (cgctx == NULL) { return nil;  }
    
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = {{0,0},{w,h}};
    
    // Draw the image to the bitmap context. Once we draw, the memory
    // allocated for the context for rendering will then contain the
    // raw image data in the specified color space.
    CGContextDrawImage(cgctx, rect, inImage);
    
    // Now we can get a pointer to the image data associated with the bitmap
    // context.
    unsigned char* data = CGBitmapContextGetData (cgctx);
    if (data != NULL) {
        //offset locates the pixel in the data from x,y.
        //4 for 4 bytes of data per pixel, w is width of one row of data.
        @try {
            int offset = 4*((w*round(point.y))+round(point.x));
            NSLog(@"offset: %d", offset);
            int alpha =  data[offset];
            int red = data[offset+1];
            int green = data[offset+2];
            int blue = data[offset+3];
            NSLog(@"offset: %i colors: RGB A %i %i %i  %i",offset,red,green,blue,alpha);
            color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
        }
        @catch (NSException * e) {
            NSLog(@"%@",[e reason]);
        }
        @finally {
        }
        
    }
    // When finished, release the context
    CGContextRelease(cgctx);
    // Free image data memory for the context
    if (data) { free(data); }
    
    return color;
}

- (CGContextRef) createARGBBitmapContextFromImage:(CGImageRef) inImage {
    
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    int             bitmapByteCount;
    int             bitmapBytesPerRow;
    
    // Get image width, height. We'll use the entire image.
    size_t pixelsWide = CGImageGetWidth(inImage);
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * 4);
    bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
    {
        fprintf(stderr, "Error allocating color space\n");
        return NULL;
    }
    
    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    bitmapData = malloc( bitmapByteCount );
    if (bitmapData == NULL)
    {
        fprintf (stderr, "Memory not allocated!");
        CGColorSpaceRelease( colorSpace );
        return NULL;
    }
    
    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     kCGImageAlphaPremultipliedFirst);
    if (context == NULL)
    {
        free (bitmapData);
        fprintf (stderr, "Context not created!");
    }
    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );
    
    return context;
}




@end
