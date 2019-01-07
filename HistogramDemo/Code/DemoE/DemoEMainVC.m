//
//  DemoEMainVC.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/4.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoEMainVC.h"


// --------------------------Other--------------------------
#import "DemoHeader.h"

// --------------------------View--------------------------
#import "DemoEMainTopView.h"

@interface DemoEMainVC ()

@property (nonatomic, weak) DemoEMainTopView *topView;

@end

@implementation DemoEMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"效果四";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    CGRect f = CGRectMake(0, 120, Screen_Width, BAR_cH);
    
    DemoEMainTopView *topView = [[DemoEMainTopView alloc] initWithFrame:f];
    [self.view addSubview:topView];
    self.topView = topView;
    
    [self refreshView];
}


- (void)refreshView
{
    // 1.网络请求
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
