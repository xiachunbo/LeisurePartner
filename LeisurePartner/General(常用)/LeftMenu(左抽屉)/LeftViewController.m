//
//  LeftViewController.m
//  PrivateSector
//
//  Created by lovebobo on 6/9/18.
//  Copyright © 2018年 lovebobo. All rights reserved.
//

#import "LeftViewController.h"
#import "AppDelegate.h"
#import "LoginController.h"
#import "NavigationController.h"
#import "RXLSideSlipViewController.h"
#define ImageviewWidth    18
#define Frame_Width       self.view.frame.size.width//200
@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView    *contentTableView;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initView{
    
    //添加头部
    UIView *headerView     = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Frame_Width, 190)];
    //[headerView setBackgroundColor:[UIColor purpleColor]];
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"FM_pic"]];
    [headerView setBackgroundColor:bgColor];
    CGFloat width          = 90/2;
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                      action:@selector(imageViewTapAction:)];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(12, (90 - width)+60 / 2, width+20, width+25)];
    [headerView addGestureRecognizer:singleFingerOne];
    //    [imageview setBackgroundColor:[UIColor redColor]];
    imageview.layer.cornerRadius = imageview.frame.size.width / 2;
    imageview.layer.masksToBounds = YES;
    [imageview setImage:[UIImage imageNamed:@"boy"]];
    [headerView addSubview:imageview];
    
    
    width                  = 15;
    UIImageView *arrow     = [[UIImageView alloc]initWithFrame:CGRectMake(Frame_Width - width - 10, (190 - width)/2, width, width+25)];
    arrow.contentMode      = UIViewContentModeScaleAspectFit;
    [arrow setImage:[UIImage imageNamed:@"person-icon0"]];
    [headerView addSubview:arrow];
    
    UILabel *NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageview.frame.size.width + imageview.frame.origin.x * 2, imageview.frame.origin.y, 90, imageview.frame.size.height)];
    [NameLabel setText:@"紫色菠菜"];
    [headerView addSubview:NameLabel];
    [self.view addSubview:headerView];
    
    
    //中间tableview
    UITableView *contentTableView        = [[UITableView alloc]initWithFrame:CGRectMake(0, headerView.frame.size.height, Frame_Width, self.view.frame.size.height - headerView.frame.size.height * 2)
                                                                       style:UITableViewStylePlain];
    [contentTableView setBackgroundColor:[UIColor whiteColor]];
    contentTableView.dataSource          = self;
    contentTableView.delegate            = self;
    contentTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [contentTableView setBackgroundColor:[UIColor whiteColor]];
    contentTableView.separatorStyle      = UITableViewCellSeparatorStyleNone;
    contentTableView.tableFooterView = [UIView new];
    self.contentTableView = contentTableView;
    [self.view addSubview:contentTableView];
    
    //添加尾部
    width  = 90;
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - headerView.frame.size.height, Frame_Width, self.view.frame.size.height)];
    [footerView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *LoginImageview = [[UIImageView alloc]initWithFrame:CGRectMake(8 + 5, (width - ImageviewWidth)/2, ImageviewWidth, ImageviewWidth)];
    // [LoginImageview setImage:[UIImage imageNamed:@"person-icon8"]];
    [footerView addSubview:LoginImageview];
    width = 30;
    
    
    [self.view addSubview:footerView];
}
- (void)imageViewTapAction:(id)sender {
    if([self.customDelegate respondsToSelector:@selector(loginclick:)]){
        // [self.customDelegate loginclick:1];
    }
}
#pragma mark - tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [NSString stringWithFormat:@"LeftView%li",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        
    }
    [cell setBackgroundColor:[UIColor whiteColor]];
    [cell.textLabel setTextColor:[UIColor grayColor]];
    
    //    [cell setCellModel:nil indexPath:indexPath];
    //    [cell setBackgroundColor:[UIColor colorWithHexString:ColorBackGround]];
    cell.hidden = NO;
    switch (indexPath.row) {
        case 0:
        {
            [cell.imageView setImage:[UIImage imageNamed:@"boy1"]];
            [cell.textLabel setText:@"我发布的段子"];
        }
            break;
            
        case 1:
        {
            
            [cell.imageView setImage:[UIImage imageNamed:@"boy2"]];
            [cell.textLabel setText:@"我发布的视频"];
        }
            break;
            
            
        case 2:
        {
            
            [cell.imageView setImage:[UIImage imageNamed:@"boy3"]];
            [cell.textLabel setText:@"我的收藏"];
        }
            break;
            
        case 3:
        {
            
            [cell.imageView setImage:[UIImage imageNamed:@"boy4"]];
            [cell.textLabel setText:@"设置中心"];
        }
            break;
            //新增 整车调度
        case 4:{
            
            [cell.imageView setImage:[UIImage imageNamed:@"boy5"]];
            [cell.textLabel setText:@"退出"];
        }
            break;
            
            
        default:
            break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([self.customDelegate respondsToSelector:@selector(LeftMenuViewClick:)]){
        [self.customDelegate LeftMenuViewClick:indexPath.row];
    }
    
    if(indexPath.row == 3){
        //TableListViewController *login = [[TableListViewController alloc] init];
        
    }
    
    if(indexPath.row == 4){
        LoginController *login = [[LoginController alloc] init];
        NavigationController *na = [[NavigationController alloc] initWithRootViewController:login];
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        na.navigationItem.leftBarButtonItem = item;
        //na.navigationBar.barStyle = UIStatusBarStyleDefault;
        AppDelegate *appdelegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
        appdelegate.window.rootViewController = na;
    }
    
}
//获取某个view所在的控制器
- (UIViewController *)viewController {
    UIViewController *viewController = nil;
    UIResponder *next = self.nextResponder;
    while (next) {
        if ([next isKindOfClass:[UIViewController class]]) {
            viewController = (UIViewController *)next;
            break;
        }
        next = next.nextResponder;
    }
    return viewController;
}


@end
