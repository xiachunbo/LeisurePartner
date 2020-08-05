//
//  NewsListModel.h
//  LeisurePartner
//
//  Created by chunbo xia on 2020/6/23.
//  Copyright © 2020 lovebobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListModel : NSObject

@property(nonatomic,copy) NSString *NewsID;
@property(nonatomic,copy) NSString *NewsTitle;
@property(nonatomic,copy) NSString *NewsDesc;
@property(nonatomic,copy) NSString *NewsDate;
@property(nonatomic,copy) NSString *NewsClassName;
@property(nonatomic,copy) NSString *NewsImage;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
