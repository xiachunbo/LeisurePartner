//
//  NewsListModel.m
//  LeisurePartner
//
//  Created by chunbo xia on 2020/6/23.
//  Copyright © 2020 lovebobo. All rights reserved.
//

#import "NewsListModel.h"

@implementation NewsListModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self=[super init]) {
        _NewsTitle = [dict objectForKey:@"title"];
        _NewsDesc = @"经典笑话:悲喜交加 一位上了年纪的男子坐在公园长凳上独自垂泪。警察走上前去,问他出了什么事。“我75岁了,”那老人哭泣着说,“在家里我有个25岁的妻子,她...";
        _NewsDate = [dict objectForKey:@"ptime"];
        _NewsClassName = [dict objectForKey:@"videosource"];
        _NewsImage = [dict objectForKey:@"cover"];
    }
    return self;
}
@end

