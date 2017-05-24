//
//  UIView+Category.h
//  iOS分类添加属性
//
//  Created by 陈诚 on 2017/5/22.
//  Copyright © 2017年 iOS_Developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

/*
 * 基本数据类型
 */
@property (nonatomic,assign) CGFloat offset;

/*
 * 对象类型
 */
@property (nonatomic,copy)   NSString *name;

/*
 * 结构体(CGPoint)
 */
@property (nonatomic,assign) CGPoint point;

@end
