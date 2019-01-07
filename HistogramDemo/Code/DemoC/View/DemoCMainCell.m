//
//  DemoCMainCell.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/3.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoCMainCell.h"

#import "DemoHeader.h"

@implementation DemoCMainCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - 初始化View
- (void)setupView
{
    self.contentView.backgroundColor = HWRGBColor(245, 245, 245);
    
    UIView *barView = [UIView new];
    barView.backgroundColor = HWRGBColor(120, 175, 0);
    [self.contentView addSubview:barView];
    self.barView = barView;
    
}

- (void)barHeight:(double)height
{
    if (height < 10) {
        height = 10;
    }
    
    if (height > BAR_cH) {
        height = BAR_cH;
    }
    
    self.barView.frame = CGRectMake(0, BAR_cH - height, BAR_cW, height);
}

@end
