//
//  colorViewController.m
//  GoTu
//
//  Created by vince.wang on 13-11-27.
//  Copyright (c) 2013年 vince. All rights reserved.
//
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]
#import "colorViewController.h"

@interface colorViewController ()

@end

@implementation colorViewController

@synthesize myDelegate;

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
    tableA = [NSArray arrayWithObjects:
              HexRGBAlpha(0x68acff, 1),
              HexRGBAlpha(0x6874ff, 1),
              HexRGBAlpha(0xaf28f5, 1),
              HexRGBAlpha(0xfb4514, 1),
              HexRGBAlpha(0xff8022, 1),
              HexRGBAlpha(0xfb1496, 1),
              HexRGBAlpha(0xfe4a74, 1),
              
              HexRGBAlpha(0x68acff, 1),
              HexRGBAlpha(0x6874ff, 1),
              HexRGBAlpha(0xaf28f5, 1),
              HexRGBAlpha(0xfb4514, 1),
              HexRGBAlpha(0xff8022, 1),
              HexRGBAlpha(0xfb1496, 1),
              HexRGBAlpha(0xfe4a74, 1),
              nil];
    
    
    tableV.delegate = self;
    tableV.dataSource = self;
    
    UIView *headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 30, 65)];
    tableV.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 30, 65)];
    tableV.tableFooterView = footerView;
    
    tableV.transform = CGAffineTransformMakeRotation(-M_PI_2);
    [tableV setFrame:CGRectMake(5, 5, 160, 30)];
    tableV.showsVerticalScrollIndicator = NO;
    [tableV setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [tableV setClipsToBounds:YES];
    [tableV.layer setBorderColor:HexRGBAlpha(0xffffff, 1).CGColor];
    [tableV.layer setBorderWidth:1.5f];
    [tableV.layer setCornerRadius:15];
    
    NSLog(@"tableVFrame:%@",NSStringFromCGRect(tableV.frame));
    NSLog(@"tableViewFrame:%@",NSStringFromCGRect(self.view.frame));
    [tableV reloadData];
    
    
    showColorBox = [[UIView alloc] initWithFrame:CGRectMake(65, 0, 40, 40)];
    [showColorBox setUserInteractionEnabled:NO];
    [self.view addSubview:showColorBox];
    
    UIImageView *shadowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"color_show"]];
    [shadowImg setFrame:CGRectMake(0, 0, 40, 40)];
    
    [showColorBox addSubview:shadowImg];
    
    
    showColor = [[UIView alloc] initWithFrame:CGRectMake(4, 4, 32, 32)];
    [showColor setClipsToBounds:YES];
    [showColor.layer setBorderColor:HexRGBAlpha(0xffffff, 1).CGColor];
    [showColor.layer setBorderWidth:1.5f];
    [showColor.layer setCornerRadius:16];
    [showColor setBackgroundColor:[tableA objectAtIndex:3]];
    [showColorBox addSubview:showColor];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 26.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
        
    }
    cell.backgroundColor = (UIColor *)[tableA objectAtIndex:indexPath.row];
    cell.selected = NO;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    [showColor setBackgroundColor:[tableA objectAtIndex:indexPath.row]];
    [myDelegate changeColor:[tableA objectAtIndex:indexPath.row]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableA count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
