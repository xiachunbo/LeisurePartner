//
//  LeftViewController.h
//  PrivateSector
//
//  Created by lovebobo on 6/9/18.
//  Copyright © 2018年 lovebobo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeMenuViewDelegate <NSObject>

-(void)LeftMenuViewClick:(NSInteger)tag;

@end
@interface LeftViewController : UIViewController
@property (nonatomic ,weak)id <HomeMenuViewDelegate> customDelegate;
@end
