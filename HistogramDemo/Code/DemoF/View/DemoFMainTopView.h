//
//  DemoFMainTopView.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/4.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

// --------------------------View--------------------------
#import "DemoFMainCell.h"
#import "DemoFMainBgView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoFMainTopView : UIView

// --------------------------UI--------------------------

@property (nonatomic, weak) DemoFMainBgView *bgView;

@property (nonatomic, weak) UICollectionViewFlowLayout *fw;

@property (nonatomic, weak) UICollectionView *collectionView;


// --------------------------Data--------------------------
/// 数据
@property (nonatomic, strong) NSArray *dataArray;


// --------------------------Medhod--------------------------

- (void)reloadWith:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
