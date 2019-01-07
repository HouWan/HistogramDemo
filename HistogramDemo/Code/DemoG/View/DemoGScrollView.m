//
//  DemoGScrollView.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/5.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoGScrollView.h"

@implementation DemoGScrollView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.eventView touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.eventView touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.eventView touchesCancelled:touches withEvent:event];
    [super touchesCancelled:touches withEvent:event];
}


@end
