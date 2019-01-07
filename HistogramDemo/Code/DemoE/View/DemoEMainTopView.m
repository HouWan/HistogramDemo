//
//  DemoEMainTopView.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/4.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoEMainTopView.h"

#import "DemoHeader.h"

@interface DemoEMainTopView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray *pointArray;

@end

@implementation DemoEMainTopView

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
    self.clipsToBounds = YES;
    self.backgroundColor = App_bgGrey;
    self.pointArray = [NSMutableArray array];
    
    UICollectionViewFlowLayout *fw = [[UICollectionViewFlowLayout alloc] init];
    fw.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置行与行之间的间距最小距离
    fw.minimumLineSpacing = 10;
    // 设置列与列之间的间距最小距离
    fw.minimumInteritemSpacing = 0;
    fw.itemSize = CGSizeMake(BAR_cW, BAR_cH);
    
    fw.headerReferenceSize = CGSizeMake(10, BAR_cH);
    fw.footerReferenceSize = CGSizeMake(10, BAR_cH);
    
    // 注意，这里故意这样做的，目的是绘制不会在cell出现之前断开，你可以改改试试
    CGRect f = CGRectMake(-15,0, Screen_Width + 30, BAR_cH);
    
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
    [collectionView registerClass:[DemoEMainCell class] forCellWithReuseIdentifier:@"BTC"];
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;

    
    // 注意这里，lineView其实是完整覆盖在collectionView上面的
    DemoEMainLineView *lineView = [[DemoEMainLineView alloc] initWithFrame:f];
    lineView.eventView = collectionView;
    [self addSubview:lineView];
    self.lineView = lineView;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArray) return self.dataArray.count;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoEMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTC" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoEMainCell *c = (DemoEMainCell *)cell;
    c.index = indexPath.item;
    
    double t = [self.dataArray[indexPath.item] doubleValue];
    [c barHeight:t];
}

// 动态绘制曲线
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSArray<DemoEMainCell *> *arr = [self.collectionView visibleCells];
    
    // 注意，collection的visibleCells，是无序的，需要排序
    NSArray *sortArr = [arr sortedArrayUsingComparator:^NSComparisonResult(DemoEMainCell *obj1, DemoEMainCell *obj2) {
        
        if (obj1.index > obj2.index) {
            return NSOrderedDescending;
        } else {
            return NSOrderedAscending;
        }
    }];
    
    [self.pointArray removeAllObjects];
    
    for (int i = 0; i < sortArr.count; i++)
    {
        DemoEMainCell *c = sortArr[i];
        CGRect r = [c.barView convertRect:c.barView.bounds toView:self.lineView];
   
        CGPoint p = CGPointMake(r.origin.x + r.size.width * 0.5,
                                r.origin.y + 5);  // 这只是随便定的点，只是为了演示
        
        [self.pointArray addObject:[NSValue valueWithCGPoint:p]];
    }
    
    [self.lineView strokeChart:self.pointArray];
}

#pragma mark - 刷新数据

- (void)reloadWith:(NSArray *)dataArray
{
    self.dataArray = dataArray;
    [self.collectionView reloadData];
}

@end
