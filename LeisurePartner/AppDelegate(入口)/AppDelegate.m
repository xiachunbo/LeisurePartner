//
//  AppDelegate.m
//  PrivateSector
//
//  Created by lovebobo on 23/4/18.
//  Copyright © 2018年 lovebobo. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchIntroductionView.h"
#import "TabBarController.h"
#import "Reachability.h"
#import <AVFoundation/AVFoundation.h>
#import <UserNotifications/UserNotifications.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "JXTAlertManagerHeader.h"
#define APP_ID @"wx77403131538f1131"
#define APP_SECRET @"abdf38333a20feda44583c0ff90af92c"
#import "LeftViewController.h"
#import "LoginController.h"
#import "NavigationController.h"
#import "ZZAudioTool.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIApplication *myApplication = [UIApplication sharedApplication];[myApplication setStatusBarHidden:NO];[myApplication setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    //3D Touch按压程序图标的快捷项
    //快捷菜单的图标
    UIApplicationShortcutIcon *icon1=[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCaptureVideo];
    UIApplicationShortcutIcon *icon2=[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    UIApplicationShortcutIcon *icon3=[UIApplicationShortcutIcon iconWithTemplateImageName:@"search"];
    //快捷菜单
    UIApplicationShortcutItem *item1=[[UIApplicationShortcutItem alloc]initWithType:@"1"
                                                                     localizedTitle:@"嘿嘿"
                                                                  localizedSubtitle:nil
                                                                               icon:icon1
                                                                           userInfo:nil];
    UIApplicationShortcutItem *item2=[[UIApplicationShortcutItem alloc]initWithType:@"1"
                                                                     localizedTitle:@"呵呵"
                                                                  localizedSubtitle:@"无聊"
                                                                               icon:icon2
                                                                           userInfo:nil];
    UIApplicationShortcutItem *item3=[[UIApplicationShortcutItem alloc]initWithType:@"1"
                                                                     localizedTitle:@"搜索"
                                                                  localizedSubtitle:nil
                                                                               icon:icon3
                                                                           userInfo:nil];
    //设置app的快捷菜单
    [[UIApplication sharedApplication] setShortcutItems:@[item1,item2,item3]];
    //后台播放
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session  setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    [application beginReceivingRemoteControlEvents];//开启接收远程事件
    //添加系统引导页
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor grayColor];
    LoginController *login = [[LoginController alloc] init];
    NavigationController *na = [[NavigationController alloc] initWithRootViewController:login];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    na.navigationItem.leftBarButtonItem = item;
    na.navigationBar.barStyle = UIStatusBarStyleDefault;
    self.window.rootViewController = na;
    
    [self.window makeKeyAndVisible];
    [LaunchIntroductionView sharedWithImages:@[@"guid.png",@"guid.png",@"guid.png"] buttonImage:@"login" buttonFrame:CGRectMake(kScreen_width/2 - 551/4, kScreen_height - 150, 551/2, 45)];
    Reachability *reach  =[Reachability reachabilityForInternetConnection];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [reach startNotifier];
    //判断是否由远程消息通知触发应用程序启动
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]!=nil) {
        //获取应用程序消息通知标记数（即小红圈中的数字）
        long badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (badge>0) {
            //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
            badge--;
            //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
        }
    }else{
        long badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
        if (badge>0) {
            //如果应用程序消息通知标记数（即小红圈中的数字）大于0，清除标记。
            badge--;
            //清除标记。清除小红圈中数字，小红圈中数字为0，小红圈才会消除。
            [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
        }
        
    }
    //消息推送注册
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //iOS10特有
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 点击允许
                NSLog(@"注册成功");
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    NSLog(@"%@", settings);
                }];
            } else {
                // 点击不允许
                NSLog(@"注册失败");
            }
        }];
    }else if ([[UIDevice currentDevice].systemVersion floatValue] >8.0){
        //iOS8 - iOS10
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
    }else if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        //iOS8系统以下
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    
    // 注册获得device Token
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    [NSThread sleepForTimeInterval:1.0];
    return YES;
}

/** 监听远程事件 */
-(void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay: // 播放
            NSLog(@"播放");
            [ZZAudioTool playMusic:@"1"]; // 控制播放与暂停
            break;
        case UIEventSubtypeRemoteControlPause: // 暂停
            NSLog(@"暂停");
            [ZZAudioTool pauseMusic:@"1"]; // 控制播放与暂停
            break;
        case UIEventSubtypeRemoteControlNextTrack: // 下一首
            NSLog(@"下一首");
            //[self next]; // 控制播放下一首
            break;
        case UIEventSubtypeRemoteControlPreviousTrack: // 上一首
            NSLog(@"上一首");
            //[self previous]; // 控制播放上一首
            break;
        default:
            break;
    }
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"receive remote notification:  %@", userInfo);
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
    //获取终端设备标识，这个标识需要通过接口发送到服务器端，服务器端推送消息到APNS时需要知道终端的标识，APNS通过注册的终端标识找到终端设备。
    NSLog(@"My token is:%@", token);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
    
}
#pragma mark - 此方法是 用户点击了通知，应用在前台 或者开启后台并且应用在后台 时调起
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
    // 打印到日志 textView 中
    NSLog(@"********** iOS7.0之后 background **********");
    // 应用在前台 或者后台开启状态下，不跳转页面，让用户选择。
    if (application.applicationState == UIApplicationStateActive || application.applicationState == UIApplicationStateBackground) {
        NSLog(@"acitve or background");
        NSString *message = [[userInfo objectForKey:@"aps"]objectForKey:@"alert"];
        NSLog(@"-----",message);
        jxt_showAlertTwoButton(@"消息推送",message ,
                               @"Ok", ^(NSInteger buttonIndex) {
                                   NSLog(@"Ok");
                               }, @"Cancel", ^(NSInteger buttonIndex) {
                                   NSLog(@"Cancel");
                               });
        
        //[alert show];
    }
    else//杀死状态下，直接跳转到跳转页面。
    {
        MessageViewController *VC = [[MessageViewController alloc] init];
        UINavigationController *na = [[UINavigationController alloc] initWithRootViewController:VC];
        [self.window.rootViewController presentViewController:na animated:YES completion:nil];
    }
}

- (IBAction)showAlert {
    
    
}
-(void)application:(UIApplication* )application performActionForShortcutItem:(UIApplicationShortcutItem* )shortcutItem completionHandler:(void (^)(BOOL))completionHandler
    {
        NSString *title;
        if([shortcutItem.localizedTitle isEqualToString:@"嘿嘿"])
        {
            title=@"嘿嘿";
        }
        else if([shortcutItem.localizedTitle isEqualToString:@"呵呵"])
        {
            title=@"呵呵";
        }
        else if([shortcutItem.localizedTitle isEqualToString:@"搜索"])
        {
            title=@"搜索";
        }
        //这里就弹个框子意思一下
        //由于UIAlertView在iOS 9被废弃，因此选用UIAlertController
        UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示"
                                                                               message:[NSString stringWithFormat:@"你点击了“%@”",title]
                                                                        preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action=[UIAlertAction actionWithTitle:@"知道了"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction*  action) {
                                                         [alertController dismissViewControllerAnimated:YES completion:nil];
                                                     }];
        [alertController addAction:action];
        [self.window.rootViewController presentViewController:alertController
                                                     animated:YES
                                                   completion:nil];
    }
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    //[self saveContext];
}



- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability *preachability = [note object];
    NSParameterAssert([preachability isKindOfClass:[Reachability class]]);
    NSString *pStr_3G =@"当前网络为3G或4G流量";
    NSString *pStr_WiFi =@"当前网络为Wi-Fi";
    //    NSString *pStr_WLAN =@"当前网络为WLAN";
    NSString *pStr_NO = @"当前网络已经断开";
    switch ([preachability currentReachabilityStatus]) {
        case NotReachable:
            [self alertShow:pStr_NO];
            break;
        case ReachableViaWiFi:
            //[self alertShow:pStr_WiFi];
            break;
        case ReachableViaWWAN:
            //[self alertShow:pStr_3G];
            break;
        default:
            break;
    }
}

- (void)alertShow:(NSString *)mes
{
    UIAlertView *AlertView = [[UIAlertView alloc]initWithTitle:@"通知" message:mes delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [AlertView show];
    
}
#pragma mark - Core Data Saving support

#pragma mark - openURL
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    //if ([url.scheme isEqualToString:@"wx77403131538f1131"]){
    return YES;
    
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
   
        return YES;
    
}



#pragma mark -- QQApiInterfaceDelegate
@end
