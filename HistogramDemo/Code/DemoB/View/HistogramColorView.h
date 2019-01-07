//
//  HistogramColorView.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/3.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 * 渐变色View
 */
@interface HistogramColorView : UIView

@property (nonatomic, weak) UIImageView *colorView;

- (void)select:(BOOL)select;

@end

NS_ASSUME_NONNULL_END
