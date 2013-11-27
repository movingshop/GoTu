//
//  colorViewController.h
//  GoTu
//
//  Created by vince.wang on 13-11-27.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface colorViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *tableV;
    NSArray *tableA;
    UIView *showColorBox;
    UIView *showColor;
    __unsafe_unretained id myDelegate;
}

@property (unsafe_unretained, assign) id myDelegate;

@end

//协议

@protocol colorSelectDelegate

@optional

-(void)changeColor:(UIColor *)color;

@end
