//
//  DemoEMainCell.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/4.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BAR_cW 30    // 柱状图Cell宽度
#define BAR_cH 220   // 柱状图高度

NS_ASSUME_NONNULL_BEGIN

@interface DemoEMainCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, weak) UIView *barView;

- (void)barHeight:(double)height;

@end

NS_ASSUME_NONNULL_END
