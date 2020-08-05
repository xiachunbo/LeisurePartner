//
//  ViewController.m
//  XMWebView
//
//  Created by xuzhangming on 2018/9/18.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "ListViewController.h"
#import "XMWebView.h"
#import "MJRefresh.h"
#import "MyloadView.h"
#import "AppStatus.h"
#import "DataManager.h"
@interface ListViewController ()<XMWebViewDelegate>

@property (nonatomic, strong) XMWebView *webView;

@property (nonatomic, copy) NSString *urlStr;

@property (nonatomic, strong) MyloadView *activty;

@property (nonatomic,strong) DataManager *manager;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情列表";
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    //根据需求切换UI WK
    _webView = [[XMWebView alloc] initWithFrame:self.view.bounds viewType:WebViewTypeWkWebView];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    _webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];//MJRefreshAutoNormalFooter MJRefreshBackNormalFooter
    //_webView.scrollView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    // 隐藏当前的上拉刷新控件
    //_webView.scrollView.mj_footer.hidden = YES;
    [self.view addSubview:_webView];
    //此处链接要写全
    NSString * linkUrl =  [AppStatus shareInstance].contextStr;
    linkUrl =  @"content.html";
    //self.urlStr = @"https://www.baidu.com";
    //NSURL *url = [NSURL URLWithString:self.urlStr];
    //NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //[self.webView loadRequest:request];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:linkUrl ofType:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
    
    _activty=[[MyloadView alloc]initWithFrame:CGRectMake(10, 10, 100, 100) andBgColor:[UIColor grayColor] andColor:[UIColor whiteColor]];
    //创建一个我们自定义的活动指示器
    _activty.center=self.view.center;//这是在屏幕的中心位置
    //设置圆角边框
    _activty.layer.cornerRadius = 8;
    _activty.layer.masksToBounds = YES;
    [self.view addSubview:_activty];//显示在界面上
    [_activty stopAnimating];
}

- (void)webView:(XMWebView *)webview shouldStartLoadWithURL:(NSURL *)URL {
    NSString *requestString = [URL absoluteString];
    //IOS9后的链接
    requestString = [requestString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if(!requestString){
        requestString = [URL absoluteString];
        [requestString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    NSLog(@"===%@",requestString);
    //js与原生交互(原生捕捉js事件)
    //捕捉事件:goback:// 是js里的方法名:location.href="goback://";
    if ([requestString hasPrefix:@"godetail://"]) {
        //[self getLocationFunc];
        NSDictionary *param = [self dictionaryWithUrlString:requestString];
        NSLog(@"-------->%@", [param objectForKey:@"title"]);
        //NSInteger *index = [[param objectForKey:@"index"]integerValue];
        //detailView.
        //将新的控制器压入导航控制器
        //UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"详情列表" style:0 target:nil action:nil];
        //[self.navigationItem setBackBarButtonItem:bar];
        //[self.navigationController pushViewController:detailView animated:YES];
        NSURL *url = [ [ NSURL alloc ] initWithString: @"https://download.jiujiuit.com/app/vc59881030_liangchao.mobileprovision" ];
        [[UIApplication sharedApplication] openURL:url];
    }
}
- (void)getLocationFunc
{
    [_activty startAnimating];
    //AFN网络请求封装
    _manager = [DataManager manager];
    NSDictionary *dict = @{};
    [_manager getDataWithUrl:@"https://www.apiopen.top/journalismApi" parameters:dict success:^( NSString *json){
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                           error:&err];
        NSLog(@"dic--->%@", dic);
        NSDictionary *datas = dic[@"data"];
        NSArray *dataArray = datas[@"tech"];
        for (NSDictionary *dic in dataArray) {
            NSArray *picInfo = dic[@"picInfo"];
            NSDictionary *pic = [picInfo firstObject];
            NSString *str2 = @"";
            NSString *str1 = [str2 stringByAppendingFormat:@"%@%ld%@%@%@%@%@%@%@%ld%@%@%@%@%@%@%@",@"var h1 = $('#xxx');"
                              "var html = '';"
                              "html+=\"<a href='godetail://content?index=",(long)0,@"' class=''><li class='am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-right\";"
                              "html+=\"  pet_list_one_block'>\";"
                              "html+=\"<div class='pet_list_one_info'>\";"
                              "html+=\"<div class='pet_list_one_info_l'>\";"
                              "html+=\"<div class='pet_list_one_info_ico'><img src='",(NSString *)[pic objectForKey:@"url"],@"' alt=''></div>\";"
                              "html+=\"<div class='pet_list_one_info_name'><b>",(NSString *)[dic objectForKey:@"source"],@"</b></div>\";"
                              "html+=\"</div>\";"
                              "html+=\"<div class='pet_list_one_info_r'>\";"
                              "html+=\"<div class='pet_list_tag pet_list_tag_xxs'>[~",NSLocalizedString(@"休闲鲜事", @""),@"]</div>\";"
                              "html+=\"</div>\";"
                              "html+=\"</div>\";"
                              "html+=\"<div class=' am-u-sm-8 am-list-main pet_list_one_nr'>\";"
                              "html+=\"<h3 class='am-list-item-hd pet_list_one_bt'><a href='godetail://content?index=",(long)0,@"' class=''>",(NSString *)[dic objectForKey:@"title"],@"</a></h3>\";"
                              "html+=\"<div style='height:40px;'></div>\";"
                              "html+=\"<div class='am-list-item-text pet_list_one_text'>",(NSString *)[dic objectForKey:@"digest"],@"</div>\";"
                              "html+=\"</div>\";"
                              "html+=\"<div class='am-u-sm-4 am-list-thumb'>\";"
                              "html+=\"<a href='###' class=''>\";"
                              "html+=\"<img src='",(NSString *)[pic objectForKey:@"url"],@"' class='pet_list_one_img' alt=''/>\";"
                              "html+=\"</a>\";"
                              "html+=\"</div>\";"
                              "html+=\"</li></a>\";"
                              "h1.append(html);"];
            [self.webView loadJsByJson:str1];
        }
        NSLog(@"%@", json);
        [_activty stopAnimating];
    } failure:^(NSError *err){
        NSLog(@"%@", err);
        [_activty stopAnimating];
    }];
    
   
}
#pragma mark - 下拉刷新
- (void)headerRefresh{
    NSLog(@"%@",@"headerRefresh");
    // [self.webView  reload];
    [self.webView.scrollView.mj_header endRefreshing];
    
}

#pragma mark - 上拉加载
- (void)footerRefresh{
    NSLog(@"%@",@"footerRefresh");
    // 之后3秒延迟隐藏
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    });
    [self.webView.scrollView.mj_footer endRefreshing];
}
#pragma maek - 子类重写
- (void)webViewDidStartLoad:(XMWebView *)webview {
    NSLog(@"%@",@"StartLoad");
    [_activty startAnimating];
}
- (void)webView:(XMWebView *)webview didFinishLoadingURL:(NSURL *)URL {
    NSLog(@"%@",@"FinishLoading");
    [_activty stopAnimating];
    [self getLocationFunc];
    
}
- (void)webView:(XMWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error {
    NSLog(@"error=%@",error);
    [_activty stopAnimating];
}
-(NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr
{
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            NSString *paramsStr = array[1];
            if (paramsStr.length) {
                NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
                NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
                for (NSString *param in paramArray) {
                    if (param && param.length) {
                        NSArray *parArr = [param componentsSeparatedByString:@"="];
                        if (parArr.count == 2) {
                            [paramsDict setObject:parArr[1] forKey:parArr[0]];
                        }
                    }
                }
                return paramsDict;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end



