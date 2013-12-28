//
//  feedCell.m
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "feedCell.h"
#import "feedBottomCell.h"

@implementation feedCell
@synthesize delegate,picV,avatarB;

-(void)didMoveToSuperview
{
    //圆形头像
    
    [avatarB.layer setCornerRadius:avatarB.frame.size.height/2];
    [avatarB.layer setBorderWidth:3.0f];
    [avatarB.layer setBorderColor:[UIColor whiteColor].CGColor];
    
//    [avatarB addSubview:avatarV];
    
    
    //tableV 初始化 start
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone; //去掉分割线
    CGRect _frame = tableV.frame;
    CGAffineTransform at =CGAffineTransformMakeRotation(-M_PI/2); //逆时针旋转90
    [tableV setTransform:at];
    [tableV setFrame:_frame];
    [tableV setDelegate:self];
    [tableV setDataSource:self];
    [tableV reloadData];
    //tableV 初始化 over
    
    [editBtn addTarget:self action:@selector(toEdit) forControlEvents:UIControlEventTouchUpInside]; // 进入编辑模式
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)toEdit
{
    [delegate toDrawBoard:picV.image];
}





//table Start
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"feedBottomCell";
//    NSLog(@"feedBottomCell");
    feedBottomCell *cell = (feedBottomCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"feedBottomCell"  owner:self options:nil] lastObject];
        CGAffineTransform at =CGAffineTransformMakeRotation(M_PI/2); //顺时钟旋转90
        [cell setTransform:at];
    }
    
    return cell;
}
//table End

@end
