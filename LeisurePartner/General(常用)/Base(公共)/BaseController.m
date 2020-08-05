//
//  ViewController.m
//  XMWebView
//
//  Created by xuzhangming on 2018/9/18.
//  Copyright © 2018年 xuzhangming. All rights reserved.
//

#import "BaseController.h"
#import "XMWebView.h"
#import "MJRefresh.h"
#import "UIActionSheet+NTESBlock.h"
#import "YCXMenuItem.h"
#import "YCXMenu.h"
@interface BaseController ()<XMWebViewDelegate>

@property (nonatomic, strong) XMWebView *webView;

@property (nonatomic, copy) NSString *urlStr;
@end

@implementation BaseController
@synthesize items = _items;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)webView:(XMWebView *)webview shouldStartLoadWithURL:(NSURL *)URL {
 
}
- (void)getLocationFunc
{
    [self.webView loadJsByJson:@"alertMessage('hello')"];
}
#pragma mark - 下拉刷新
- (void)headerRefresh{
     NSLog(@"%@",@"headerRefresh");
}

#pragma mark - 上拉加载
- (void)footerRefresh{
     NSLog(@"%@",@"footerRefresh");
}
#pragma maek - 子类重写
- (void)webViewDidStartLoad:(XMWebView *)webview {
     NSLog(@"%@",@"StartLoad");
}
- (void)webView:(XMWebView *)webview didFinishLoadingURL:(NSURL *)URL {
     NSLog(@"%@",@"FinishLoading");
}
- (void)webView:(XMWebView *)webview didFailToLoadURL:(NSURL *)URL error:(NSError *)error {
    NSLog(@"error=%@",error);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
///处理alert事件
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

- (void)setUpNavItem{
    self.navigationItem.title = @"黑名单";
    UIButton *teamBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [teamBtn addTarget:self action:@selector(showMenu1FromNavigationBarItem:) forControlEvents:UIControlEventTouchUpInside];
    [teamBtn setImage:[UIImage imageNamed:@"index_icon_31"] forState:UIControlStateNormal];
    [teamBtn setImage:[UIImage imageNamed:@"index_icon_31"] forState:UIControlStateHighlighted];
    [teamBtn sizeToFit];
    UIBarButtonItem *teamItem = [[UIBarButtonItem alloc] initWithCustomView:teamBtn];
    self.navigationItem.rightBarButtonItem = teamItem;
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
-(void)showMenu1FromNavigationBarItem:(id)sender{
    
    [YCXMenu setTintColor:[UIColor lightTextColor]];
    [YCXMenu setSelectedColor:[UIColor redColor]];
    if ([YCXMenu isShow]){
        [YCXMenu dismissMenu];
    } else {
        [YCXMenu showMenuInView:self.view fromRect:CGRectMake(self.view.frame.size.width - 50, 0, 50, 0) menuItems:self.items selected:^(NSInteger index, YCXMenuItem *item) {
            NSLog(@"%@",item);
        }];
    }
}
#pragma mark - setter/getter
- (NSMutableArray *)items {
    if (!_items) {
        
        // set title
        YCXMenuItem *menuTitle = [YCXMenuItem menuTitle:@"帮助" WithIcon:nil];
        menuTitle.foreColor = [UIColor blackColor];
        menuTitle.titleFont = [UIFont boldSystemFontOfSize:20.0f];
        
        //set logout button
        YCXMenuItem *Item2 = [YCXMenuItem menuItem:@"提问1" image:nil target:self action:@selector(logout:)];
        Item2.foreColor = [UIColor blackColor];
        Item2.alignment = NSTextAlignmentCenter;
        
        //set logout button
        YCXMenuItem *Item3 = [YCXMenuItem menuItem:@"提问2" image:nil target:self action:@selector(logout:)];
        Item3.foreColor = [UIColor blackColor];
        Item3.alignment = NSTextAlignmentCenter;
        
        //set item
        _items = [@[menuTitle,
                    Item2,
                    Item3
                    ] mutableCopy];
    }
    return _items;
}
@end

