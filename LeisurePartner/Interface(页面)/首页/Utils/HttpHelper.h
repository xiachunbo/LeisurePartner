//
//  UrlDefine.h
//  LeisurePartner
//
//  Created by chunbo xia on 2020/6/23.
//  Copyright © 2020 lovebobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HttpHelper : NSObject
+ (void)post:(NSString *)Url RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;//post请求封装

@end
