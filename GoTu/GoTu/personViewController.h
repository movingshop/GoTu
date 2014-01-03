//
//  personViewController.h
//  GoTu
//
//  Created by vince.wang on 13-12-23.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "personCell.h"
#import "pushRefreshViewController.h"

@interface personViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,personCellDelegate,pushRefreshViewController>
{
    IBOutlet UIView *headerView;
    IBOutlet UITableView *tableV;
    IBOutlet UIButton *avatarB;
    
    NSMutableArray *tableData;
    
    MKNetworkOperation *feedDataTool;
    
    pushRefreshViewController *pushRefreshVC;
}



@end
