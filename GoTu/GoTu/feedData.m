//
//  feedData.m
//  GoTu
//
//  Created by vincy.vince on 13-12-29.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "feedData.h"

#define feedUrl(__page__) [NSString stringWithFormat:@"index.php?p=%i", __page__]

@implementation feedData

-(MKNetworkOperation*)getNew:(responseBlock)completionBlock errorHandler:(MKNKErrorBlock)errorBlock
{
    MKNetworkOperation *op = [self operationWithPath:feedUrl(0) params:nil httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         // the completionBlock will be called twice.
         // if you are interested only in new values, move that code within the else block
         
         NSDictionary *data = [completedOperation responseJSON];
         NSArray *pData = [data objectForKey:@"pics"];
//         NSLog(@"%@",data);
         
         completionBlock(pData);
         
     }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;

}

@end
