//
//  feedViewController.h
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "feedCell.h"

@interface feedViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,cellDelegate>
{
    IBOutlet UITableView *tableV;
    NSMutableArray *tableData;
}

@end
