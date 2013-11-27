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
              HexRGBAlpha(0x000000, .9),
              HexRGBAlpha(0xff0000, .9),
              HexRGBAlpha(0x00ff00, .9),
              HexRGBAlpha(0x0000ff, .9),
              HexRGBAlpha(0x0ff000, .9),
              HexRGBAlpha(0x000ff0, .9),
              HexRGBAlpha(0x0fff00, .9),
              HexRGBAlpha(0x00fff0, .9),
              HexRGBAlpha(0x0ffff0, .9),
              nil];
    
    [tableV setFrame:self.view.frame];
    tableV.transform = CGAffineTransformMakeRotation(-M_PI_2);
    tableV.delegate = self;
    tableV.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30.0f;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CustomCellIdentifier = @"colorellIdentifier";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
//    if (cell == nil)
//    {
//         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier];
//    }
////    [cell setBackgroundColor:[tableA objectAtIndex:indexPath.row]];
//    return cell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
        cell.backgroundColor = (UIColor *)[tableA objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
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
