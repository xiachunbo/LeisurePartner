//
//  LoginController.m
//  PrivateSector
//
//  Created by lovebobo on 1/11/18.
//  Copyright © 2018年 lovebobo. All rights reserved.
//

#import "RegisterController.h"
#import "RXLSideSlipViewController.h"
#import "LeftViewController.h"
#import "TabBarController.h"
#import "LoginView.h"
#import "DataManager.h"
#import "SSCheckBoxView.h"
@interface RegisterController ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *account;
@property (nonatomic,strong) UITextField *password;
@property (nonatomic,strong) UITextField *phonenum;
@property (nonatomic,strong) UITextField *email;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) LoginView *background;
@property (nonatomic,strong) DataManager *manager;
@end

@implementation RegisterController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏透明
    [self.navigationController.navigationBar setTranslucent:true];
    //把背景设为空
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //处理导航栏有条线的问题
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
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
    
    
    
    _background=[[LoginView alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 200)];
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
    [_password setBackgroundColor:[UIColor clearColor]];
    _password.placeholder=[NSString stringWithFormat:@"密码"];
    _password.layer.cornerRadius=5.0;
    
    _password.leftViewMode = UITextFieldViewModeAlways;
    UIImage *passimage = [UIImage imageNamed:@"index_pl_18.png"];
    UIImageView *passimageV = [[UIImageView alloc]initWithImage:passimage];
    UIView *lv1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    passimageV.center = lv1.center;
    [lv1 addSubview:passimageV];
    //_password.leftView = lv1;
    [_background addSubview:_password];
    
    _phonenum=[[UITextField alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-40, 50)];
    [_phonenum setBackgroundColor:[UIColor clearColor]];
    _phonenum.placeholder=[NSString stringWithFormat:@"手机号码"];
    _phonenum.layer.cornerRadius=5.0;
    
    _phonenum.leftViewMode = UITextFieldViewModeAlways;
    UIImage *phoneimage = [UIImage imageNamed:@"index_pl_18.png"];
    UIImageView *phoneimageV = [[UIImageView alloc]initWithImage:phoneimage];
    UIView *lv2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    phoneimageV.center = lv2.center;
    [lv2 addSubview:phoneimageV];
    //phonenum.leftView = lv2;
    [_background addSubview:_phonenum];
    
    _email=[[UITextField alloc] initWithFrame:CGRectMake(10, 150, self.view.frame.size.width-40, 50)];
    [_email setBackgroundColor:[UIColor clearColor]];
    _email.placeholder=[NSString stringWithFormat:@"电子邮箱"];
    _email.layer.cornerRadius=5.0;
    
    _email.leftViewMode = UITextFieldViewModeAlways;
    UIImage *emailimage = [UIImage imageNamed:@"index_pl_18.png"];
    UIImageView *mailimageV = [[UIImageView alloc]initWithImage:emailimage];
    UIView *lv3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    mailimageV.center = lv3.center;
    [lv3 addSubview:mailimageV];
    //_email.leftView = lv3;
    [_background addSubview:_email];
    
   
    
    
    _loginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_loginButton setFrame:CGRectMake(20, 420, self.view.frame.size.width-40, 50)];
    
    [_loginButton setTitle:@"注册" forState:UIControlStateNormal];
    //[_loginButton setBackgroundColor:[UIColor colorWithRed:255.0 green:190.0 blue:177.0 alpha:1]];
    [_loginButton setBackgroundColor:[UIColor colorWithHexString:@"#FF77B1"]];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(logintouchclicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginButton];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_account resignFirstResponder]; // 空白处收起
    [_password resignFirstResponder]; // 空白处收起
    
}

-(void)logintouchclicked
{
    //登陆跳转到主界面按钮
  
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

@end
