//
//  NewsListCell.h
//  LeisurePartner
//
//  Created by chunbo xia on 2020/6/23.
//  Copyright © 2020 lovebobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsListModel.h"

@interface NewsListCell : UITableViewCell

@property(nonatomic,strong) UIImageView *NewsImage;
@property(nonatomic,strong) UILabel *NewsTitle;
@property(nonatomic,strong) UILabel *NewsClassName;
@property(nonatomic,strong) UILabel *NewsDate;
@property(nonatomic,strong) UILabel *NewsDesc;

@property(nonatomic,strong) NewsListModel *news;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
