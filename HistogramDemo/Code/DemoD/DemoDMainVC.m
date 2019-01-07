//
//  DemoDMainVC.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/3.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoDMainVC.h"


// --------------------------Other--------------------------
#import "DemoHeader.h"

// --------------------------View--------------------------
#import "DemoDMainTopView.h"


@interface DemoDMainVC () <DemoDMainTopViewDelegate>

@property (nonatomic, weak) DemoDMainTopView *topView;

@property (nonatomic, weak) UILabel *valueLabel;

/// 充当数据模型数组
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DemoDMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"效果三";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect f = CGRectMake(0, 120, Screen_Width, BAR_cH);
    
    DemoDMainTopView *topView = [[DemoDMainTopView alloc] initWithFrame:f];
    topView.delegate = self;
    [self.view addSubview:topView];
    self.topView = topView;
    
    
    UILabel *valueLabel = [UILabel new];
    valueLabel.textColor = [UIColor blueColor];
    valueLabel.font = [UIFont boldSystemFontOfSize:16];
    valueLabel.textAlignment = NSTextAlignmentCenter;
    valueLabel.frame = CGRectMake(0, 345, Screen_Width, 25);
    [self.view addSubview:valueLabel];
    self.valueLabel = valueLabel;
    
    [self refreshView];
}


- (void)refreshView
{
    // 1.网络请求数据
    self.dataArray = [self xxoo];
    
    [self.topView reloadWith:self.dataArray];
}



#pragma mark - DemoBMainTopViewDelegate

- (void)topView:(DemoDMainTopView *)topView select:(NSInteger)row
{
    NSInteger v = [self.dataArray[row] integerValue];
    
    self.valueLabel.text = [NSString stringWithFormat:@"选中第%ld个---值是：%ld",
                            (long)row,(long)v];
}


- (NSArray *)xxoo
{
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:20];
    
    for (int i = 0; i < 20; i++)
    {
        // 1 - BAR_cH 之间的随机数，充当每个柱状图柱子的代表值
        NSInteger xx = (long)(1 + (arc4random() % BAR_cH));
        [dataArray addObject:@(xx)];
    }
    
    return dataArray;
}





@end
