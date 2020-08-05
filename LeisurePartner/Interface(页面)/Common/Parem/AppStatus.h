//
//  AppStatus.h
//  PrivateSector
//
//  Created by lovebobo on 18/1/19.
//  Copyright © 2019年 lovebobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppStatus : NSObject
{
    NSString *_contextStr;
}
@property(nonatomic,retain)NSString *contextStr;

+(AppStatus *)shareInstance;

@end
