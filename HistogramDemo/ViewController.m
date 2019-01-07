//
//  ViewController.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/2.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "ViewController.h"

// ----------------------------VC-----------------------------
#import "DemoAMainVC.h"
#import "DemoBMainVC.h"
#import "DemoCMainVC.h"
#import "DemoDMainVC.h"
#import "DemoEMainVC.h"
#import "DemoFMainVC.h"
#import "DemoGMainVC.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *c = [tableView dequeueReusableCellWithIdentifier:@"BTC"];
    
    if (c == nil)
    {
        c = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"BTC"];
        c.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        c.textLabel.font = [UIFont systemFontOfSize:16];
        c.detailTextLabel.font = [UIFont systemFontOfSize:13];
        c.detailTextLabel.textColor = [UIColor purpleColor];
    }
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    
    c.textLabel.text = dict[@"name"];
    c.detailTextLabel.text = dict[@"info"];
    
    return c;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc;
    
    switch (indexPath.row)
    {
        case 0: {vc = [[DemoAMainVC alloc] init];  break;}
        case 1: {vc = [[DemoBMainVC alloc] init];  break;}
        case 2: {vc = [[DemoCMainVC alloc] init];  break;}
        case 3: {vc = [[DemoDMainVC alloc] init];  break;}
        case 4: {vc = [[DemoEMainVC alloc] init];  break;}
        case 5: {vc = [[DemoFMainVC alloc] init];  break;}
        case 6: {vc = [[DemoGMainVC alloc] init];  break;}
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSArray *)dataArray
{
    if (_dataArray) return _dataArray;
    
    _dataArray = @[
                   @{@"name" : @"DemoA",
                     @"info" : @"UICollectionView柱状图基本方法"},
                   
                   @{@"name" : @"DemoB",
                     @"info" : @"效果一，渐变柱子、点击柱子，动画显示"},
                   
                   @{@"name" : @"DemoC",
                     @"info" : @"效果二，每个柱子滑动后始终停靠屏幕中心线centerX"},
                   
                   @{@"name" : @"DemoD",
                     @"info" : @"效果三，柱子比较密集，手势滑动显示值"},
                   
                   @{@"name" : @"DemoE",
                     @"info" : @"效果四，柱子+曲线，探索无限"},
                   
                   @{@"name" : @"DemoF",
                     @"info" : @"效果五，加上纵坐标、网格线试试"},
                   
                   @{@"name" : @"DemoG",
                     @"info" : @"iOS非侵入式刷新探索(防安卓刷新)"},
                   ];
    
    return _dataArray;
}


@end
