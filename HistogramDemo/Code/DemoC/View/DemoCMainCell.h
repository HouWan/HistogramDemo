//
//  DemoCMainCell.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/3.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BAR_cW 30    // 柱状图Cell宽度
#define BAR_cH 220   // 柱状图高度
#define BAR_pW 16    // 柱子之间的间距，其实用不用这个都可以，根据需求走


NS_ASSUME_NONNULL_BEGIN

@interface DemoCMainCell : UICollectionViewCell

@property (nonatomic, weak) UIView *barView;

- (void)barHeight:(double)height;


@end

NS_ASSUME_NONNULL_END
