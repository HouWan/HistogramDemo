//
//  DemoGMainVC.m
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/5.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import "DemoGMainVC.h"

// --------------------------Other--------------------------
#import "DemoHeader.h"

// --------------------------View--------------------------
#import "DemoGScrollView.h"

// --------------------------VC--------------------------
#import "DemoAMainVC.h"

@interface DemoGMainVC ()

@property (nonatomic, weak) DemoGScrollView *refreshView;

@property (nonatomic, weak) UIActivityIndicatorView *indView;

@end

@implementation DemoGMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"非侵入刷新";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navHeight = [DemoGMainVC isIphoneX] ? 88.f : 64.f;
    CGRect f = CGRectMake(0, self.navHeight, Screen_Width, Screen_Height - self.navHeight);
    
    // 1.添加UITableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:f style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.bounces = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BTC"];
    
    // 2.添加DemoGScrollView
    DemoGScrollView *refreshView = [[DemoGScrollView alloc] initWithFrame:f];
    refreshView.eventView = tableView;
    refreshView.delegate = self;
    [self.view addSubview:refreshView];
    self.refreshView = refreshView;
    
    
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        refreshView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    
    // 3.添加菊花
    UIActivityIndicatorView *indView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
    indView.backgroundColor = [UIColor yellowColor];
    indView.frame = CGRectMake((Screen_Width - 60) / 2, self.navHeight - 60, 60, 60);
    indView.hidesWhenStopped = NO;
    [self.view addSubview:indView];
    self.indView = indView;
    
    // 4.测试
    refreshView.layer.borderColor = [HWRandomColor CGColor];
    refreshView.layer.borderWidth = 0.5;
    
    indView.layer.borderColor = [HWRandomColor CGColor];
    indView.layer.borderWidth = 2;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 重要，应该始终让refreshView的contentSize跟tableView保持一致
    // 20个cell 50高度
    // 这里直接这么写了，建议通过UITableViewDataSource，获取Size
    self.refreshView.contentSize = CGSizeMake(Screen_Width, 20 * 50);
}


#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *c = [tableView dequeueReusableCellWithIdentifier:@"BTC" forIndexPath:indexPath];
    
    c.textLabel.text = [NSString stringWithFormat:@"点我跳转VC--->%ld",indexPath.row];
    c.textLabel.textColor = [UIColor purpleColor];
    c.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return c;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DemoAMainVC *vc = [[DemoAMainVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - [DemoGScrollView]

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < 0) {
        
        if (self.refreshing) return;
        
        if (self.indView.hidden) self.indView.hidden = NO;
        
        [self.indView stopAnimating];
        
        if (offsetY >= -150) {
            
            CGFloat y = self.navHeight - 60 + fabs(offsetY);
            self.indView.frame = CGRectMake((Screen_Width - 60) / 2, y, 60, 60);
        
        } else {
            [self.indView startAnimating];
        }
        
    } else {
        self.tableView.contentOffset = scrollView.contentOffset;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == self.tableView) return;
    
    // 下拉到底，松手就可以刷新数据
    if (decelerate && scrollView.contentOffset.y <= -150)
    {
        self.refreshing = YES;
        
        __weak __typeof(&*self)weakSelf = self;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.refreshing = NO;
            weakSelf.indView.frame = CGRectMake((Screen_Width - 60) / 2, weakSelf.navHeight - 60, 60, 60);
            [weakSelf.indView stopAnimating];
        });
    }
}






#pragma mark - 是否是iPhone X系列
+ (BOOL)isIphoneX
{
    // 利用safeAreaInsets.bottom > 0.0来判断是否是iPhone X。
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        return mainWindow.safeAreaInsets.bottom > 0;
    }
    return NO;
}




@end
