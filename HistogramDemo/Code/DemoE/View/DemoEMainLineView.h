//
//  DemoEMainLineView.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/4.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 绘制曲线
 */
@interface DemoEMainLineView : UIView


// --------------------------UI--------------------------

@property (nonatomic, weak) UIView *eventView;

@property (nonatomic, weak) CAShapeLayer *chartLine;


// --------------------------Data--------------------------

@property (nonatomic, assign) CGPoint previousPoint;



// --------------------------Medhod--------------------------

#pragma mark - 绘制
- (void)strokeChart:(NSArray *)pointsArray;



@end

NS_ASSUME_NONNULL_END
