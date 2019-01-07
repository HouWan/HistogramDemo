//
//  DemoCMainTopView.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/3.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>


// --------------------------View--------------------------
#import "DemoCMainCell.h"
@class DemoCMainTopView;


@protocol DemoCMainTopViewDelegate <NSObject>

- (void)topView:(DemoCMainTopView *)topView select:(NSInteger)row;

@end

NS_ASSUME_NONNULL_BEGIN

@interface DemoCMainTopView : UIView

// --------------------------UI--------------------------

@property (nonatomic, weak) UICollectionView *collectionView;


// --------------------------Data--------------------------
/// 数据
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) id<DemoCMainTopViewDelegate> delegate;

// --------------------------Medhod--------------------------

- (void)reloadWith:(NSArray *)dataArray;


@end

NS_ASSUME_NONNULL_END
