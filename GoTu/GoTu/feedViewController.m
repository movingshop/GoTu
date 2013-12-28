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
#import "UIScrollView+UzysCircularProgressPullToRefresh.m"

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
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone; //去掉分割线
    // Do any additional setup after loading the view from its nib.
    [tableV setDelegate:self];
    [tableV setDataSource:self];
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELLIDENTIFIER];
    [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:CELLIDENTIFIER];
    
    
    feedDataTool = [ApplicationDelegate.feedDataTool getNew:^(NSArray *data) {
        tableData = (NSMutableArray *)[tableData arrayByAddingObjectsFromArray:data];
        [tableV reloadData];
    } errorHandler:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf =self;
    
    //Because of self.automaticallyAdjustsScrollViewInsets you must add code below in viewWillApper
    [tableV addPullToRefreshActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //manually triggered pulltorefresh
    [tableV triggerPullToRefresh];
}

- (void)insertRowAtTop {
    __weak typeof(self) weakSelf = self;
    
    int64_t delayInSeconds = 1.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableV beginUpdates];
//        [weakSelf.pData insertObject:[NSDate date] atIndex:0];
        [weakSelf.tableV insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
//        [weakSelf.tableV endUpdates];
        
        //Stop PullToRefresh Activity Animation
        [weakSelf.tableV stopRefreshAnimation];
    });
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
