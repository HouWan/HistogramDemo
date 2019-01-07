//
//  HistogramModel.h
//  HistogramDemo
//
//  Created by 侯万 on 2019/1/3.
//  Copyright © 2019 小侯爷. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistogramModel : NSObject

/// 是否选中此数据
@property (nonatomic, assign, getter=isSelected) BOOL selected;

@property (nonatomic, assign) NSInteger value;

@property (nonatomic, copy) NSString *date;



@end

NS_ASSUME_NONNULL_END
