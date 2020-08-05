//
//  LoginController.m
//  PrivateSector
//
//  Created by lovebobo on 1/11/18.
//  Copyright © 2018年 lovebobo. All rights reserved.
//

#import "LoginController.h"
#import "RXLSideSlipViewController.h"
#import "LeftViewController.h"
#import "TabBarController.h"
#import "LoginView.h"
#import "DataManager.h"
#import "SSCheckBoxView.h"
#import "RegisterController.h"
#import "AppDelegate.h"
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <unistd.h>
#import "AsyncSocket.h"
@interface LoginController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *account;
@property (nonatomic,strong) UITextField *password;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) LoginView *background;
@property (nonatomic,strong) DataManager *manager;
@property (nonatomic, retain) AsyncSocket *ay;
@end

@implementation LoginController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidLoad {
     [super viewDidLoad];
     //self.view.backgroundColor = [UIColor whiteColor];
     self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpeg"]];
    //AFN网络请求封装
    //_manager = [DataManager manager];
    //NSDictionary *dict = @{
                          // @"userName":@"admin"
                          // };
    //[_manager getDataWithUrl:@"http://192.168.3.105:9991/loginCheck" parameters:dict /success:^(NSString *json){
    //    NSLog(@"%@", json);
    //} failure:^(NSError *err){
    //    NSLog(@"%@", err);
    //}];
    
    //self.ay = [[AsyncSocket alloc] initWithDelegate:self];
    //[self.ay connectToHost:@"192.168.3.26" onPort:9999 error:nil];
    //self.ay.delegate = self;
    
    //NSString *msg = @"来自iphone的 连接!";
    //[self.ay writeData:[msg dataUsingEncoding:NSUTF8StringEncoding]
         //withTimeout:10.0f
                   //tag:101];
    
    //[self.ay readDataWithTimeout:-1 tag:0];
    
    _background=[[LoginView alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 100)];
    [_background setBackgroundColor:[UIColor whiteColor]];
    [[_background layer] setCornerRadius:5];
    [[_background layer] setMasksToBounds:YES];
    
    [self.view addSubview:_background];
    
    UIImage *image = [UIImage imageNamed:@"dl_03.png"];
    UIImageView *imageV = [[UIImageView alloc]initWithImage:image];
    imageV.center = CGPointMake(kScreenWidth/2, 100);
    [self.view addSubview:imageV];
    
    _account=[[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-40, 50)];
    [_account setBackgroundColor:[UIColor clearColor]];
    _account.placeholder=[NSString stringWithFormat:@"用户名"];
    _account.layer.cornerRadius=5.0;
    
    _account.leftViewMode = UITextFieldViewModeAlways;
    UIImage *userimage = [UIImage imageNamed:@"index_red.png"];
    UIImageView *userimageV = [[UIImageView alloc]initWithImage:userimage];
    UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    userimageV.center = lv.center;
    [lv addSubview:userimageV];
    //_account.leftView = lv;
    [_background addSubview:_account];
    
    _password=[[UITextField alloc] initWithFrame:CGRectMake(10, 50, self.view.frame.size.width-40, 50)];
    [_account setBackgroundColor:[UIColor clearColor]];
    _password.placeholder=[NSString stringWithFormat:@"密码"];
    _password.layer.cornerRadius=5.0;
    
    _password.leftViewMode = UITextFieldViewModeAlways;
    UIImage *passimage = [UIImage imageNamed:@"index_pl_18.png"];
    UIImageView *passimageV = [[UIImageView alloc]initWithImage:passimage];
    UIView *lv1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    passimageV.center = lv1.center;
    [lv1 addSubview:passimageV];
     //password.leftView = lv1;
    [_background addSubview:_password];
    
    SSCheckBoxView *cb = [[SSCheckBoxView alloc] initWithFrame:CGRectMake(20, 320, 300, 30) style:2 checked:NO];
    [cb setText:@"记住密码"];
    [cb setStateChangedBlock:^(SSCheckBoxView *cbv) {
        NSLog(@"复选框状态: %@",cbv.checked ? @"选中" : @"没选中");
    }];
    [self.view addSubview:cb];
    
    
    SSCheckBoxView *cb2 = [[SSCheckBoxView alloc] initWithFrame:CGRectMake(20, 349, 300, 30) style:2 checked:NO];
    [cb2 setText:@"自动登录"];
    [cb2 setStateChangedBlock:^(SSCheckBoxView *cbv) {
        NSLog(@"复选框状态: %@",cbv.checked ? @"选中" : @"没选中");
    }];
    [self.view addSubview:cb2];
    
    _loginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginButton setFrame:CGRectMake(20, 390, self.view.frame.size.width-40, 50)];
    
    [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
    //[_loginButton setBackgroundColor:[UIColor colorWithRed:255.0 green:190.0 blue:177.0 alpha:1]];
    [_loginButton setBackgroundColor:[UIColor colorWithHexString:@"#FF77B1"]];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(logintouchclicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
    
    UILabel *label = [[ UILabel alloc] init];
    label.text = @"账号注册";
    label.frame = CGRectMake(self.view.frame.size.width-100, 440, self.view.frame.size.width-40, 50);
    label.textColor = [UIColor colorWithHexString:@"#FF77B1"];
    //添加事件。
    label.font = [UIFont boldSystemFontOfSize:20];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    
    [label addGestureRecognizer:labelTapGestureRecognizer];
    [self.view addSubview:label];
    
    UIImage *qqimage = [UIImage imageNamed:@"vip.png"];
    UIImageView *qqimageV = [[UIImageView alloc]initWithImage:qqimage];
    qqimageV.center = CGPointMake(kScreenWidth/4, 430);
    //[self.view addSubview:qqimageV];
    
    UIImage *wximage = [UIImage imageNamed:@"vip.png"];
    UIImageView *wximageV = [[UIImageView alloc]initWithImage:wximage];
    wximageV.center = CGPointMake(kScreenWidth/2, 430);
    //[self.view addSubview:wximageV];
    
    UIImage *wbimage = [UIImage imageNamed:@"vip.png"];
    UIImageView *vbimageV = [[UIImageView alloc]initWithImage:wbimage];
    vbimageV.center = CGPointMake(kScreenWidth/1.3, 430);
    //[self.view addSubview:vbimageV];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_account resignFirstResponder]; // 空白处收起
    [_password resignFirstResponder]; // 空白处收起
    
}
-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    RegisterController *registerView = [[RegisterController alloc] init];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:0 target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:bar];
    [self.navigationController pushViewController:registerView animated:YES];
}
-(void)logintouchclicked
{//登陆跳转到主界面按钮
    TabBarController *tabBarVC = [[TabBarController alloc] init];
    LeftViewController *left = [[LeftViewController alloc] init];
    RXLSideSlipViewController *RXL = [[RXLSideSlipViewController alloc]initWithContentViewController:tabBarVC leftMenuViewController:left rightMenuViewController:nil];
    RXL.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    RXL.backgroundImage = [UIImage imageNamed:@"banner_01.png"];
    RXL.contentViewShadowColor = [UIColor blackColor];
    RXL.contentViewShadowOffset = CGSizeMake(0, 0);
    RXL.contentViewShadowOpacity = 0.1;
    RXL.contentViewShadowRadius = 1;
    RXL.contentViewInPortraitOffsetCenterX = 100;//距离中轴位置
    RXL.contentViewShadowEnabled = YES; // 是否显示阴影
    RXL.contentPrefersStatusBarHidden = NO;//是否隐藏主视图的状态条
    RXL.panFromEdge = NO;
    RXL.panGestureEnabled = NO;
    RXL.interactivePopGestureRecognizerEnabled = NO;
    RXL.scaleContentView = NO;
    [RXL setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    AppDelegate *appdelegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
    appdelegate.window.rootViewController = RXL;
    //[self.navigationController pushViewController:RXL animated:YES];
    [self presentViewController:RXL  animated:YES completion:nil];//从当前界面到nextVC
}
-(void)forgetpasswordclicked:(UIButton*)forgetpassword
{   //忘记密码跳转按钮
        
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
        [textField resignFirstResponder];
        return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)linkservice {
        [self.ay writeData:[@"test" dataUsingEncoding:NSUTF8StringEncoding]
               withTimeout:10.0f
                       tag:101];
        
    [self.ay readDataWithTimeout:-1 tag:0];
}

#pragma mark --AsyncSocketDelegate--
- (void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"msg-----%@",msg);
    
    [self.ay readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    [self.ay readDataWithTimeout:-1 tag:0];
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port
{
    NSLog(@"didConnectToHost    %@------%d",host,port);
    [self.ay readDataWithTimeout:-1 tag:0];
}

-(void)onSocket:(AsyncSocket *)sock didReadPartialDataOfLength:(NSUInteger)partialLength tag:(long)tag
{
    NSLog(@"Received bytes: %lu",(unsigned long)partialLength);
}
@end
