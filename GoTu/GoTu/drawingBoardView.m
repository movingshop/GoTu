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

@implementation drawingBoardView

@synthesize backGroundImageView;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // Initialization code
        //        self.frame = CGRectMake(0, 0, MRScreenWidth, MRScreenHeight);
        [self initWithCustom];
    }
    return self;
}

-(void)initWithCustom
{
    [self setBrushColor:[UIColor whiteColor]];
    
    [self setClipsToBounds:YES];
    
    backGroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:backGroundImageView];
    
    strokeColor = HexRGBAlpha(0x000000,1.0f);
    isCelar = NO;
    
    drawingBoardImg = [[UIImageView alloc] initWithFrame:backGroundImageView.frame];
    [self addSubview:drawingBoardImg];
    
    path = [[UIBezierPath alloc] init];
    path1 = [[UIBezierPath alloc] init];
    path2 = [[UIBezierPath alloc] init];
    actionArray = [[NSMutableArray alloc] init];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    pan.maximumNumberOfTouches = 1;
    pan.minimumNumberOfTouches = 1;
    [self addGestureRecognizer:pan];
    
    UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan2:)];
    pan2.maximumNumberOfTouches = 2;
    pan2.minimumNumberOfTouches = 2;
    
    [self addGestureRecognizer:pan2];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self addGestureRecognizer:pinch];
    
    CGPoint _p0 = CGPointMake(0, 0);
    CGPoint _p1 = CGPointMake(1, 1);
    CGPoint _p10 = [self triangle:_p0 p1:_p1 w:1];
    NSLog(@"%@",NSStringFromCGPoint(_p10));
    
    strokeWidth =0.10f;
    
}


- (void)pan:(UIPanGestureRecognizer *)pan {
    
//    if ()
    
    p1 = [pan locationInView:self];
    
    CGFloat _strokeWidth = ccpLength([pan velocityInView:self]);
    
    _strokeWidth = powf(MIN(1, (_strokeWidth / 1000)), 2);
    _strokeWidth = _strokeWidth * 10;
    CGFloat _scale = powf(2 * (10 - _strokeWidth), .5) ;
    _scale = _scale * 0.05;
    NSLog(@"_strokeWidth:%f   _scale:%f",_strokeWidth,_scale);
//    NSLog(@"stro%")
    strokeWidth += (_strokeWidth - strokeWidth) *0.05;
    
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
    [self imgDraw];
    [self setNeedsDisplay];
}


- (void)pan2:(UIPanGestureRecognizer *)pan {
    
    CGPoint localPoint = [pan locationInView:self.superview];
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
//    UIGraphicsBeginImageContextWithOptions(drawingBoardImg.frame.size, YES, 1.0);
//    [drawingBoardImg.layer renderInContext:UIGraphicsGetCurrentContext()];
    [drawingBoardImg drawRect:self.bounds];
//    [[UIColor colorWithPatternImage:[UIImage imageNamed:@"stroke_pen.png"]] setFill];
    [strokeColor setFill];
//    [path0 fillWithBlendMode:kCGBlendModeClear alpha:.5];
    [path0 fill];
    [path1 fill];
    drawingBoardImg.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(context);
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//    if (_tempImg) CGContextDrawImage(context, self.bounds, _tempImg.CGImage);
//    CGContextRestoreGState(context);
    
    [path removeAllPoints];
    [path appendPath:path0];
    [path closePath];
    [path stroke];
    
}
 */

/* 识别放大缩小 */
- (void)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer {
//    CGPoint location = [gestureRecognizer locationInView:self];
    gestureRecognizer.view.transform = CGAffineTransformScale(gestureRecognizer.view.transform, gestureRecognizer.scale, gestureRecognizer.scale);
    gestureRecognizer.scale = 1;
}


-(CGPoint)triangle:(CGPoint)p0 p1:(CGPoint)p1 w:(CGFloat)w
{
    CGPoint pt = ccpSub(p1, p0);
	GLfloat angle = ccpToAngle(pt);

    GLfloat x = sinf(angle) * w;
	GLfloat y = cosf(angle) * w;
    
    return CGPointMake(p1.x + x, p1.y - y);
}


@end

