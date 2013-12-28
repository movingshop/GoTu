//
//  feedViewController.h
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "feedCell.h"
@class UzysRadialProgressActivityIndicator;

@interface feedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,cellDelegate>
{
    
    NSMutableArray *tableData;
    
    MKNetworkOperation *feedDataTool;
}

@property (strong,nonatomic) IBOutlet UITableView *tableV;
@property (nonatomic,strong) UzysRadialProgressActivityIndicator *radialIndicator;

@end
