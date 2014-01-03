//
//  messageViewController.h
//  GoTu
//
//  Created by vince.wang on 13-12-30.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "pushRefreshViewController.h"

@interface messageViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,pushRefreshViewController>
{
    IBOutlet UITableView *tableV;
    
    NSMutableArray *tableData;
    
    MKNetworkOperation *feedDataTool;
    
    pushRefreshViewController *pushRefreshVC;
}

@end
