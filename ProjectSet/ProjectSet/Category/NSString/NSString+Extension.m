//
//  NSString+Extension.m
//  ProjectSet
//
//  Created by 陈诚 on 2017/5/25.
//  Copyright © 2017年 iOS_Developer. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

#pragma mark - 去除首尾的换行符和中间空格

+(NSString *)stringByTrimmingCharactersInSetAndWhitespaceCharacterSetWithString:(NSString *)orignString {
    
    orignString = [orignString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    orignString = [orignString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return orignString;
}

#pragma mark - 字符串是否为空

+ (BOOL)isNilOrEmpty:(id)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] && [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] && ([string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"])) {
        return YES;
    }
    return NO;
}


@end
