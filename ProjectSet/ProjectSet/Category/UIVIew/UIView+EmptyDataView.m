//
//  UIView+EmptyDataView.m
//  ProjectSet
//
//  Created by 陈诚 on 2017/5/24.
//  Copyright © 2017年 iOS_Developer. All rights reserved.
//

#import "UIView+EmptyDataView.h"
#import "Purelayout.h"
#import <objc/runtime.h>

@interface UIView ()

/*
 * 空数据显示的文本框
 */
@property (nonatomic,strong) UILabel *emptyLabel;

@end

static NSString *emptyLabelKey = @"emptyLabel";

@implementation UIView (EmptyDataView)

- (void)setEmptyLabel:(UILabel *)emptyLabel {
    objc_setAssociatedObject(self, &emptyLabelKey, emptyLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)emptyLabel {
    return objc_getAssociatedObject(self, &emptyLabelKey);
}

- (void)showEmptyDataViewWithHintMessage:(NSString *)message offSet:(CGPoint)offSet {
    
    if (!self.emptyLabel) {
        
        UILabel *emptyLabel      = [[UILabel alloc] init];
        emptyLabel.numberOfLines = 0;
        emptyLabel.textAlignment = NSTextAlignmentCenter;
        emptyLabel.textColor     = [UIColor grayColor];
        emptyLabel.font          = [UIFont systemFontOfSize:15];
        [self addSubview:emptyLabel];
        self.emptyLabel = emptyLabel;
        
        [emptyLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:12];
        [emptyLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self withOffset:-12];
        [emptyLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self withOffset:0];
        [emptyLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:offSet.y];
        
    }
    
    self.emptyLabel.text = message;
}

- (void)dismissEmptyView {
    
    [self.emptyLabel removeFromSuperview];
    self.emptyLabel = nil;
}

@end
