//
//  ViewController.m
//  跟手动画
//
//  Created by xiaoyu on 15/12/28.
//  Copyright © 2015年 guoda. All rights reserved.
//

#import "CenterController.h"

/**
 *  屏幕的大小
 */
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define ViewTag 8888
@interface CenterController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL isAppear;

@property (nonatomic, strong) UIButton *button;

@end

@implementation CenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpeg"]];
    NSArray *iconArray = @[@"tabbar_compose_camera",@"tabbar_compose_idea",@"tabbar_compose_lbs",@"tabbar_compose_more",@"tabbar_compose_photo",@"tabbar_compose_review"];
    _isAppear = YES;

    
    CGFloat wid = SCREENWIDTH/3;
    CGFloat heig = wid;
    
    CGFloat x = 0;
    CGFloat y = SCREENHEIGHT - 400;
    
    for (int i=0; i<6; i++) {
        UIButton *childButton = [UIButton buttonWithType:UIButtonTypeCustom];
        childButton.tag = ViewTag + i;
        childButton.frame = CGRectMake(x, y, wid, heig);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, wid-55, wid-55)];
        imageView.center = CGPointMake(wid/2, wid/2);
        imageView.image = [UIImage imageNamed:iconArray[i]];
        [childButton addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        [self.view addSubview:childButton];
        
        if (i==2) {
            x=0;y+=heig;
        }else{
            
            x+=wid;
        }
        
    }
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = CGRectMake(0, 0, 70, 70);
    _button.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT-60);
    //[_button setTitle:@"关闭" forState:UIControlStateNormal];
    UIImageView *image = [[UIImageView alloc]init];
    image.frame = CGRectMake(0, 0, 70, 70);
    image.image = [UIImage imageNamed:@"btn_cross"];
    CGAffineTransform transform= CGAffineTransformMakeRotation(45/180*3.14);
    image.transform = transform;//旋转
    [_button setBackgroundImage:image.image forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
   
}
- (void)btnClick {
    if (_isAppear) {
        _isAppear = NO;
        [UIView animateWithDuration:0.5 animations:^{
            _button.transform = CGAffineTransformMakeRotation(M_PI);
            
        }];
        for (UIView *view in self.view.subviews) {
            UIButton *button = (UIButton*)view;
            
            
            switch (button.tag - ViewTag) {
                case 0:
                {
                    [UIView animateWithDuration:1 delay:0.2f usingSpringWithDamping:0.4f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        button.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + 800, view.frame.size.width, view.frame.size.height);
                        
                    } completion:^(BOOL finished) {
                        
                        
                        
                    }];
                    
                }
                    break;
                case 1:
                {
                    [UIView animateWithDuration:1 delay:0.16f usingSpringWithDamping:0.4f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        button.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + 800, view.frame.size.width, view.frame.size.height);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                }
                    break;
                case 2:
                {
                    [UIView animateWithDuration:1 delay:0.12f usingSpringWithDamping:0.4f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        button.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + 800, view.frame.size.width, view.frame.size.height);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                }
                    break;
                case 3:
                {
                    [UIView animateWithDuration:1 delay:0.08f usingSpringWithDamping:0.4f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        button.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + 800, view.frame.size.width, view.frame.size.height);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                }
                    break;
                case 4:
                {
                    
                    [UIView animateWithDuration:1 delay:0.04f usingSpringWithDamping:0.4f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        button.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + 800, view.frame.size.width, view.frame.size.height);
                        
                    } completion:^(BOOL finished) {
                    }];
                    
                }
                    break;
                case 5:
                {
                    [UIView animateWithDuration:1 delay:0.f usingSpringWithDamping:0.4f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        button.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + 800, view.frame.size.width, view.frame.size.height);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
    }
    else{
        _isAppear = YES;
        [UIView animateWithDuration:0.5 animations:^{
            _button.transform = CGAffineTransformMakeRotation(M_PI*2);

        }];

        for (UIView *view in self.view.subviews) {
            UIButton *button = (UIButton*)view;
            
            switch (button.tag - ViewTag) {
                case 0:
                {
                    [UIView animateWithDuration:1 delay:0.0f usingSpringWithDamping:0.4f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        button.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - 800, view.frame.size.width, view.frame.size.height);
                        
                    } completion:^(BOOL finished) {
                        
                        
                        
                    }];
                    
                }
                    break;
                case 1:
                {
                    [UIView animateWithDuration:1 delay:0.04f usingSpringWithDamping:0.4f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        button.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - 800, view.frame.size.width, view.frame.size.height);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                }
                    break;
                case 2:
                {
                    [UIView animateWithDuration:1 delay:0.08f usingSpringWithDamping:0.4f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        button.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - 800, view.frame.size.width, view.frame.size.height);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                }
                    break;
                case 3:
                {
                    [UIView animateWithDuration:1 delay:0.12f usingSpringWithDamping:0.4f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        button.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - 800, view.frame.size.width, view.frame.size.height);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                }
                    break;
                case 4:
                {
                    
                    [UIView animateWithDuration:1 delay:0.16f usingSpringWithDamping:0.4f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        
                        button.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - 800, view.frame.size.width, view.frame.size.height);
                        
                    } completion:^(BOOL finished) {
                    }];
                    
                }
                    break;
                case 5:
                {
                    [UIView animateWithDuration:1 delay:0.2f usingSpringWithDamping:0.4f initialSpringVelocity:1.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        button.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y - 800, view.frame.size.width, view.frame.size.height);
                        
                    } completion:^(BOOL finished) {
                        
                    }];
                    
                }
                    break;
                    
                default:
                    break;
            }
            
            
            
        }
        
        
    }
   
   //再次隐藏悬浮窗
   [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
