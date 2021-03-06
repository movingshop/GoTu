//
//  feedViewController.h
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "feedCell.h"
#import "pushRefreshViewController.h"

@interface feedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,feedCellDelegate,pushRefreshViewController>
{
    
    NSMutableArray *tableData;
    
    MKNetworkOperation *feedDataTool;
    
    pushRefreshViewController *pushRefreshVC;
}

@property (strong,nonatomic) IBOutlet UITableView *tableV;

@end
