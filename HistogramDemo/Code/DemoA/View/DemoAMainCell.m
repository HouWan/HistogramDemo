//
//  DemoAMainCell.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/2.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoAMainCell.h"

#import "DemoHeader.h"

@implementation DemoAMainCell

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
    self.contentView.backgroundColor = [UIColor clearColor];
    
    // 测试
//    self.contentView.layer.borderColor = [HWRandomColor CGColor];
//    self.contentView.layer.borderWidth = 0.5;
    
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
