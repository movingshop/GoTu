//
//  CAKeyframeAnimation+AHEasing.m
//
//  Copyright (c) 2011, Auerhaus Development, LLC
//
//  This program is free software. It comes without any warranty, to
//  the extent permitted by applicable law. You can redistribute it
//  and/or modify it under the terms of the Do What The Fuck You Want
//  To Public License, Version 2, as published by Sam Hocevar. See
//  http://sam.zoy.org/wtfpl/COPYING for more details.
//

#import "CAKeyframeAnimation+AHEasing.h"

#if !defined(AHEasingDefaultKeyframeCount)

// The larger this number, the smoother the animation
#define AHEasingDefaultKeyframeCount 60

#endif

@implementation CAKeyframeAnimation (AHEasing)

+ (id)animationWithKeyPath:(NSString *)path function:(AHEasingFunction)function fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue keyframeCount:(size_t)keyframeCount
{
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:keyframeCount];
	
	CGFloat t = 0.0;
	CGFloat dt = 1.0 / (keyframeCount - 1);
	for(size_t frame = 0; frame < keyframeCount; ++frame, t += dt)
	{
		CGFloat value = fromValue + function(t) * (toValue - fromValue);
		[values addObject:[NSNumber numberWithFloat:value]];
	}
	
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path];
	[animation setValues:values];
	return animation;
}

+ (id)animationWithKeyPath:(NSString *)path function:(AHEasingFunction)function fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue
{
    return [self animationWithKeyPath:path function:function fromValue:fromValue toValue:toValue keyframeCount:AHEasingDefaultKeyframeCount];
}

+ (id)animationWithKeyPath:(NSString *)path function:(AHEasingFunction)function fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint keyframeCount:(size_t)keyframeCount
{
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:keyframeCount];
	
	CGFloat t = 0.0;
	CGFloat dt = 1.0 / (keyframeCount - 1);
	for(size_t frame = 0; frame < keyframeCount; ++frame, t += dt)
	{
		CGFloat x = fromPoint.x + function(t) * (toPoint.x - fromPoint.x);
		CGFloat y = fromPoint.y + function(t) * (toPoint.y - fromPoint.y);
		[values addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
	}
	
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path];
	[animation setValues:values];
	return animation;
}

+ (id)animationWithKeyPath:(NSString *)path function:(AHEasingFunction)function fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint
{
    return [self animationWithKeyPath:path function:function fromPoint:fromPoint toPoint:toPoint keyframeCount:AHEasingDefaultKeyframeCount];
}

+ (id)animationWithKeyPath:(NSString *)path function:(AHEasingFunction)function fromSize:(CGSize)fromSize toSize:(CGSize)toSize keyframeCount:(size_t)keyframeCount
{
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:keyframeCount];
	
	CGFloat t = 0.0;
	CGFloat dt = 1.0 / (keyframeCount - 1);
	for(size_t frame = 0; frame < keyframeCount; ++frame, t += dt)
	{
		CGFloat w = fromSize.width + function(t) * (toSize.width - fromSize.width);
		CGFloat h = fromSize.height + function(t) * (toSize.height - fromSize.height);
		[values addObject:[NSValue valueWithCGRect:CGRectMake(0, 0, w, h)]];
	}
	
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path];
	[animation setValues:values];
	return animation;
}

+ (id)animationWithKeyPath:(NSString *)path function:(AHEasingFunction)function fromSize:(CGSize)fromSize toSize:(CGSize)toSize
{
    return [self animationWithKeyPath:path function:function fromSize:fromSize toSize:toSize keyframeCount:AHEasingDefaultKeyframeCount];
}

+ (id)animationWithKeyPath:(NSString *)path function:(AHEasingFunction)function fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame keyframeCount:(size_t)keyframeCount
{
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:keyframeCount];
	
	CGFloat t = 0.0;
	CGFloat dt = 1.0 / (keyframeCount - 1);
	for(size_t frame = 0; frame < keyframeCount; ++frame, t += dt)
	{
        CGFloat x = fromFrame.origin.x + function(t) * (toFrame.origin.x - fromFrame.origin.x);
		CGFloat y = fromFrame.origin.y + function(t) * (toFrame.origin.y - fromFrame.origin.y);
		CGFloat w = fromFrame.size.width + function(t) * (toFrame.size.width - fromFrame.size.width);
		CGFloat h = fromFrame.size.height + function(t) * (toFrame.size.height - fromFrame.size.height);
		[values addObject:[NSValue valueWithCGRect:CGRectMake(x, y, w, h)]];
	}
	
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path];
	[animation setValues:values];
	return animation;
}

+ (id)animationWithKeyPath:(NSString *)path function:(AHEasingFunction)function fromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame
{
    return [self animationWithKeyPath:path function:function fromFrame:fromFrame toFrame:toFrame keyframeCount:AHEasingDefaultKeyframeCount];
}

+ (id)animationWithKeyPath:(NSString *)path function:(AHEasingFunction)function fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint delay:(CGFloat)delay keyframeCount:(size_t)keyframeCount
{
	NSMutableArray *values = [NSMutableArray arrayWithCapacity:keyframeCount];
    
	CGFloat t = 0.0;
	CGFloat dt = 1.0 / (keyframeCount - 1);
	for(size_t frame = 0; frame < keyframeCount; ++frame, t += dt)
	{
        CGFloat delayT = MAX(0, t);
		CGFloat x = fromPoint.x + function(delayT) * (toPoint.x - fromPoint.x);
		CGFloat y = fromPoint.y + function(delayT) * (toPoint.y - fromPoint.y);
		[values addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
	}
	
	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path];
	[animation setValues:values];
	return animation;
}

+ (id)animationWithKeyPath:(NSString *)path function:(AHEasingFunction)function fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint delay:(CGFloat)delay
{
    return [self animationWithKeyPath:path function:function fromPoint:fromPoint toPoint:toPoint delay:delay keyframeCount:AHEasingDefaultKeyframeCount];
}


//+ (id)animationWithDuration:(CGFloat)duration function:(AHEasingFunction)function fromDic:(NSDictionary *)fromDic toDic:(NSDictionary *)toDic keyframeCount:(size_t)keyframeCount
//{
//    NSString *path = @"transform";
//	NSMutableArray *values = [NSMutableArray arrayWithCapacity:keyframeCount];
//	
//	CGFloat t = 0.0;
//	CGFloat dt = duration / (keyframeCount - 1);
//	for(size_t frame = 0; frame < keyframeCount; ++frame, t += dt)
//	{
////        CATransform3D ca3D = CATransform3DIdentity;
//        CGAffineTransform transform = CGAffineTransformIdentity;
//        
//        CGFloat x = [[fromDic objectForKey:@"x"] floatValue];
//        CGFloat y = [[fromDic objectForKey:@"y"] floatValue];
//        CGAffineTransform _position = CGAffineTransformMakeTranslation(x, y);
//        
//        CGFloat scaleX = [[fromDic objectForKey:@"scaleX"] floatValue];
//        CGFloat scaleY = [[fromDic objectForKey:@"scaleY"] floatValue];
////        CGFloat z = [[fromDic objectForKey:@"z"] floatValue];
//        CGAffineTransform _scale = CGAffineTransformMakeScale(scaleX, scaleY);
//        
//        CGFloat rotation = [[fromDic objectForKey:@"rotaion"] floatValue];
//        //        CGFloat z = [[fromDic objectForKey:@"z"] floatValue];
//        CGAffineTransform _rotation = CGAffineTransformMakeRotation(rotation);
//        
//        
//		
//		CGFloat h = fromSize.height + function(t) * (toSize.height - fromSize.height);
//		[values addObject:[NSValue valueWithCGRect:CGRectMake(0, 0, w, h)]];
//	}
//	
//	CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:path];
//	[animation setValues:values];
//	return animation;
//}
//
//-(CGFloat)numberCountWithTime:(CGFloat)t fromValue:(CGFloat)fromV toValue:(CGFloat)toV function:(AHEasingFunction)function
//{
//    CGFloat value = fromV + function(t) * (toV - fromV);
//    return value;
//}

@end
