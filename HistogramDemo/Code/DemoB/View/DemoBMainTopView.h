//
//  DemoBMainTopView.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/2.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

// --------------------------View--------------------------
#import "DemoBMainCell.h"
@class DemoBMainTopView;


@protocol DemoBMainTopViewDelegate <NSObject>

- (void)topView:(DemoBMainTopView *)topView select:(NSInteger)row;

@end


NS_ASSUME_NONNULL_BEGIN

@interface DemoBMainTopView : UIView


// --------------------------UI--------------------------

@property (nonatomic, weak) UICollectionView *collectionView;


// --------------------------Data--------------------------
/// 数据
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) double max;

@property (nonatomic, weak) id<DemoBMainTopViewDelegate> delegate;

// --------------------------Medhod--------------------------

- (void)reloadWith:(NSArray *)dataArray max:(double)max;



@end

NS_ASSUME_NONNULL_END
