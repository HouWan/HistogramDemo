//
//  DemoFMainBgView.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/4.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoFMainBgView.h"

@implementation DemoFMainBgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - 初始化View
- (void)setupView
{
    // 其实绘制线，有很多方法，这里就简单使用CALayer代替了
    
    CGFloat w = self.frame.size.width - 30 - 30;
    CGFloat gap = self.frame.size.height / 4.0;
    
    for (int i = 0; i < 3; i++)
    {
        CALayer *spLayer = [CALayer new];
        spLayer.backgroundColor = [UIColor redColor].CGColor;
        spLayer.frame = CGRectMake(30, gap * (i + 1), w, 0.5);
        [self.layer addSublayer:spLayer];
        

        CGFloat y = gap * (i + 1) - 10;
        
        UILabel *label = [UILabel new];
        label.text = [NSString stringWithFormat:@"%d",(100 - ((i + 1) * 20))];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor purpleColor];
        label.frame = CGRectMake(0, y, 30, 20);
        [self addSubview:label];
    }
}

@end
