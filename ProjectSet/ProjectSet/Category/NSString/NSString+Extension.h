//
//  NSString+Extension.h
//  ProjectSet
//
//  Created by 陈诚 on 2017/5/25.
//  Copyright © 2017年 iOS_Developer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/*
 * 去除首尾和中间空格
 */
+(NSString *)stringByTrimmingCharactersInSetAndWhitespaceCharacterSetWithString:(NSString *)orignString;


/*
 * 字符串是否为空
 */
+ (BOOL)isNilOrEmpty:(id)string;

@end
