//
//  AppDelegate.h
//  GoTu
//
//  Created by xuwenjuan on 13-11-26.
//  Copyright (c) 2013年 vince. All rights reserved.
//
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define bgColor [UIColor colorWithRed:239 green:236 blue:236 alpha:255];

//NSString *gHostName = @"http://taguxdesign.com/gotu/";



#import <UIKit/UIKit.h>
#import "feedData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) feedData *feedDataTool;

@end
