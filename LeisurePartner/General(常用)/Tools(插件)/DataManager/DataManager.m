//
//  DataManager.m
//  PrivateSector
//
//  Created by lovebobo on 13/12/18.
//  Copyright © 2018年 lovebobo. All rights reserved.
//
//在DataManager.m里
#import "DataManager.h"
#import <AFNetworking.h>
#import "JSONKit.h"
#import <UIKit+AFNetworking.h>

static DataManager *manager = nil;
static AFHTTPSessionManager *afnManager = nil;

@implementation DataManager

/**
 *  创建单例
 *
 *  @return <#return value description#>
 */
+ (DataManager *)manager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
        afnManager = [AFHTTPSessionManager manager];
        afnManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        // 设置超时时间
        [afnManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        afnManager.requestSerializer.timeoutInterval = 5.f;
        [afnManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        afnManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return manager;
}

/**
 *  处理字符串将其转成标准json格式
 *
 *  @param data 响应数据
 *
 *  @return id
 */
+ (id)handleResponseObject:(NSData *)data {
    
    //将获取的二进制数据转成字符串
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //去掉字符串里的转义字符
    NSString *str1 = [str stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    //去掉头和尾的引号“”
    NSString *str2 = [str1 substringWithRange:NSMakeRange(1, str1.length-2)];
    //最终str2为json格式的字符串，将其转成需要的字典和数组
    //id object = [str2 objectFromJSONString];
    
    return str;
}

/**
 *  提示信息
 *
 *  @param message 要提示的内容
 */
+ (void)showAlertViewWithMessage:(NSString *)message {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
//GET请求
- (void)getDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramters success:(Success)success failure:(Failure)failure {
    
    //afnManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [afnManager GET:url parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success([[self class] handleResponseObject:responseObject]);
        }else {
            [[self class] showAlertViewWithMessage:@"暂无数据"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [[self class] showAlertViewWithMessage:@"服务器出错了~~~~(>_<)~~~~"];
            failure(error);
        }
    }];
    
}

//POST请求
- (void)postDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramters success:(Success)success failure:(Failure)failure {
    
    [afnManager POST:url parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success([[self class] handleResponseObject:responseObject]);
        }else {
            [[self class] showAlertViewWithMessage:@"暂无数据"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            [[self class] showAlertViewWithMessage:@"服务器出错了~~~~(>_<)~~~~"];
            failure(error);
        }
    }];
}
@end
