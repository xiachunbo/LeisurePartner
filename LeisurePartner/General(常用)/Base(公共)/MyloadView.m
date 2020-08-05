//
//  MyloadView.m
//  PrivateSector
//
//  Created by lovebobo on 3/1/19.
//  Copyright © 2019年 lovebobo. All rights reserved.
//

#import "MyloadView.h"

@implementation MyloadView
-(id)initWithFrame:(CGRect)frame andBgColor:(UIColor*)c1 andColor:(UIColor *)c2
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=c1;//设置背景颜色
        self.act=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];//创建一个活动指示器
        self.act.color=c2;//活动指示器的颜色
        self.act.center=CGPointMake(frame.size.width/2, frame.size.height/2);//指示器的位置
        [self addSubview:self.act];//添加到视图上
        
        [self.act startAnimating];//开始转动活动显示器
        
        //添加一个标签，标签的位置
        self.titleLab =[[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-30, frame.size.width, 30)];
        self.titleLab.text=@"加载中...";//标签显示的内容
        self.titleLab.textAlignment=NSTextAlignmentCenter;//标签字体居中
        self.titleLab.textColor=[UIColor whiteColor];//标签的背景颜色
        self.titleLab.font=[UIFont systemFontOfSize:15];//标签的字体大小
        self.titleLab.textColor = [UIColor whiteColor];
        self.titleLab.layer.cornerRadius = 2;
        [self addSubview:self.titleLab];//显示到主视图上
        
    }
    return self;
}
- (void)startAnimating
{
    [self setHidden:false];
}
- (void)stopAnimating
{
    [self setHidden:true];
}
@end
