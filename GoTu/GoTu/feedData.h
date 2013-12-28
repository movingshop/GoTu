//
//  feedData.h
//  GoTu
//
//  Created by vincy.vince on 13-12-29.
//  Copyright (c) 2013年 vince. All rights reserved.
//

@interface feedData : MKNetworkEngine

typedef void (^responseBlock)(NSArray *data);

-(MKNetworkOperation*)getNew:(responseBlock) completion errorHandler:(MKNKErrorBlock) error;

@end
