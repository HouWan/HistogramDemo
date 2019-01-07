//
//  DemoBMainTopView.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/2.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoBMainTopView.h"

#import "DemoHeader.h"

@interface DemoBMainTopView () <UICollectionViewDelegate, UICollectionViewDataSource>

// ----------------------------Data----------------------------
/// 当前点击的第几个柱状图
@property (nonatomic, assign) NSInteger clickIndex;

@end


@implementation DemoBMainTopView

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
    
    UICollectionViewFlowLayout *fw = [[UICollectionViewFlowLayout alloc] init];
    fw.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置行与行之间的间距最小距离
    fw.minimumLineSpacing = 10;
    // 设置列与列之间的间距最小距离
    fw.minimumInteritemSpacing = 0;
    fw.itemSize = CGSizeMake(BAR_cW, BAR_cH);
    
    fw.headerReferenceSize = CGSizeMake(10, BAR_cH);
    fw.footerReferenceSize = CGSizeMake(10, BAR_cH);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, Screen_Width, BAR_cH) collectionViewLayout:fw];
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
    [collectionView registerClass:[DemoBMainCell class] forCellWithReuseIdentifier:@"BTC"];
    
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
    DemoBMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTC" forIndexPath:indexPath];
    
    return cell;
}
    
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoBMainCell *c = (DemoBMainCell *)cell;
    
    HistogramModel *m = self.dataArray[indexPath.item];
    
    [c barModel:m maxValue:self.max];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 这里这么麻烦些，是为了动画，如果直接改变模型reloadData，会出现动画问题，你可以试试
    if (indexPath.item == self.clickIndex) return;
    
    // 1.改变老数据
    NSIndexPath *inp = [NSIndexPath indexPathForItem:self.clickIndex inSection:0];
    DemoBMainCell *c1 = (DemoBMainCell *)[collectionView cellForItemAtIndexPath:inp];
    [c1 barSelect:NO];
    
    HistogramModel *m1 = [self.dataArray objectAtIndex:self.clickIndex];
    m1.selected = NO;
    
    // 2.改变新数据
    HistogramModel *m2 = [self.dataArray objectAtIndex:indexPath.item];
    m2.selected = YES;
    
    DemoBMainCell *c2 = (DemoBMainCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [c2 barSelect:YES];
    
    self.clickIndex = indexPath.item;

    // 3.代理走一波
    if ([self.delegate respondsToSelector:@selector(topView:select:)]) {
        [self.delegate topView:self select:indexPath.row];
    }
}

#pragma mark - 刷新数据

- (void)reloadWith:(NSArray *)dataArray max:(double)max
{
    self.dataArray = dataArray;
    self.max = max;

    [self.collectionView reloadData];
    
    // 默认选中第一个
    self.clickIndex = 0;
    HistogramModel *m = [dataArray firstObject];
    m.selected = YES;
    
    if ([self.delegate respondsToSelector:@selector(topView:select:)]) {
        [self.delegate topView:self select:0];
    }
}


@end
