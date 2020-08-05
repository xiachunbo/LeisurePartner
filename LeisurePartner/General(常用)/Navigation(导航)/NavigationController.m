//
//  QKNavigationController.m
//  CustomTarBar
//
//  Created by 点点 on 2017/11/18.
//  Copyright © 2017年 DD. All rights reserved.
//

#import "NavigationController.h"
@interface NavigationController ()
@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
}
+ (void)initialize
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255.f/255.f green:153.f/255.f blue:204.f/255.f alpha:1]];
    //修改标题字体颜色及大小
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
   
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    //解决iPhone X push页面时 tabBar上移的问题
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
