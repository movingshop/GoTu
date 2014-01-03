//
//  feedBottomCell.h
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol feedBottomCellDelegate <NSObject>

- (void) showContentWithData:(NSDictionary*) data;

@end

@interface feedBottomCell : UITableViewCell
{
    IBOutlet UIButton *avatarB;
    IBOutlet UIButton *picB;
}

@property (strong,nonatomic) NSDictionary *data;

@property (assign, nonatomic) id<feedBottomCellDelegate> delegate;


@end
