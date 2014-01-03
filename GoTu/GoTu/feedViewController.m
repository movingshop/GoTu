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
    tableV.backgroundColor = bgColor;
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone; //去掉分割线
    [tableV setDelegate:self];
    [tableV setDataSource:self];
    
    pushRefreshVC = [[pushRefreshViewController alloc] init];
    [pushRefreshVC.view setFrame:tableV.frame];
    pushRefreshVC.delegate = self;
    
    [tableV setBackgroundView:pushRefreshVC.view];
    [tableV addObserver:pushRefreshVC forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [self headerRefresh];
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
//    [cell.avatarB setImageWithURL:[_data_ objectForKey:@"avatar"] forState:UIControlStateNormal ];
//    [cell.picV setImageWithURL:[_data_ objectForKey:@"image"]];
    cell.data = _data_;
    return cell;
}

-(void)headerRefresh
{
    //数据初始化
    feedDataTool = [ApplicationDelegate.feedDataTool getNew:^(NSArray *data) {
        tableData = (NSMutableArray *)data;
        
        [tableV reloadData];
        [tableV removeObserver:pushRefreshVC forKeyPath:@"contentOffset"];
        [tableV addObserver:pushRefreshVC forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
        [pushRefreshVC refreshOver]; //刷新完成
    } errorHandler:^(NSError *error) {
        NSLog(@"error:%@",error);
        
        [pushRefreshVC refreshOver]; //刷新完成
    }];
}

-(void)footerRefresh
{
    //数据初始化
    feedDataTool = [ApplicationDelegate.feedDataTool getNew:^(NSArray *data) {
        tableData = (NSMutableArray *)[tableData arrayByAddingObjectsFromArray:data];
        
        [tableV reloadData];
        [tableV removeObserver:pushRefreshVC forKeyPath:@"contentOffset"];
        [tableV addObserver:pushRefreshVC forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        
        [pushRefreshVC refreshOver]; //刷新完成
    } errorHandler:^(NSError *error) {
        NSLog(@"error:%@",error);
        
        [pushRefreshVC refreshOver]; //刷新完成
    }];
}
//table End

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
