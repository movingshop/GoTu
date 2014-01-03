//
//  personCell.h
//  GoTu
//
//  Created by vince.wang on 13-12-31.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol personCellDelegate <NSObject>

- (void) toDrawBoard:(UIImage*) image;

@end

@interface personCell : UITableViewCell

@property (strong,nonatomic) IBOutlet UIImageView *picV;

@property (assign, nonatomic) id<personCellDelegate> delegate;

@end
