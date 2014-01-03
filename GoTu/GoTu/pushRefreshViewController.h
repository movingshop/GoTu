//
//  pushRefreshViewController.h
//  GoTu
//
//  Created by vincy.vince on 13-12-29.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>
@class pushRefreshView;

@protocol pushRefreshViewController <NSObject>

- (void) headerRefresh;

- (void) footerRefresh;

@end

@interface pushRefreshViewController : UIViewController
{
    IBOutlet pushRefreshView *headerV;
    IBOutlet pushRefreshView *footerV;
    IBOutlet UIImageView *headerImgV;
    IBOutlet UIImageView *footerImgV;
    BOOL isRefresh;
    UITableView *tableV;
}

@property (assign, nonatomic) id<pushRefreshViewController> delegate;

-(void)refreshOver;

@end
