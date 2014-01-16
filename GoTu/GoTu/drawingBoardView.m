//
//  drawingBoardView.m
//  drawingBoard
//
//  Created by vincy.vince on 13-11-4.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#define RGB(r, g, b)             [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a)     [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#define brushWidthMax 1;
#define brushWidthMin .1;

#define MRScreenWidth      CGRectGetWidth([UIScreen mainScreen].applicationFrame)
#define MRScreenHeight     CGRectGetHeight([UIScreen mainScreen].applicationFrame)

#import "drawingBoardView.h"
#import "CGPointExtension.h"
#import "UIImage+Tint.h"

@implementation drawingBoardView

@synthesize backGroundImageView;

@synthesize brushColor,brushMode;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Initialization code
        //        self.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
        self.delegate = self;
        [self initWithCustom];
    }
    return self;
}

-(void)initWithCustom
{
    [self setBrushColor:[UIColor whiteColor]];
    
    
    
//    [self setClipsToBounds:YES];
    
    self.panGestureRecognizer.maximumNumberOfTouches = 2;
    self.panGestureRecognizer.minimumNumberOfTouches = 2;
    
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    
    drawBoardV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 640, 640)];
    [self addSubview:drawBoardV];
    
    
//    [self setZoomScale:.];
//    [self zoomToRect:CGRectMake(0, 0, 320, 320) animated:YES];
//    [self setMaximumZoomScale:2];
    
    backGroundImageView = [[UIImageView alloc] initWithFrame:drawBoardV.frame];
    [drawBoardV addSubview:backGroundImageView];
//    backGroundImageView.userInteractionEnabled = YES;
    
    brushColor = HexRGBAlpha(0xff0000, 1.0f);
    strokeColor = HexRGBAlpha(0x000000,1.0f);
    clearColor = [UIColor clearColor];
    isCelar = NO;
    
    drawingBoardImg = [[UIImageView alloc] initWithFrame:drawBoardV.frame];
    [drawBoardV addSubview:drawingBoardImg];
    
    path = [[UIBezierPath alloc] init];
    path1 = [[UIBezierPath alloc] init];
    path2 = [[UIBezierPath alloc] init];
    actionArray = [[NSMutableArray alloc] init];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.maximumNumberOfTouches = 1;
    pan.minimumNumberOfTouches = 1;
    [self addGestureRecognizer:pan];
    
//    UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan2:)];
//    pan2.maximumNumberOfTouches = 2;
//    pan2.minimumNumberOfTouches = 2;
//    
//    [self addGestureRecognizer:pan2];
//    
//    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
//    [self addGestureRecognizer:pinch];
    
//    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
//    [doubleTapGesture setNumberOfTapsRequired:2];
//    [self addGestureRecognizer:doubleTapGesture];
    
    CGPoint _p0 = CGPointMake(0, 0);
    CGPoint _p1 = CGPointMake(1, 1);
    CGPoint _p10 = [self triangle:_p0 p1:_p1 w:1];
    NSLog(@"%@",NSStringFromCGPoint(_p10));
    
    strokeWidth =0.10f;
    
//    zoomScale = 1.0f;
    
    //画笔类型
    // 0 为 橡皮
    // 1 为 钢笔
    // 2 为 铅笔
    brush2Points = [NSMutableArray array];
    // 3 为 马克笔
    brushMode = 1; //默认是 1；
    brush3PointA0 = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    brush3PointA1 = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0", nil];
    
    
    
    float minimumScale = self.frame.size.width / drawBoardV.frame.size.width;
    [self setMinimumZoomScale:minimumScale];
    [self setZoomScale:minimumScale];
    [self setMaximumZoomScale:3];
    
}


- (void)pan:(UIPanGestureRecognizer *)pan {
    
    p1 = [pan locationInView:drawBoardV];
    CGPoint vp = [pan velocityInView:self];
//    vp.x = vp.x * self.zoomScale;
//    vp.y = vp.y * self.zoomScale;
    CGFloat strokeWidthExpect = ccpLength(vp); //预期画笔宽度
    strokeWidthExpect *= 1 / self.zoomScale;
    
    NSMutableArray *brushA = [NSMutableArray array];
    
    
    switch (brushMode) {
        case 1:
            // brushMode = 1 钢笔模式
            
            // 速度与画笔宽度关系
            strokeWidthExpect = powf(MIN(1, (strokeWidthExpect / 1000)), 2);
            strokeWidthExpect = strokeWidthExpect * 10;
            CGFloat _scale = powf(2 * (10 - strokeWidthExpect), .5) ;
            _scale = _scale * 0.05;
            strokeWidth += (strokeWidthExpect - strokeWidth) *0.05;
            
            
            
            //画笔计算
            if (pan.state == UIGestureRecognizerStateBegan) {
                path = [[UIBezierPath alloc] init];
                [path moveToPoint:p1];
                
                action = [[NSMutableDictionary alloc] init];
                [action setObject:@"brush" forKey:@"mode"];
                [action setObject:@"0x000fff" forKey:@"color"];
                NSMutableArray *_path0 = [NSMutableArray arrayWithObjects:NSStringFromCGPoint(p1), nil];
                NSMutableArray *_ctrol0 = [NSMutableArray arrayWithObjects:NSStringFromCGPoint(p1), nil];
                NSMutableArray *_path1 = [NSMutableArray arrayWithObjects:NSStringFromCGPoint(p1), nil];
                NSMutableArray *_ctrol1 = [NSMutableArray arrayWithObjects:NSStringFromCGPoint(p1), nil];
                
                
                [action setObject:[NSMutableArray arrayWithObjects:_path0,_ctrol0,_path1,_ctrol1, nil] forKey:@"path"];
                
                
                path0 = [[UIBezierPath alloc] init];
                
                p00.x = -1000.0f;
                _mp10 = p1;
                _mp11 = p1;
                
                strokeWidth = 0.1f;
                
                [path moveToPoint:p1];
                
            }
            else if (pan.state == UIGestureRecognizerStateChanged){
                
                
                [path0 removeAllPoints];
                
                //p10 mp10 p11 mp11
                CGFloat w = strokeWidth;
                
                
                
                mP1 = midPoint(p0, p1);
                
                CGPoint p10 = [self triangle:p0 p1:p1 w:w];
                CGPoint p11 = [self triangle:p0 p1:p1 w:-w];
                CGPoint mp10 = [self triangle:mP0 p1:mP1 w:w];
                CGPoint mp11 = [self triangle:mP0 p1:mP1 w:-w];
                
                NSMutableArray *_pathA = [action objectForKey:@"path"];
                
                NSMutableArray *_path0 = [_pathA objectAtIndex:0];
                NSMutableArray *_ctrol0 = [_pathA objectAtIndex:1];
                NSMutableArray *_path1 = [_pathA objectAtIndex:2];
                NSMutableArray *_ctrol1 = [_pathA objectAtIndex:3];
                
                [_path0 addObject:NSStringFromCGPoint(mp10)];
                [_ctrol0 addObject:NSStringFromCGPoint(p10)];
                [_path1 addObject:NSStringFromCGPoint(mp11)];
                [_ctrol1 addObject:NSStringFromCGPoint(p11)];
                
                if (ccpDistance(p1, p0) < w) return;
                if (p00.x==-1000.0f){
                    
                    //            [path0 addLineToPoint:p10];
                    //            [path1 addLineToPoint:p11];
                }
                else{
                    [path0 moveToPoint:_mp10];
                    [path0 addQuadCurveToPoint:mp10 controlPoint:p00];
                    [path0 addLineToPoint:_mp11];
                    [path0 addLineToPoint:_mp10];
                    
                    [path0 moveToPoint:_mp11];
                    [path0 addQuadCurveToPoint:mp11 controlPoint:p01];
                    [path0 addLineToPoint:mp10];
                    [path0 addLineToPoint:_mp11];
                }
                
                [path addLineToPoint:p1];
                p00 = p10;
                p01 = p11;
                _mp10 = mp10;
                _mp11 = mp11;
                
                [path1 removeAllPoints];
                [path1 addArcWithCenter:mP1 radius:strokeWidth startAngle:0 endAngle:M_PI * 2 clockwise:YES];
                
                //        [path0 removeAllPoints];
                
            }
            else if (pan.state == UIGestureRecognizerStateEnded) {
                
                [path0 removeAllPoints];
                
                //p10 mp10 p11 mp11
                strokeWidth *= 1 / self.zoomScale;
                CGFloat w = strokeWidth;
                
                
                
                mP1 = midPoint(p0, p1);
                
                CGPoint p10 = [self triangle:p0 p1:p1 w:w];
                CGPoint p11 = [self triangle:p0 p1:p1 w:-w];
                CGPoint mp10 = [self triangle:mP0 p1:mP1 w:w];
                CGPoint mp11 = [self triangle:mP0 p1:mP1 w:-w];
                
                NSMutableArray *_pathA = [action objectForKey:@"path"];
                
                NSMutableArray *_path0 = [_pathA objectAtIndex:0];
                NSMutableArray *_ctrol0 = [_pathA objectAtIndex:1];
                NSMutableArray *_path1 = [_pathA objectAtIndex:2];
                NSMutableArray *_ctrol1 = [_pathA objectAtIndex:3];
                
                [_path0 addObject:NSStringFromCGPoint(mp10)];
                [_ctrol0 addObject:NSStringFromCGPoint(p10)];
                [_path1 addObject:NSStringFromCGPoint(mp11)];
                [_ctrol1 addObject:NSStringFromCGPoint(p11)];
                
                if (ccpDistance(p1, p0) < w) return;
                
                [path0 moveToPoint:_mp10];
                [path0 addQuadCurveToPoint:mp10 controlPoint:p00];
                [path0 addLineToPoint:_mp11];
                [path0 addLineToPoint:_mp10];
                
                [path0 moveToPoint:_mp11];
                [path0 addQuadCurveToPoint:mp11 controlPoint:p01];
                [path0 addLineToPoint:mp10];
                [path0 addLineToPoint:_mp11];
                
                [path1 removeAllPoints];
                [path1 addArcWithCenter:mP1 radius:strokeWidth startAngle:0 endAngle:M_PI * 2 clockwise:YES];
                //        [path1 addLineToPoint:mP1];
                
            }
            mP0 = mP1;
            p0 = p1;
            
            
            
            break;
        case 2:
            // brushMode = 2 铅笔模式
            
            // 速度与画笔宽度关系
            strokeWidth = 5.0f * 1 / self.zoomScale;
            
            
            
            //画笔计算
            if (pan.state == UIGestureRecognizerStateBegan) {
//                path0 = [[UIBezierPath alloc] init];
//                [path0 setLineWidth:strokeWidth];
                mP1 = p1;
                p0=p1;
                mP0 = mP1;
//                [path0 moveToPoint:p1];
            }else if (pan.state == UIGestureRecognizerStateChanged){
                
//                [path0 removeAllPoints];
                mP1 = midPoint(p0, p1);
                
//                mP0, p0, mp1;
//                [path0 removeAllPoints];
//                path0 = [UIBezierPath bezierPathWithRect:CGRectMake(mP1.x, mP1.y, 500, 500)];
                [brush2Points removeAllObjects];
                for (CGFloat t = 0; t <=1; t+=0.01)
                {
                    //二次Bz曲线的公式
                    CGFloat x = (1 - t) * (1 - t) * mP0.x + 2 * t * (1 - t) * p0.x + t * t * mP1.x;
                    CGFloat y = (1 - t) * (1 - t) * mP0.y + 2 * t * (1 - t) * p0.y + t * t * mP1.y;
                    [brush2Points addObject:NSStringFromCGPoint(CGPointMake(x, y))];
                }
//                [path0 moveToPoint:mP0];
//                [path0 addQuadCurveToPoint:mP1 controlPoint:p0];
                
            }else if (pan.state == UIGestureRecognizerStateEnded){
//                [path0 addLineToPoint:p1];
            }
            
            p0 = p1;
            mP0 = mP1;
           
            
            break;
        case 3:
            // brushMode = 3 马克笔模式
            
            // 速度与画笔宽度关系
            strokeWidth = 20.0f;
            
            //画笔计算
            CGFloat w = strokeWidth * .5;
            CGFloat h = strokeWidth;
            
            if (ccpDistance(p1, p0) < h && pan.state != UIGestureRecognizerStateBegan) return;
            if (pan.state == UIGestureRecognizerStateBegan) p0 = p1;
            
            
            mP1 = midPoint(p0, p1);
            
            CGPoint _mP1 = CGPointMake(mP1.x, mP1.y);
            _mP1.y = mP1.y + 5;
            _mP1.x = mP1.x + 20;
            CGPoint mp0 = [self triangle:_mP1 p1:mP1 w:-h];
            CGPoint mp1 = [self triangle:_mP1 p1:mP1 w:h];
//            NSLog(@"mp0:%@",NSStringFromCGPoint(mp0));
//            NSLog(@"mp1:%@",NSStringFromCGPoint(mp1));
            
            CGPoint p10 = CGPointMake(mp0.x - w,mp0.y);
            CGPoint p11 = CGPointMake(mp0.x + w,mp0.y);
            CGPoint p12 = CGPointMake(mp1.x + w,mp1.y);
            CGPoint p13 = CGPointMake(mp1.x - w,mp1.y);
            [brush3PointA1 replaceObjectAtIndex:0 withObject:NSStringFromCGPoint(p10)];
            [brush3PointA1 replaceObjectAtIndex:1 withObject:NSStringFromCGPoint(p11)];
            [brush3PointA1 replaceObjectAtIndex:2 withObject:NSStringFromCGPoint(p12)];
            [brush3PointA1 replaceObjectAtIndex:3 withObject:NSStringFromCGPoint(p13)];
            
            if (pan.state == UIGestureRecognizerStateBegan) {
                p0 = p1;
            }
            
            
            CGPoint _cmP0 = CGPointMake(p0.x, p0.y);
            _cmP0.y = _cmP0.y + 5;
            _cmP0.x = _cmP0.x + 20;
            CGPoint cmp0 = [self triangle:_cmP0 p1:p0 w:-h];
            CGPoint cmp1 = [self triangle:_cmP0 p1:p0 w:h];
            CGPoint controlP0;
            CGPoint controlP1;
            
            
            if (pan.state == UIGestureRecognizerStateBegan) {
                
                brushA = [NSMutableArray arrayWithObjects:
                          NSStringFromCGPoint(p10),
                          NSStringFromCGPoint(p11),
                          NSStringFromCGPoint(p13),
                          NSStringFromCGPoint(p12),
                          nil];
                
            }else{
                
                
                
                CGFloat angleBrush = atan2f(5, 20);
                
                CGFloat anglePoint =atan2f(mP1.y - mP0.y, mP1.x - mP0.x);
                
                NSLog(@"angleBrush:%f   anglePoint:%f",angleBrush,anglePoint);
                
                
                
                
                if (anglePoint <= 0)
                {
                    angleBrush -= M_PI_2;
                    if (anglePoint > angleBrush) {
                        brushA = [NSMutableArray arrayWithObjects:
                                  [brush3PointA0 objectAtIndex:3] ,
                                  [brush3PointA0 objectAtIndex:0] ,
                                  [brush3PointA0 objectAtIndex:2] ,
                                  [brush3PointA1 objectAtIndex:0] ,
                                  [brush3PointA1 objectAtIndex:2] ,
                                  [brush3PointA1 objectAtIndex:1] ,
                                  nil];
                        controlP0 = CGPointMake(cmp0.x - w,cmp0.y);
                        controlP1 = CGPointMake(cmp1.x + w,cmp1.y);
                        
                    }
                    else
                    {
                        
                        brushA = [NSMutableArray arrayWithObjects:
                                  [brush3PointA0 objectAtIndex:2] ,
                                  [brush3PointA0 objectAtIndex:1] ,
                                  [brush3PointA0 objectAtIndex:3] ,
                                  [brush3PointA1 objectAtIndex:1] ,
                                  [brush3PointA1 objectAtIndex:3] ,
                                  [brush3PointA1 objectAtIndex:0] ,
                                  nil];
//                        brushA = [NSMutableArray array];
                        controlP0 = CGPointMake(cmp0.x + w,cmp0.y);
                        controlP1 = CGPointMake(cmp1.x - w,cmp1.y);
                    }
                    
                }
                else
                {
                    angleBrush += M_PI_2;
                    if (anglePoint <= angleBrush) {
                        brushA = [NSMutableArray arrayWithObjects:
                                  [brush3PointA0 objectAtIndex:0] ,
                                  [brush3PointA0 objectAtIndex:1] ,
                                  [brush3PointA0 objectAtIndex:3] ,
                                  [brush3PointA1 objectAtIndex:1] ,
                                  [brush3PointA1 objectAtIndex:3] ,
                                  [brush3PointA1 objectAtIndex:2] ,
                                  nil];
                        controlP0 = CGPointMake(cmp0.x + w,cmp0.y);
                        controlP1 = CGPointMake(cmp1.x - w,cmp1.y);
                    }
                    else
                    {
                        brushA = [NSMutableArray arrayWithObjects:
                                  [brush3PointA0 objectAtIndex:1] ,
                                  [brush3PointA0 objectAtIndex:0] ,
                                  [brush3PointA0 objectAtIndex:2] ,
                                  [brush3PointA1 objectAtIndex:0] ,
                                  [brush3PointA1 objectAtIndex:2] ,
                                  [brush3PointA1 objectAtIndex:3] ,
                                  nil];
                        controlP0 = CGPointMake(cmp0.x - w,cmp0.y);
                        controlP1 = CGPointMake(cmp1.x + w,cmp1.y);
                    }
                }
//                brushA = [NSMutableArray array];
//                NSLog(@"angleBrush:%f   anglePoint:%f",angleBrush,anglePoint);
                

            }
            
            [brush3PointA0 replaceObjectAtIndex:0 withObject:NSStringFromCGPoint(p10)];
            [brush3PointA0 replaceObjectAtIndex:1 withObject:NSStringFromCGPoint(p11)];
            [brush3PointA0 replaceObjectAtIndex:2 withObject:NSStringFromCGPoint(p12)];
            [brush3PointA0 replaceObjectAtIndex:3 withObject:NSStringFromCGPoint(p13)];
            
            [path0 removeAllPoints];
            for (int i = 0; i < [brushA count] - 2; i++) {
                [path0 moveToPoint:CGPointFromString([brushA objectAtIndex:i])];
                if ([brushA count] > 4) {
                    if (i == 1 || i == 2) {
                        [path0 addLineToPoint:CGPointFromString([brushA objectAtIndex:i+1])];
                        [path0 addLineToPoint:CGPointFromString([brushA objectAtIndex:i+2])];
                        if (i == 1)[path0 addQuadCurveToPoint:CGPointFromString([brushA objectAtIndex:i]) controlPoint:controlP0];
                        if (i == 2)[path0 addQuadCurveToPoint:CGPointFromString([brushA objectAtIndex:i]) controlPoint:controlP1];
                    }else{
                        [path0 addLineToPoint:CGPointFromString([brushA objectAtIndex:i+1])];
                        [path0 addLineToPoint:CGPointFromString([brushA objectAtIndex:i+2])];
                        [path0 addLineToPoint:CGPointFromString([brushA objectAtIndex:i])];
                    }
                    
                }
                else
                {
                    [path0 addLineToPoint:CGPointFromString([brushA objectAtIndex:i+1])];
                    [path0 addLineToPoint:CGPointFromString([brushA objectAtIndex:i+2])];
                    [path0 addLineToPoint:CGPointFromString([brushA objectAtIndex:i])];
                }
                
            }
            mP0 = mP1;
            p0 = p1;
            
            break;
        case 0:
            // brushMode = 0 橡皮模式
            
            strokeWidth = 8.0f;
            
            //画笔计算
            if (pan.state == UIGestureRecognizerStateBegan) {
                path = [[UIBezierPath alloc] init];
                [path moveToPoint:p1];
                
                action = [[NSMutableDictionary alloc] init];
                [action setObject:@"brush" forKey:@"mode"];
                [action setObject:@"0x000fff" forKey:@"color"];
                NSMutableArray *_path0 = [NSMutableArray arrayWithObjects:NSStringFromCGPoint(p1), nil];
                NSMutableArray *_ctrol0 = [NSMutableArray arrayWithObjects:NSStringFromCGPoint(p1), nil];
                NSMutableArray *_path1 = [NSMutableArray arrayWithObjects:NSStringFromCGPoint(p1), nil];
                NSMutableArray *_ctrol1 = [NSMutableArray arrayWithObjects:NSStringFromCGPoint(p1), nil];
                
                
                [action setObject:[NSMutableArray arrayWithObjects:_path0,_ctrol0,_path1,_ctrol1, nil] forKey:@"path"];
                
                
                path0 = [[UIBezierPath alloc] init];
                
                p00.x = -1000.0f;
                _mp10 = p1;
                _mp11 = p1;
                
                strokeWidth = 0.1f;
                
                [path moveToPoint:p1];
                
            }
            else if (pan.state == UIGestureRecognizerStateChanged){
                
                
                [path0 removeAllPoints];
                
                //p10 mp10 p11 mp11
                CGFloat w = strokeWidth;
                
                
                
                mP1 = midPoint(p0, p1);
                
                CGPoint p10 = [self triangle:p0 p1:p1 w:w];
                CGPoint p11 = [self triangle:p0 p1:p1 w:-w];
                CGPoint mp10 = [self triangle:mP0 p1:mP1 w:w];
                CGPoint mp11 = [self triangle:mP0 p1:mP1 w:-w];
                
                NSMutableArray *_pathA = [action objectForKey:@"path"];
                
                NSMutableArray *_path0 = [_pathA objectAtIndex:0];
                NSMutableArray *_ctrol0 = [_pathA objectAtIndex:1];
                NSMutableArray *_path1 = [_pathA objectAtIndex:2];
                NSMutableArray *_ctrol1 = [_pathA objectAtIndex:3];
                
                [_path0 addObject:NSStringFromCGPoint(mp10)];
                [_ctrol0 addObject:NSStringFromCGPoint(p10)];
                [_path1 addObject:NSStringFromCGPoint(mp11)];
                [_ctrol1 addObject:NSStringFromCGPoint(p11)];
                
                if (ccpDistance(p1, p0) < w) return;
                if (p00.x==-1000.0f){
                    
                    //            [path0 addLineToPoint:p10];
                    //            [path1 addLineToPoint:p11];
                }
                else{
                    [path0 moveToPoint:_mp10];
                    [path0 addQuadCurveToPoint:mp10 controlPoint:p00];
                    [path0 addLineToPoint:_mp11];
                    [path0 addLineToPoint:_mp10];
                    
                    [path0 moveToPoint:_mp11];
                    [path0 addQuadCurveToPoint:mp11 controlPoint:p01];
                    [path0 addLineToPoint:mp10];
                    [path0 addLineToPoint:_mp11];
                }
                
                [path addLineToPoint:p1];
                p00 = p10;
                p01 = p11;
                _mp10 = mp10;
                _mp11 = mp11;
                
                [path1 removeAllPoints];
                [path1 addArcWithCenter:mP1 radius:strokeWidth startAngle:0 endAngle:M_PI * 2 clockwise:YES];
                
                //        [path0 removeAllPoints];
                
            }
            else if (pan.state == UIGestureRecognizerStateEnded) {
                
                [path0 removeAllPoints];
                
                //p10 mp10 p11 mp11
                CGFloat w = strokeWidth;
                
                
                
                mP1 = midPoint(p0, p1);
                
                CGPoint p10 = [self triangle:p0 p1:p1 w:w];
                CGPoint p11 = [self triangle:p0 p1:p1 w:-w];
                CGPoint mp10 = [self triangle:mP0 p1:mP1 w:w];
                CGPoint mp11 = [self triangle:mP0 p1:mP1 w:-w];
                
                NSMutableArray *_pathA = [action objectForKey:@"path"];
                
                NSMutableArray *_path0 = [_pathA objectAtIndex:0];
                NSMutableArray *_ctrol0 = [_pathA objectAtIndex:1];
                NSMutableArray *_path1 = [_pathA objectAtIndex:2];
                NSMutableArray *_ctrol1 = [_pathA objectAtIndex:3];
                
                [_path0 addObject:NSStringFromCGPoint(mp10)];
                [_ctrol0 addObject:NSStringFromCGPoint(p10)];
                [_path1 addObject:NSStringFromCGPoint(mp11)];
                [_ctrol1 addObject:NSStringFromCGPoint(p11)];
                
                if (ccpDistance(p1, p0) < w) return;
                
                [path0 moveToPoint:_mp10];
                [path0 addQuadCurveToPoint:mp10 controlPoint:p00];
                [path0 addLineToPoint:_mp11];
                [path0 addLineToPoint:_mp10];
                
                [path0 moveToPoint:_mp11];
                [path0 addQuadCurveToPoint:mp11 controlPoint:p01];
                [path0 addLineToPoint:mp10];
                [path0 addLineToPoint:_mp11];
                
                [path1 removeAllPoints];
                [path1 addArcWithCenter:mP1 radius:strokeWidth startAngle:0 endAngle:M_PI * 2 clockwise:YES];
                //        [path1 addLineToPoint:mP1];
                
            }
            mP0 = mP1;
            p0 = p1;
            
            break;
            
        default:
            strokeWidth = strokeWidthExpect;
            break;
    }
    
    
    
    
    
    
    
    [self imgDraw];
    [self setNeedsDisplay];
}


- (void)pan2:(UIPanGestureRecognizer *)pan {
    
    CGPoint localPoint = [pan locationInView:self.superview];
//    UITouch *t0 = 
    if (pan.state == UIGestureRecognizerStateBegan) {
        _localPoint = localPoint;
        _frame = self.frame;
    }else if (pan.state == UIGestureRecognizerStateChanged || pan.state == UIGestureRecognizerStateEnded){
        CGRect _rect;
        _rect = CGRectMake(
                            _frame.origin.x + (localPoint.x - _localPoint.x),
                            _frame.origin.y + (localPoint.y - _localPoint.y),
                            _frame.size.width,
                            _frame.size.height
                            );
        [self setFrame:_rect];
    };
    
}

-(IBAction)clearBtn:(id)sender
{
//    isCelar = !isCelar;
    strokeColor = strokeColor = HexRGBAlpha(0xff0000,0.9f);
}

-(void)imgDraw
{
    UIGraphicsBeginImageContext(drawingBoardImg.frame.size);
    /*
    // 改变清晰度
    UIGraphicsBeginImageContextWithOptions(drawingBoardImg.frame.size, YES, 1.0);
    [drawingBoardImg.layer renderInContext:UIGraphicsGetCurrentContext()];
     */
    [drawingBoardImg drawRect:self.bounds];
//    CGAffineTransform _transform = CGAffineTransformMakeTranslation(0, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextTranslateCTM(context, 199, 199);
    
    //画笔模式
    switch (brushMode) {
        case 1:
            // brushMode = 1 钢笔模式
            [brushColor setFill];
            [path0 fill];
            [path1 fill];
            break;
        case 2:
//            [[UIImage imageNamed:@"001@2x"] drawAtPoint:CGPointMake(0, 0)];
            // brushMode = 1 铅笔模式
//            [brushColor setStroke];
//            [path0 strokeWithBlendMode:kCGBlendModeDestinationIn alpha:1.0f];
//            [path0 setLineWidth:strokeWidth * 1 / self.zoomScale];
//            [path0 stroke];
            
            
//            [path0 setLineWidth:7];
//            [path0 stroke];
//            [path0 setLineWidth:6];
//            [path0 stroke];
//            [path0 setLineWidth:5];
//            [path0 stroke];
            
//            [brushColor setFill];
//            [path0 fill];
            
            for (int i = 0; i<[brush2Points count]; i++) {
                CGPoint _p = CGPointFromString([brush2Points objectAtIndex:i]);
                CGFloat alpha = (arc4random() % 100) * 0.01;
                [brushImage drawAtPoint:CGPointMake(_p.x, _p.y) blendMode:kCGBlendModeColorBurn |kCGBlendModeLuminosity alpha: alpha];
                [brushImage0 drawAtPoint:CGPointMake(_p.x, _p.y) blendMode:kCGBlendModeColorBurn| kCGBlendModeLuminosity  alpha: alpha];
                NSLog(@"%f",alpha);
            }
            
            
            break;
        case 3:
//            [brushColor setStroke];
//            [path0 setLineWidth:strokeWidth * 1 / self.zoomScale];
//            [path0 stroke];
            [brushColor setFill];
            [path0 fill];
            break;
        case 0:
            // brushMode = 1 橡皮模式
            [clearColor setFill];
            [path0 fillWithBlendMode:kCGBlendModeClear alpha:0];
            [path0 fill];
//            [path0 stroke];
            
            break;

        default:
            [brushColor setFill];
            break;
    }
    
    

    
//    if (path1) [path1 fill];
    
    drawingBoardImg.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}



/* 识别放大缩小 */
//- (void)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer {
//    CGPoint location = [gestureRecognizer locationInView:self];
//    [self.layer setAnchorPoint:location];
//    NSLog(@"scale:%f",gestureRecognizer.scale);
//    gestureRecognizer.view.transform = CGAffineTransformScale(gestureRecognizer.view.transform, gestureRecognizer.scale, gestureRecognizer.scale);
//    CGRect zoomRect = [self zoomRectForScale:gestureRecognizer.scale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view] target:gestureRecognizer.view];
//    [gestureRecognizer.view setFrame:zoomRect];
//    gestureRecognizer.scale = 1;
//}

- (void)handleDoubleTap:(UIGestureRecognizer *)gesture
{
//    CGPoint location = [gesture locationInView:self];
//    float newScale = zoomScale * 1.5;
//    CGRect zoomRect = [self zoomRectForScale:1.5 withCenter:[gesture locationInView:self] target:self];
//    [UIView beginAnimations:@"scale" context:NULL];
//    [self setFrame:zoomRect];
//    [UIView commitAnimations];
//    [self zoomToRect:zoomRect animated:YES];
}

//- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
//{
//    CGRect zoomRect;
//    zoomRect.size.height = self.bounds.size.height / scale;
//    zoomRect.size.width  = self.bounds.size.width  / scale;
//    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
//    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
//    return zoomRect;
//}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return drawBoardV;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    [scrollView setZoomScale:scale animated:NO];
}

-(CGPoint)triangle:(CGPoint)p0 p1:(CGPoint)p1 w:(CGFloat)w
{
    CGPoint pt = ccpSub(p1, p0);
	GLfloat angle = ccpToAngle(pt);

    GLfloat x = sinf(angle) * w;
	GLfloat y = cosf(angle) * w;
    
    return CGPointMake(p1.x + x, p1.y - y);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 
 }
 */

-(void)setBrushMode:(int)_brushMode
{
    brushMode = _brushMode;
//    [self setBrushColor:brushColor];
}

-(void)setBrushColor:(UIColor *)_brushColor
{
    brushColor = _brushColor;
    
    switch (brushMode) {
        case 1:
            brushColor = _brushColor;
            brushColor = [UIColor colorWithPatternImage:[[UIImage imageNamed:@"temp.jpg"] imageWithGradientTintColor:_brushColor]];
            break;
        case 2:
            brushImage =[[UIImage imageNamed:@"brush2"] imageWithGradientTintColor:_brushColor];
            brushImage0 =[UIImage imageNamed:@"brush2"];
            brushColor = [UIColor colorWithPatternImage:brushImage];
            break;
            
        default:
            brushColor = _brushColor;
            break;
    }
}



@end

