//
//  MyloadView.h
//  PrivateSector
//
//  Created by lovebobo on 3/1/19.
//  Copyright © 2019年 lovebobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyloadView : UIView

@property(strong,nonatomic)UIActivityIndicatorView *act;
@property(strong,nonatomic)UILabel *titleLab;
-(id)initWithFrame:(CGRect)frame andBgColor:(UIColor*)c1 andColor:(UIColor *)c2;
- (void)startAnimating;
- (void)stopAnimating;

@end
