//
//  DemoCMainTopView.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/3.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoCMainTopView.h"

#import "DemoHeader.h"

@interface DemoCMainTopView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) DemoCMainCell *tempCell;

@end


@implementation DemoCMainTopView

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
    // 设置行与行之间的间距最小距离，注意这里，如果设置了值，后面就需要参与运算
    fw.minimumLineSpacing = BAR_pW;
    // 设置列与列之间的间距最小距离
    fw.minimumInteritemSpacing = 0;
    fw.itemSize = CGSizeMake(BAR_cW, BAR_cH);
    
    // 这2个的目的是为了让最后一个 第一个都能滑到屏幕ceterX
    fw.headerReferenceSize = CGSizeMake(Screen_Width * 0.5f - BAR_cW * 0.5, BAR_cH);
    fw.footerReferenceSize = CGSizeMake(Screen_Width * 0.5f - BAR_cW * 0.5, BAR_cH);
    
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
    [collectionView registerClass:[DemoCMainCell class] forCellWithReuseIdentifier:@"BTC"];
    
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
    DemoCMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTC" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoCMainCell *c = (DemoCMainCell *)cell;
    
    double t = [self.dataArray[indexPath.item] doubleValue];
    
    [c barHeight:t];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat pageSize = BAR_cW + BAR_pW;
    NSInteger page = roundf(collectionView.contentOffset.x / pageSize);
    
    if (page >= self.dataArray.count || page < 0) return;
    
    DemoCMainCell *c1 = (DemoCMainCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0]];
    
    DemoCMainCell *c2 = (DemoCMainCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (c1 == c2) return;
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
    
    // 代理，懒得判断代理了
    [self.delegate topView:self select:indexPath.row];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGPoint targetOffset = [self nearestTargetOffsetForOffset:*targetContentOffset];
    targetContentOffset->x = targetOffset.x;
    targetContentOffset->y = targetOffset.y;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    CGFloat pageSize = BAR_cW + BAR_pW;
    NSInteger page = roundf(scrollView.contentOffset.x / pageSize);
    
    if (page >= self.dataArray.count || page < 0) return;
    
    // 代理，懒得判断代理了
    [self.delegate topView:self select:page];
}

// 其实我建议在scrollViewDidEndDecelerating处理，
// scrollViewDidScroll太频繁了，看需求吧，这里我两个方法都用了，一个处理代理，一个处理cell
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageSize = BAR_cW + BAR_pW;
    NSInteger page = roundf(scrollView.contentOffset.x / pageSize);
    
    if (page >= self.dataArray.count || page < 0) return;
    
    DemoCMainCell *cell = (DemoCMainCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0]];
    
    // 处理Cell
    self.tempCell.barView.backgroundColor = HWRGBColor(120, 175, 0);
    cell.barView.backgroundColor = [UIColor orangeColor];
    self.tempCell = cell;
}

- (CGPoint)nearestTargetOffsetForOffset:(CGPoint)offset
{
    CGFloat pageSize = BAR_cW + BAR_pW;
    NSInteger page = roundf(offset.x / pageSize);
    
    CGFloat targetX = pageSize * page;
    return CGPointMake(targetX, offset.y);
}

#pragma mark - 刷新数据

- (void)reloadWith:(NSArray *)dataArray
{
    self.dataArray = dataArray;
    [self.collectionView reloadData];
    
    if ([self.delegate respondsToSelector:@selector(topView:select:)]) {
        [self.delegate topView:self select:0];
    }
    
    
    // 这是因为这里赋值时，Cell还没有在屏幕上出现，所以延迟处理以下
    // 实际项目里，根据情况处理
    NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:0];
    
    __weak __typeof(&*self)weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        DemoCMainCell *cell = (DemoCMainCell *)[weakSelf.collectionView cellForItemAtIndexPath:ip];
        cell.barView.backgroundColor = [UIColor orangeColor];
        weakSelf.tempCell = cell;
    });
}






@end
