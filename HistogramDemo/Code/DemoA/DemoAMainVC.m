//
//  DemoAMainVC.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/2.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoAMainVC.h"

// --------------------------Other--------------------------
#import "DemoHeader.h"

// --------------------------View--------------------------
#import "DemoAMainTopView.h"

@interface DemoAMainVC ()

@property (nonatomic, weak) DemoAMainTopView *topView;

@end

@implementation DemoAMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"基础版";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGRect f = CGRectMake(0, 120, Screen_Width, BAR_cH);
    
    DemoAMainTopView *topView = [[DemoAMainTopView alloc] initWithFrame:f];
    [self.view addSubview:topView];
    self.topView = topView;
    
    [self refreshView];
//    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    btn.layer.borderColor = [HWRandomColor CGColor];
//    btn.layer.borderWidth = 0.5;
//    btn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
//    [btn setTitle:@"刷新" forState:(UIControlStateNormal)];
//    [btn addTarget:self action:@selector(clickRefreshBtn) forControlEvents:(UIControlEventTouchUpInside)];
//    btn.frame = CGRectMake(20, 400, 100, 30);
//    [self.view addSubview:btn];
}


- (void)refreshView
{
    NSArray *arr = [self xxoo];
    
    [self.topView reloadWith:arr];;
}


- (NSArray *)xxoo
{
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:150];
    
    for (int i = 0; i < 150; i++)
    {
        // 1 - BAR_cH 之间的随机数，充当每个柱状图柱子的代表值
        NSInteger xx = (long)(1 + (arc4random() % BAR_cH));
        [dataArray addObject:@(xx)];
    }
    
    return dataArray;
}



@end
