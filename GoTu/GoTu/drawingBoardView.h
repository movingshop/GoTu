//
//  drawingBoardView.h
//  drawingBoard
//
//  Created by vincy.vince on 13-11-4.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface drawingBoardView : UIScrollView<UIScrollViewDelegate>
{
    UIView *drawBoardV;
    
    UIBezierPath *path;
    NSMutableArray *actionArray;
    NSMutableDictionary *action;
    
    UIBezierPath *path0;
    UIBezierPath *path1;
    UIBezierPath *path2;
    
    CGPoint p0;
    CGPoint p1;
    
    CGPoint mP0;
    CGPoint mP1;
    CGPoint _mp10;
    CGPoint _mp11;
    
    CGPoint p00;
    CGPoint p01;
    
    //马克笔
    NSMutableArray *brush3PointA0;
    NSMutableArray *brush3PointA1;
    
    //铅笔
    NSMutableArray *brush2Points;
    
    CGFloat strokeWidth;
    
    UIImageView *drawingBoardImg;
    UIImage *_tempImg;
    
    UIColor *strokeColor;
    UIImage *brushImage;
    UIImage *brushImage0;
    UIColor *clearColor;
    
    CGPoint _localPoint;
    CGRect _frame;
    
//    CGFloat zoomScale;
    
    BOOL isCelar;
    
}

@property (nonatomic) int brushMode;
@property (strong,nonatomic) UIColor *brushColor;
@property (strong,nonatomic) UIImageView *backGroundImageView;

@end
