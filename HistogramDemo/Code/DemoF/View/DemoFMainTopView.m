//
//  DemoFMainTopView.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/4.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoFMainTopView.h"

#import "DemoHeader.h"

@interface DemoFMainTopView () <UICollectionViewDelegate, UICollectionViewDataSource>

@end


@implementation DemoFMainTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

#pragma mark - 初始化View
- (void)setupView
{
    self.backgroundColor = App_bgGrey;
    
    CGRect f = CGRectMake(0,0, Screen_Width, BAR_cH);
    
    DemoFMainBgView *bgView = [[DemoFMainBgView alloc] initWithFrame:f];
    [self addSubview:bgView];
    self.bgView = bgView;
    
    UICollectionViewFlowLayout *fw = [[UICollectionViewFlowLayout alloc] init];
    fw.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置行与行之间的间距最小距离
    fw.minimumLineSpacing = 10;
    // 设置列与列之间的间距最小距离
    fw.minimumInteritemSpacing = 0;
    fw.itemSize = CGSizeMake(BAR_cW, BAR_cH);
    
    self.fw = fw;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:f collectionViewLayout:fw];
    collectionView.clipsToBounds = YES;
    collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.alwaysBounceHorizontal = YES;
    collectionView.backgroundColor = [UIColor clearColor];
    if (@available(iOS 11.0, *)) {
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[DemoFMainCell class] forCellWithReuseIdentifier:@"BTC"];
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArray) return self.dataArray.count;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoFMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTC" forIndexPath:indexPath];
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoFMainCell *c = (DemoFMainCell *)cell;
    
    double t = [self.dataArray[indexPath.item] doubleValue];
    
    [c barHeight:t];
}


#pragma mark - 刷新数据

- (void)reloadWith:(NSArray *)dataArray
{
    CGFloat w = (dataArray.count * BAR_cW) + (dataArray.count - 1) * self.fw.minimumLineSpacing;
    
    if (w > Screen_Width) {
        self.fw.headerReferenceSize = CGSizeMake(self.fw.minimumLineSpacing, BAR_cH);
        self.fw.footerReferenceSize = CGSizeMake(self.fw.minimumLineSpacing, BAR_cH);
    } else {
        self.fw.headerReferenceSize = CGSizeMake((Screen_Width - w) * 0.5, BAR_cH);
        self.fw.footerReferenceSize = CGSizeMake((Screen_Width - w) * 0.5, BAR_cH);
    }
    
    self.dataArray = dataArray;
    [self.collectionView reloadData];
}





@end
