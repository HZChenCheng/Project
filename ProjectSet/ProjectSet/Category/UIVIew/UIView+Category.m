//
//  UIView+Category.m
//  iOS分类添加属性
//
//  Created by 陈诚 on 2017/5/22.
//  Copyright © 2017年 iOS_Developer. All rights reserved.
//

#import "UIView+Category.h"
#import <objc/runtime.h>

static NSString *offsetKey = @"offset";
static NSString *nameKey   = @"name";
static NSString *pointKey  = @"pointKey";

@implementation UIView (Category)

/*
 * 添加基本数据类型需要转化为NSNumber类型
 */

- (void)setOffset:(CGFloat)offset {
    
    // 给某个对象产生关联，添加属性
    // object:给哪个对象添加属性
    // key:属性名,根据key去获取关联的对象 ,void * == id
    // value:关联的值
    // policy:策越
    
    objc_setAssociatedObject(self, &offsetKey, @(offset), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)offset {
    
    NSNumber *numberValue = objc_getAssociatedObject(self, &offsetKey);
    return [numberValue intValue];
    
}

/*
 * 对象类型
 */
- (void)setName:(NSString *)name {
    
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name {
    
    return objc_getAssociatedObject(self, &nameKey);
}

/*
 * 添加结构体属性
 * 需要包装成NSValue
 */
- (void)setPoint:(CGPoint)point {
    
    NSValue *value = [NSValue value:&point withObjCType:@encode(CGPoint)];
    objc_setAssociatedObject(self,&pointKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (CGPoint)point {
    
    NSValue *value = objc_getAssociatedObject(self, &pointKey);
    if(value) {
        CGPoint point;
        [value getValue:&point];
        return point;
    }else {
        return CGPointZero;
    }
    
}

@end
