//
//  feedCell.h
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol cellDelegate <NSObject>

- (void) toDrawBoard:(UIImage*) image;

@end

@interface feedCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
{
//    id<cellDelegate> delegate;
    
    IBOutlet UITableView *tableV;
    NSMutableArray *tableData;
    

    IBOutlet UIButton *editBtn;
}

@property (strong,nonatomic) IBOutlet UIImageView *picV;
@property (strong,nonatomic) IBOutlet UIButton *avatarB;

@property (assign, nonatomic) id<cellDelegate> delegate;

@end


