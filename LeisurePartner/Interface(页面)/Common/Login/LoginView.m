//
//  LoginView.m
//  PrivateSector
//
//  Created by lovebobo on 11/12/18.
//  Copyright © 2018年 lovebobo. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (void)drawRect:(CGRect)rect {
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,0.2);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 5, 50);
    CGContextAddLineToPoint(context,self.frame.size.width-5, 50);
    CGContextClosePath(context);
    [[UIColor lightTextColor] setStroke];
    CGContextStrokePath(context);
}
@end
