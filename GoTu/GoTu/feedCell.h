//
//  feedCell.h
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "feedBottomCell.h"

@protocol feedCellDelegate <NSObject>

- (void) toDrawBoard:(UIImage*) image;

@end

@interface feedCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource,feedBottomCellDelegate>
{
//    id<cellDelegate> delegate;
    
    IBOutlet UITableView *tableV;
    NSMutableArray *tableData;
    
    IBOutlet UIImageView *picV;
    IBOutlet UIButton *avatarB;
    IBOutlet UILabel *nickNameL;
    IBOutlet UILabel *likeNumL;
    IBOutlet UILabel *commentNumL;
    

    IBOutlet UIButton *editBtn;
    
//    BOOL nedMove
}

@property (strong,nonatomic) NSDictionary *data;

@property (assign, nonatomic) id<feedCellDelegate> delegate;

@end


