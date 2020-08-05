//
//  UITableViewCell.m
//  LeisurePartner
//
//  Created by chunbo xia on 2020/6/23.
//  Copyright © 2020 lovebobo. All rights reserved.
//

#import "UITableViewCell.h"

@interface NJWeiboCell ()
@end
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellstr = @"newslistcell";
    NewsListCell *cell=[tableView dequeueReusableCellWithIdentifier:cellstr];
    if (cell==nil) {
        cell=[[NewsListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
    }
    return cell;
}

#pragma mark - 重写初始化方法
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _NewsTitle=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 21)];
        _NewsTitle.font=[UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:_NewsTitle];
        
        _NewsImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 37 ,100, 75)];
        [self.contentView addSubview:_NewsImage];
        
        _NewsDesc = [[UILabel alloc] initWithFrame:CGRectMake(120, 37, SCREEN_WIDTH-130, 60)];
        _NewsDesc.numberOfLines=3;
        _NewsDesc.font=[UIFont systemFontOfSize:14];
        _NewsDesc.textColor = [UIColor grayColor];
        [self.contentView addSubview:_NewsDesc];
        
        _NewsDate = [[UILabel alloc] initWithFrame:CGRectMake(120, 97, SCREEN_WIDTH-20, 18)];
        _NewsDate.font=[UIFont systemFontOfSize:12];
        _NewsDate.textColor=[UIColor grayColor];
        [self.contentView addSubview:_NewsDate];
        
        _NewsClassName =[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-65, 98, 55, 17)];
        _NewsClassName.font=[UIFont systemFontOfSize:10];
        _NewsClassName.textColor = COLOR(15, 111, 172, 1);
        _NewsClassName.layer.borderColor = COLOR(15, 111, 172, 1).CGColor;
        _NewsClassName.layer.borderWidth = 0.5f;
        _NewsClassName.textAlignment=NSTextAlignmentCenter;
        [self.contentView addSubview:_NewsClassName];
    }
    return self;
}

#pragma mark - 重构函数
-(void)setNews:(NewsListModel *)modnews
{
    _news = modnews;
    
    _NewsTitle.text = modnews.NewsTitle;
    _NewsDate.text = modnews.NewsDate;
    _NewsClassName.text = modnews.NewsClassName;
    //_NewsDesc.text = modnews.NewsDesc;
    [_NewsImage sd_setImageWithURL:[NSURL URLWithString:modnews.NewsImage] placeholderImage:[UIImage imageNamed:@"defaultimage"]];
    
    //测试代码设置行高
    if ([modnews.NewsDesc isEqualToString:@""] == NO)
    {
        NSMutableAttributedString *attributedstring =[[NSMutableAttributedString alloc] initWithString:modnews.NewsDesc];
        NSMutableParagraphStyle *paragraphstyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphstyle setLineSpacing:2.8f];
        [attributedstring addAttribute:NSParagraphStyleAttributeName value:paragraphstyle range:NSMakeRange(0, [modnews.NewsDesc length])];
        [_NewsDesc setAttributedText:attributedstring];
    }else{
        _NewsDesc.text = @"";
    }
    
}
@end
