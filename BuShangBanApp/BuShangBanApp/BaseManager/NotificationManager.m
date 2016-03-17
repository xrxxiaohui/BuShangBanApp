//
//  NotificationManager.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "NotificationManager.h"

@implementation NotificationManager

+(void)localNotification {

    // 创建一个本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    //设置10秒之后
    NSDate *pushDate = [NSDate dateWithTimeIntervalSinceNow:10];
    if (notification != nil) {
        // 设置推送时间
        notification.fireDate = pushDate;
        //推送时区设置:从网上搜到
        //timeZone是UILocalNotification激发时间是否根据时区改变而改变，如果设置为nil的话，
        //那么UILocalNotification将在一段时候后被激发，而不是某一个确切时间被激发。
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 设置重复间隔,若不设置将只会推送1次
        notification.repeatInterval = kCFCalendarUnitDay;
        // 推送声音,（若不设置的话系统推送时会无声音）
        notification.soundName = UILocalNotificationDefaultSoundName;
        // 推送内容,（若不设置，推送中心中不显示文字，有声音提示前提是设置有声音）
        notification.alertBody = @"推送内容";
        //推送时小图标的设置，PS:这个东西不知道还有啥用
        notification.alertLaunchImage = [[NSBundle mainBundle]pathForResource:@"3" ofType:@"jpg"];
        //显示在icon上的红色圈中的数子
        notification.applicationIconBadgeNumber = 1;
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
        notification.userInfo = info;
        
        //讲推送设置以及信息加入
        UIApplication* app=[UIApplication sharedApplication];
        BOOL status=YES;
        for (UILocalNotification* notification in app.scheduledLocalNotifications)
        {
            if ([notification.userInfo objectForKey:@"key"]) {
                status=NO;
            }
        }  
        
        if (status) {  
            //加入推送(只能加入一次)  
            [app scheduleLocalNotification:notification];  
        }  
        
    }
}

@end
