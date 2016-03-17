//
//  MainTabViewController.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabViewController : QHBasicViewController

@property(nonatomic,retain)UITabBarController *tabController;;

+ (MainTabViewController *)getMain;

@end
