//
//  DemoGMainVC.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/5.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoGMainVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

/// 导航栏的高度，临时这么算一下，保存一下
@property (nonatomic, assign) CGFloat navHeight;
/// 开始刷新
@property (nonatomic, assign) __block BOOL refreshing;

@end

NS_ASSUME_NONNULL_END
