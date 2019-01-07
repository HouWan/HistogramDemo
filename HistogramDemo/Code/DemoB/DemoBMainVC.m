//
//  DemoBMainVC.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/2.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoBMainVC.h"

// --------------------------Other--------------------------
#import "DemoHeader.h"

// --------------------------View--------------------------
#import "DemoBMainTopView.h"

@interface DemoBMainVC () <DemoBMainTopViewDelegate>

@property (nonatomic, weak) DemoBMainTopView *topView;

@property (nonatomic, weak) UILabel *valueLabel;

/// 充当数据模型数组
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation DemoBMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"效果一";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect f = CGRectMake(0, 120, Screen_Width, BAR_cH);
    
    DemoBMainTopView *topView = [[DemoBMainTopView alloc] initWithFrame:f];
    topView.delegate = self;
    [self.view addSubview:topView];
    self.topView = topView;
    
    
    UILabel *valueLabel = [UILabel new];
    valueLabel.textColor = [UIColor blueColor];
    valueLabel.font = [UIFont boldSystemFontOfSize:16];
    valueLabel.textAlignment = NSTextAlignmentCenter;
    valueLabel.frame = CGRectMake(0, 400, Screen_Width, 25);
    [self.view addSubview:valueLabel];
    self.valueLabel = valueLabel;
    
    [self refreshView];
}

- (void)refreshView
{
    // 1.网络请求数据
    self.dataArray = [self xxoo];
    
    // 2.找最大值
    double max = 0;
    for (HistogramModel *m in self.dataArray) {
        if (m.value > max) {
            max = m.value;
        }
    }
    
    [self.topView reloadWith:self.dataArray max:max];
}



#pragma mark - DemoBMainTopViewDelegate

- (void)topView:(DemoBMainTopView *)topView select:(NSInteger)row
{
    HistogramModel *m = self.dataArray[row];
    self.valueLabel.text = [NSString stringWithFormat:@"选中：%@年---值是：%ld",
                            m.date,(long)m.value];
}


#pragma mark - 充当网络请求
- (NSArray *)xxoo
{
    NSMutableArray *dataArray = [NSMutableArray arrayWithCapacity:50];
    
    for (int i = 0; i < 50; i++)
    {
        // 1 - 500 之间的随机数，充当每个柱状图柱子的代表值
        
        HistogramModel *m = [HistogramModel new];
        m.value = (long)(1 + (arc4random() % 500));
        m.date = [NSString stringWithFormat:@"%ld",(long)(2019 - 50 + i)];

        [dataArray addObject:m];
    }
    
    return dataArray;
}


@end
