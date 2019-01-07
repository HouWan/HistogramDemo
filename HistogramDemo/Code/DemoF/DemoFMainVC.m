//
//  DemoFMainVC.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/4.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoFMainVC.h"

// --------------------------Other--------------------------
#import "DemoHeader.h"

// --------------------------View--------------------------
#import "DemoFMainTopView.h"

@interface DemoFMainVC ()

@property (nonatomic, weak) DemoFMainTopView *topView;

@end

@implementation DemoFMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"效果五";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect f = CGRectMake(0, 120, Screen_Width, BAR_cH);
    
    DemoFMainTopView *topView = [[DemoFMainTopView alloc] initWithFrame:f];
    [self.view addSubview:topView];
    self.topView = topView;
    
    [self refreshView];
    
}

- (void)refreshView
{
    NSArray *arr = [self xxoo];
    
    [self.topView reloadWith:arr];;
}


- (NSArray *)xxoo
{
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:6];
    
    for (int i = 0; i < 6; i++)
    {
        // 1 - BAR_cH 之间的随机数，充当每个柱状图柱子的代表值
        NSInteger xx = (long)(1 + (arc4random() % BAR_cH));
        [dataArray addObject:@(xx)];
    }
    
    return dataArray;
}


@end
