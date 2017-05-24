//
//  UIView+EmptyDataView.h
//  ProjectSet
//
//  Created by 陈诚 on 2017/5/24.
//  Copyright © 2017年 iOS_Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EmptyDataView)

/*
 * 数据为空时的提醒视图
 */
- (void)showEmptyDataViewWithHintMessage:(NSString *)message
                                  offSet:(CGPoint)offSet;

/*
 * 移除提醒视图
 */
- (void)dismissEmptyView;

@end
