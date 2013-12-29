//
//  feedViewController.m
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#define CELLIDENTIFIER @"refreshCELL"

#import "feedViewController.h"
#import "feedCell.h"
#import "drawBoardViewController.h"
#import "pushRefreshViewController.h"

@interface feedViewController ()

@end

@implementation feedViewController
@synthesize tableV;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        tableData = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //table 初始化
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone; //去掉分割线
    [tableV setDelegate:self];
    [tableV setDataSource:self];
    
    //数据初始化
    feedDataTool = [ApplicationDelegate.feedDataTool getNew:^(NSArray *data) {
        tableData = (NSMutableArray *)[tableData arrayByAddingObjectsFromArray:data];
        [tableV reloadData];
    } errorHandler:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%@",NSStringFromCGRect(tableV.frame));
    pushRefreshViewController *pushRefreshVC = [[pushRefreshViewController alloc] init];
    [pushRefreshVC.view setFrame:tableV.frame];
    [tableV setBackgroundView:pushRefreshVC.view];
    [pushRefreshVC addObserver:self forKeyPath:@"contentOffSet" options:NSKeyValueObservingOptionNew context:nil];

}

-(void)toDrawBoard:(UIImage *)image
{
    NSLog(@"toDrawBoard");
    drawBoardViewController *drawBoard = [[drawBoardViewController alloc] init];
    drawBoard.editImage = image;
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:drawBoard];
    navC.navigationBarHidden = YES;
    [self presentViewController:navC animated:YES completion:nil];
}

-(void)reloadFeedData:(NSString *)data
{
    NSLog(@"%@",data);
    
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
    return 394.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"feedCell";
    feedCell *cell = (feedCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"feedCell"  owner:self options:nil] lastObject];
        cell.delegate = self;
        
    }
    NSDictionary *_data_ =[tableData objectAtIndex:indexPath.row];
    [cell.avatarB setImageWithURL:[_data_ objectForKey:@"avatar"] forState:UIControlStateNormal ];
    [cell.picV setImageWithURL:[_data_ objectForKey:@"image"]];
    return cell;
}

//table End

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
