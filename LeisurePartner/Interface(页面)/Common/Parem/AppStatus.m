//
//  AppStatus.m
//  PrivateSector
//
//  Created by lovebobo on 18/1/19.
//  Copyright © 2019年 lovebobo. All rights reserved.
//

#import "AppStatus.h"

@implementation AppStatus
@synthesize contextStr = _contextStr;

static AppStatus *_instance = nil;
+(AppStatus *)shareInstance
{
    if (_instance == nil)
    {
        _instance = [[super alloc]init];
    }
    return _instance;
}

-(id)init
{
    if (self = [super init])
    {
        
    }
    return  self;
}
@end
