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
@synthesize delegate,data;

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
    [tableV setScrollsToTop:NO]; //点击UIStatusBar 主UITableView不回到顶部问题解决方法
    //tableV 初始化 over
    
    [editBtn addTarget:self action:@selector(toEdit) forControlEvents:UIControlEventTouchUpInside]; // 进入编辑模式
    
    [self addObserver:self forKeyPath:@"data" options:NSKeyValueObservingOptionNew context:nil];
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


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (data)
    {
        [avatarB setImageWithURL:[data objectForKey:@"avatar"] forState:UIControlStateNormal ];
        [picV setImageWithURL:[[data objectForKey:@"image"] objectForKey:@"url"]];
        [nickNameL setText:[data objectForKey:@"nickname"]];
        [commentNumL setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"comment"]]];
        [likeNumL setText:[NSString stringWithFormat:@"%@",[data objectForKey:@"like"]]];
    }
    
    tableData = [data objectForKey:@"childrens"];
    [tableV reloadData];
    
    [self setNeedsDisplay];
}

-(void)showContentWithData:(NSDictionary *)newData
{
    NSLog(@"newData");
    [avatarB setImageWithURL:[newData objectForKey:@"avatar"] forState:UIControlStateNormal ];
    [picV setImageWithURL:[[newData objectForKey:@"image"] objectForKey:@"url"]];
    [nickNameL setText:[newData objectForKey:@"nickname"]];
    [commentNumL setText:[NSString stringWithFormat:@"%@",[newData objectForKey:@"comment"]]];
    [likeNumL setText:[NSString stringWithFormat:@"%@",[newData objectForKey:@"like"]]];
}




//table Start
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
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
    cell.data = [tableData objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}
//table End

@end
