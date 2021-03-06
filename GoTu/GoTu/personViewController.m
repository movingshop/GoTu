//
//  personViewController.m
//  GoTu
//
//  Created by vince.wang on 13-12-23.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "personViewController.h"
#import "personCell.h"

@interface personViewController ()

@end

@implementation personViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customInit];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 260.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"personCell";
    personCell *cell = (personCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"personCell"  owner:self options:nil] lastObject];
        cell.delegate = self;
        
    }
    NSDictionary *_data_ =[tableData objectAtIndex:indexPath.row];
    [cell.picV setImageWithURL:[_data_ objectForKey:@"image"]];
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
        
//        [pushRefreshVC refreshOver]; //刷新完成
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
        
        
//        [avatarB setImageWithURL:<#(NSURL *)#> forState:<#(UIControlState)#>]
        [pushRefreshVC refreshOver]; //刷新完成
    } errorHandler:^(NSError *error) {
        NSLog(@"error:%@",error);
        
        [pushRefreshVC refreshOver]; //刷新完成
    }];
}
//table End

-(void)toDrawBoard:(UIImage *)image
{
    
}

-(void)customInit
{
    //table 初始化
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone; //去掉分割线
    [tableV setDelegate:self];
    [tableV setDataSource:self];
//
    [tableV setTableHeaderView:headerView];
    [self headerRefresh];
    
//    加载更多
    pushRefreshVC = [[pushRefreshViewController alloc] init];
    [pushRefreshVC.view setFrame:tableV.frame];
    pushRefreshVC.delegate = self;
    
    [tableV setBackgroundView:pushRefreshVC.view];
    [tableV addObserver:pushRefreshVC forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

@end
