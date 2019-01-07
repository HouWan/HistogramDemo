//
//  DemoBMainCell.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/2.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HistogramColorView.h"

#define BAR_cW 30    // 柱状图Cell宽度
#define BAR_cH 220   // 柱状图高度


NS_ASSUME_NONNULL_BEGIN

@interface DemoBMainCell : UICollectionViewCell

@property (nonatomic, weak) HistogramColorView *barView;

@property (nonatomic, weak) UILabel *dateLabel;

- (void)barModel:(id)model maxValue:(double)max;

- (void)barSelect:(BOOL)select;

@end

NS_ASSUME_NONNULL_END
