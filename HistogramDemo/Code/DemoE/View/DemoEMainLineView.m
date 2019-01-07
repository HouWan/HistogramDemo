//
//  DemoEMainLineView.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/4.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoEMainLineView.h"

@implementation DemoEMainLineView

#pragma mark - 触摸事件处理
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.eventView && [self pointInside:point withEvent:event])
    {
        CGPoint newPoint = [self convertPoint:point toView:self.eventView];
        UIView *test = [self.eventView hitTest:newPoint withEvent:event];
        if (test) {
            return test;
        } else {
            return self.eventView;
        }
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - 初始化View

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

- (void)setupView
{
    CAShapeLayer *chartLine = [CAShapeLayer layer];
    chartLine.lineCap     = kCALineCapRound;
    chartLine.lineJoin    = kCALineJoinRound;
    chartLine.fillColor   = [[UIColor clearColor] CGColor];
    chartLine.strokeColor = [[UIColor redColor] CGColor];
    chartLine.lineWidth   = 2;
    [self.layer addSublayer:chartLine];
    self.chartLine = chartLine;
}

#pragma mark - 绘制
- (void)strokeChart:(NSArray *)pointsArray
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 2;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    
    for (NSInteger i = 0; i < pointsArray.count; i++)
    {
        CGPoint p = [pointsArray[i] CGPointValue];
        
        if (i == 0) {
            [path moveToPoint:p];
        } else {
            [path addCurveToPoint:p controlPoint1:CGPointMake((p.x + self.previousPoint.x)/2.0, self.previousPoint.y) controlPoint2:CGPointMake((p.x + self.previousPoint.x)/2.0, p.y)];
        }
        self.previousPoint = p;
    }
    
    self.chartLine.path = [path CGPath];
}




@end
