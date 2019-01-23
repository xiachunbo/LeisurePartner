//
//  AppDelegate.h
//  LeisurePartner
//
//  Created by lovebobo on 23/1/19.
//  Copyright © 2019年 lovebobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

