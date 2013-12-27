//
//  feedViewController.m
//  GoTu
//
//  Created by vince.wang on 13-12-25.
//  Copyright (c) 2013年 vince. All rights reserved.
//

#import "feedViewController.h"
#import "feedCell.h"
#import "drawBoardViewController.h"
#import "dataBasicTool.h"

@interface feedViewController ()

@end

@implementation feedViewController

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
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone; //去掉分割线
    // Do any additional setup after loading the view from its nib.
    [tableV setDelegate:self];
    [tableV setDataSource:self];
    
    [[dataBasicTool sharedTool] addTarget:self action:@selector(reloadFeedData:)];
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
    return 100;
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
        
    }
    cell.delegate = self;
    return cell;
}
//table End

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
