//
//  NSObject+EmptyData.h
//  LeisurePartner
//
//  Created by xiaobobo on 2017/7/15.
//  Copyright © 2017年 Mac. All rights reserved.
//
//.h文件
#import <UIKit/UIKit.h>

@interface UITableView (EmptyData)

- (void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

@end
