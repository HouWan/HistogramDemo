//
//  DemoAMainTopView.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/2.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

// --------------------------View--------------------------
#import "DemoAMainCell.h"



NS_ASSUME_NONNULL_BEGIN

@interface DemoAMainTopView : UIView


// --------------------------UI--------------------------

@property (nonatomic, weak) UICollectionView *collectionView;


// --------------------------Data--------------------------
/// 数据
@property (nonatomic, strong) NSArray *dataArray;


// --------------------------Medhod--------------------------

- (void)reloadWith:(NSArray *)dataArray;


@end

NS_ASSUME_NONNULL_END
