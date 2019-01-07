//
//  DemoDMainCell.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/3.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BAR_cW 10    // 柱状图Cell宽度
#define BAR_cH 220   // 柱状图高度
#define BAR_pW 4     // 柱子之间的间距

NS_ASSUME_NONNULL_BEGIN

@interface DemoDMainCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, weak) UIView *barView;

- (void)barHeight:(double)height;


@end

NS_ASSUME_NONNULL_END
