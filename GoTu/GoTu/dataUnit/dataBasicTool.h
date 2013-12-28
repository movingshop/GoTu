//
//  dataBasicTool.h
//  GoTu
//
//  Created by vince.wang on 13-12-27.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <MKNetworkKit.h>

//extern NSString *gHostName;

@interface dataBasicTool : MKNetworkEngine
{
    
}

+(dataBasicTool *)sharedTool;

-(void)addTarget:(id)target action:(SEL)action;


@end