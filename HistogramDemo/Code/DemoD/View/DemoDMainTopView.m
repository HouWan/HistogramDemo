//
//  DemoDMainTopView.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/3.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoDMainTopView.h"

#import "DemoHeader.h"

@interface DemoDMainTopView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) DemoDMainCell *tempCell;

@end


@implementation DemoDMainTopView

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
    self.exclusiveTouch = YES;
    
    UICollectionViewFlowLayout *fwLayout = [[UICollectionViewFlowLayout alloc] init];
    fwLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    fwLayout.minimumLineSpacing = BAR_pW;
    fwLayout.minimumInteritemSpacing = 0;
    fwLayout.itemSize = CGSizeMake(BAR_cW, BAR_cH);
    self.fwLayout = fwLayout;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,0, Screen_Width, BAR_cH) collectionViewLayout:fwLayout];
    collectionView.clipsToBounds = YES;
    collectionView.bounces = NO;
    collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.userInteractionEnabled = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    if (@available(iOS 11.0, *)) {
        collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[DemoDMainCell class] forCellWithReuseIdentifier:@"BTC"];
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [self addSubview:redView];
    self.redView = redView;
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataArray) return self.dataArray.count;
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoDMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BTC" forIndexPath:indexPath];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    DemoDMainCell *c = (DemoDMainCell *)cell;
    
    c.index = indexPath.row;
    
    double t = [self.dataArray[indexPath.item] doubleValue];
    [c barHeight:t];
}


#pragma mark - 刷新数据

- (void)reloadWith:(NSArray *)dataArray
{
    self.dataArray = dataArray;
    
    NSInteger c = dataArray.count;
    CGFloat w = (Screen_Width - c * BAR_cW - (c - 1) * BAR_pW) * 0.5;
    
    self.fwLayout.headerReferenceSize = CGSizeMake(w, BAR_cH);
    self.fwLayout.footerReferenceSize = CGSizeMake(w, BAR_cH);
    
    [self.collectionView reloadData];
}



#pragma mark - 处理几个UITouch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (event.type != UIEventTypeTouches) return;

    UITouch *t1 = touches.allObjects.firstObject;
    CGPoint p = [t1 locationInView:self];
    self.redView.frame = CGRectMake(p.x, 0, 1, BAR_cH);
    
    self.redView.hidden = NO;
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (event.type != UIEventTypeTouches) return;
    
    UITouch *t1 = touches.allObjects.firstObject;
    CGPoint p = [t1 locationInView:self];
    self.redView.frame = CGRectMake(p.x, 0, 1, BAR_cH);
    
    NSInteger c = self.dataArray.count;
    CGFloat w = (Screen_Width - c * BAR_cW - (c - 1) * BAR_pW) * 0.5;
    
    if (p.x < w || p.x > (Screen_Width - w)) return;
    
    DemoDMainCell *cell = [self cellWithTouchPoint:p];
    
    if (cell == nil)  return;
    
    if (cell == self.tempCell) return;
    
    self.tempCell.barView.backgroundColor = HWRGBColor(120, 175, 0);
    cell.barView.backgroundColor = [UIColor orangeColor];
    self.tempCell = cell;
    
    [self.delegate topView:self select:cell.index];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.redView.hidden = YES;
    self.tempCell.barView.backgroundColor = HWRGBColor(120, 175, 0);
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.redView.hidden = YES;
    self.tempCell.barView.backgroundColor = HWRGBColor(120, 175, 0);
}


- (DemoDMainCell *)cellWithTouchPoint:(CGPoint)point
{
    for (DemoDMainCell *cell in self.collectionView.subviews)
    {
        if (CGRectContainsPoint(cell.frame, point)) {
            return cell;
        }
    }
    return nil;
}



@end
