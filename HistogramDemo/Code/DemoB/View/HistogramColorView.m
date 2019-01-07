//
//  HistogramColorView.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/3.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "HistogramColorView.h"

#import "DemoBMainCell.h"

@interface HistogramColorView ()

@property (nonatomic, weak) CAShapeLayer *colorMask;

@end


@implementation HistogramColorView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - 初始化View
- (void)setupView
{
    self.clipsToBounds = YES;
    
    UIImageView *colorView = [[UIImageView alloc] init];
    colorView.clipsToBounds = YES;
    colorView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:colorView];
    self.colorView = colorView;
    
    CAShapeLayer *colorMask = [[CAShapeLayer alloc] init];
    colorView.layer.mask = colorMask;
    self.colorMask = colorMask;
    
    [self screenshot];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.bounds.size.height < 1) {
        self.colorView.hidden = YES;
        return;
    }
    
    self.colorView.hidden = NO;
    self.colorView.frame = self.bounds;
    
    CGRect f = self.bounds;
    
    CGSize s = CGSizeMake(self.bounds.size.width * 0.5, self.bounds.size.width * 0.5);
    
    // 圆角
    UIBezierPath *path= [UIBezierPath bezierPathWithRoundedRect:f byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:s];
    self.colorMask.path = path.CGPath;
}

// 这里渐变色，使用截图的方式，而不是直接CAGradientLayer，是因为动画原因
- (void)screenshot
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, BAR_cW, BAR_cH);
    gradientLayer.colors = @[(__bridge id)[UIColor orangeColor].CGColor,
                             (__bridge id)[UIColor purpleColor].CGColor];
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    
    CGSize s = gradientLayer.frame.size;
    
    UIGraphicsBeginImageContextWithOptions(s, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (context == nil) {
        self.colorView.backgroundColor = [UIColor redColor];
        return;
    }
    
    [gradientLayer renderInContext:context];
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.colorView.image = imageOut;
}


- (void)select:(BOOL)select
{
    if (select) {
        self.colorView.image = nil;
        self.colorView.backgroundColor = [UIColor cyanColor];
    } else {
        [self screenshot];
        self.colorView.backgroundColor = [UIColor clearColor];
    }
}



@end
