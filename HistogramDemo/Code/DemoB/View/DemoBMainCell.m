//
//  DemoBMainCell.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/2.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoBMainCell.h"

#import "DemoHeader.h"

@implementation DemoBMainCell


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
    self.contentView.clipsToBounds = YES;
    
    // 测试
    //    self.contentView.layer.borderColor = [HWRandomColor CGColor];
    //    self.contentView.layer.borderWidth = 0.5;
    
    HistogramColorView *barView = [[HistogramColorView alloc] init];
    [self.contentView addSubview:barView];
    self.barView = barView;
    
    UILabel *dateLabel = [UILabel new];
    dateLabel.font = [UIFont systemFontOfSize:12];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:dateLabel];
    self.dateLabel = dateLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.dateLabel.frame = CGRectMake(0,
                                      self.contentView.bounds.size.height - 20,
                                      self.contentView.bounds.size.width,
                                      20);
    self.dateLabel.adjustsFontSizeToFitWidth = YES;
}

- (void)barModel:(HistogramModel *)model maxValue:(double)max
{
    [self barSelect:model.selected];
    
    self.dateLabel.text = model.date;
    
    // 临时赋值frame
    self.barView.frame = CGRectMake(0, BAR_cH - 20, BAR_cW, 0.5);
    
    // 这里 20 是指dateLabel 的高度
    CGFloat h = model.value / max * (BAR_cH - 20);
    if (h < 10) {
        h = 10;  // 防止柱子太低，看不到
    }
    
    CGRect f = CGRectMake(0, BAR_cH - h - 20, BAR_cW, h);
    
    __weak __typeof(&*self)weakSelf = self;
    
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.barView.frame = f;
    }];

}

- (void)barSelect:(BOOL)select
{
    [self.barView select:select];
    self.dateLabel.textColor = select ? [UIColor purpleColor] : [UIColor grayColor];
}


@end
