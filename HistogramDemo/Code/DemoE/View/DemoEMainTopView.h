//
//  DemoEMainTopView.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/4.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

// --------------------------View--------------------------
#import "DemoEMainCell.h"
#import "DemoEMainLineView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoEMainTopView : UIView

// --------------------------UI--------------------------

@property (nonatomic, weak) UICollectionView *collectionView;

@property (nonatomic, weak) DemoEMainLineView *lineView;


// --------------------------Data--------------------------
/// 数据
@property (nonatomic, strong) NSArray *dataArray;


// --------------------------Medhod--------------------------

- (void)reloadWith:(NSArray *)dataArray;


@end

NS_ASSUME_NONNULL_END
