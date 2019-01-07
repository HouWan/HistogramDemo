//
//  DemoDMainTopView.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/3.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoDMainCell.h"
@class DemoDMainTopView;

NS_ASSUME_NONNULL_BEGIN


@protocol DemoDMainTopViewDelegate <NSObject>

- (void)topView:(DemoDMainTopView *)topView select:(NSInteger)row;

@end


@interface DemoDMainTopView : UIView

// --------------------------UI--------------------------

@property (nonatomic, weak) UICollectionViewFlowLayout *fwLayout;

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) UIView *redView;

// --------------------------Data--------------------------
/// 数据
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) id<DemoDMainTopViewDelegate> delegate;


// --------------------------Medhod--------------------------

- (void)reloadWith:(NSArray *)dataArray;




@end

NS_ASSUME_NONNULL_END
