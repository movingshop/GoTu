//
//  dataBasicTool.m
//  GoTu
//
//  Created by vince.wang on 13-12-27.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "dataBasicTool.h"

@implementation dataBasicTool

static dataBasicTool *sharedTool;

+ (dataBasicTool *)sharedTool{
    @synchronized(self){
        if (!sharedTool) {
            sharedTool = [[dataBasicTool alloc]init];
        }
        return sharedTool;
    }
}
- (id)init{
    if (self = [super init]) {
        
    }
    return self;
}


//feedData GET
-(void)addTarget:(id)target action:(SEL)action
{
    NSMutableDictionary *headerFields = [NSMutableDictionary dictionary];
    [headerFields setValue:@"iOS" forKey:@"x-client-identifier"];
    
    self.engine = [[dataBasicTool alloc] initWithHostName:@"download.finance.yahoo.com"
                                     customHeaderFields:headerFields];
    
    
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (action) [target performSelector:action withObject:@"dataTools"];//此处是你调用函数的地方
    #pragma clang diagnostic pop
    
}

@end


