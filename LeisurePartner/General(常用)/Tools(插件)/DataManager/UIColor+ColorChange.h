//
//  UIColor+ColorChange.h
//  PrivateSector
//
//  Created by lovebobo on 15/12/18.
//  Copyright © 2018年 lovebobo. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
