//
//  ResultViewController.m
//  LeisurePartner
//
//  Created by lovebobo on 20/4/2019.
//  Copyright © 2019 lovebobo. All rights reserved.
//

#import "HomeViewController1.h"
#import "NewsListModel.h"
#import "NewsListCell.h"
#import "HttpHelper.h"
#import "DataManager.h"
#import "MyloadView.h"
#import "MJRefresh.h"
#define BASE_URL_NEWS_LIST @"http://c.3g.163.com/nc/video/home/1-10.html"
@interface HomeViewController1 ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *arrNewsList;
    NSMutableDictionary *searchdict;
    HttpHelper *helper;
    NSUInteger pageindex;
    NSUInteger pagesize;
    DataManager *manager;
    MyloadView *activty;
    /** 下拉刷新控件 */
    MJRefreshHeader *mj_header;
    /** 上拉刷新控件 */
    MJRefreshFooter *mj_footer;
}
@end
@implementation HomeViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.title=@"新闻";
    arrNewsList = [NSMutableArray array];
    searchdict = [NSMutableDictionary dictionary];
    pagesize=15;
    pageindex=1;
    activty=[[MyloadView alloc]initWithFrame:CGRectMake(10, 10, 100, 100) andBgColor:[UIColor blackColor] andColor:[UIColor whiteColor]];
     //创建一个我们自定义的活动指示器
     activty.center=self.view.center;//这是在屏幕的中心位置
     //设置圆角边框
     activty.layer.cornerRadius = 8;
     activty.layer.masksToBounds = YES;
     [activty startAnimating];
    manager = [DataManager manager];
    NSDictionary *dict = @{};
    NSString *url=@"http://c.3g.163.com/nc/video/home/";
    url = [url stringByAppendingFormat:@"%d%@%d%@",7*1,@"-",7*1+7,@".html"];
    [manager getDataWithUrl:url parameters:dict success:^( NSString *json){
       NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
       NSError *err;
       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
       [self initDataWithDict:dict];
       NSLog(@"%@", json);
       [activty stopAnimating];
    } failure:^(NSError *err){
       //NSLog(@"%@", err);
       [activty stopAnimating];
    }];
    //初始化tableviwe
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.rowHeight = 130;
    _tableView.dataSource=self;
    _tableView.delegate=self;
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) { [_tableView setSeparatorInset:UIEdgeInsetsZero];}
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) { [_tableView setLayoutMargins:UIEdgeInsetsZero];}
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    [self.view addSubview:activty];//显示在界面上
       // 下拉刷新
       __weak typeof(self)  weakSelf = self;
       self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               // 结束刷新
               [weakSelf.tableView.mj_header endRefreshing];
           });
       }];
       
       // 上拉刷新
       self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
           // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               // 结束刷新
               [weakSelf.tableView.mj_footer endRefreshing];
           });
       }];
}
-(void)initDataWithDict:(NSDictionary *)dict
{
    //如果获取的是第一页的数据，表示刚进入该view或者刷新该view
    if (pageindex==1) { [arrNewsList removeAllObjects]; }
    
    NSArray *arrnews = [dict objectForKey:@"videoList"];
    
    for (NSDictionary *dic in arrnews) {
        NewsListModel *modnews = [[NewsListModel alloc]initWithDict:dic];
         NSLog(@"dic--->%@", modnews.NewsTitle);
        [arrNewsList addObject:modnews];
    }
    [_tableView reloadData];
}


#pragma mark - 实现tableview代理方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsListCell *cell=[NewsListCell cellWithTableView:tableView];
    NewsListModel *modnews = arrNewsList[indexPath.row];
    cell.news =modnews;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrNewsList.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    NewsListModel *modnews = arrNewsList[indexPath.row];
    //RDNewsDetailViewController *detail = [[RDNewsDetailViewController alloc]init];
    //detail.NewsID=modnews.NewsID;
    self.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
    //[self.navigationController pushViewController:detail animated:YES];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) { [cell setSeparatorInset:UIEdgeInsetsZero];}
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) { [cell setLayoutMargins:UIEdgeInsetsZero];}
}

#pragma mark - 隐藏hud和网络
-(void)viewWillDisappear:(BOOL)animated
{
    //[[HttpHelper httpHelper] CancelAllRequest];
    //[ToolsHelper CloseHUD];
    [super viewWillDisappear:animated];
}
@end
