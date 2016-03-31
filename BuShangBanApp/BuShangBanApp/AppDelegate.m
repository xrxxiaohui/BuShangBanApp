//
//  AppDelegate.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "AppDelegate.h"
#import "UIWindow+Extension.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <AVOSCloud/AVOSCloud.h>
#import "LoginOrRegistViewController.h"

@interface AppDelegate ()

@end

AppDelegate *_appDelegate = nil;

@implementation AppDelegate

+ (AppDelegate *)shareAppDelegate {
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    [self initializePlat:launchOptions];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 通过版本切换引导页主页
    [self.window switchRootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)initializePlat:(NSDictionary *)launchOptions {
    NSString *infoConfigPath = [[NSBundle mainBundle] pathForResource:@"infoConfig" ofType:@"plist"];
    NSDictionary *infoConfigDic = [[NSDictionary alloc] initWithContentsOfFile:infoConfigPath];
    
    //    leanCloud
    [AVOSCloud setApplicationId:
                       [infoConfigDic objectForKey:@"AVOSCloudAPPID"]
                      clientKey:[infoConfigDic objectForKey:@"AVOSCloudAppKey"]];
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

#ifdef DEBUG
    [AVAnalytics setAnalyticsEnabled:NO];
    [AVOSCloud setAllLogsEnabled:YES];
#endif
    [AVOSCloud setLastModifyEnabled:YES];
    [AVOSCloud setNetworkTimeoutInterval:30];
    [[AVInstallation currentInstallation] saveInBackground];


    //    微信  微博
    [ShareSDK registerApp:@"1701171842" activePlatforms:@[@(SSDKPlatformTypeSinaWeibo), @(SSDKPlatformTypeWechat)] onImport:^(SSDKPlatformType platformType) {
                platformType == SSDKPlatformTypeWechat ? [ShareSDKConnector connectWeChat:[WXApi class]] : nil;
                platformType == SSDKPlatformTypeSinaWeibo ? [ShareSDKConnector connectWeChat:[WeiboSDK class]] : nil;
            }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              platformType == SSDKPlatformTypeSinaWeibo ?
                      [appInfo     SSDKSetupSinaWeiboByAppKey: [infoConfigDic objectForKey:@"shareSDKSinaWeiboAppKey"]
             appSecret:[infoConfigDic objectForKey: @"shareSDKSinaWeiboAppSecret"] redirectUri:
                                      [infoConfigDic objectForKey:@"shareSDKSinaWeiboRedirectUrl"] authType:SSDKAuthTypeBoth] : nil;

              platformType == SSDKPlatformTypeWechat ?
                      [appInfo SSDKSetupWeChatByAppId:[infoConfigDic objectForKey:
                                                                             @"shareSDKWeChatAppID"] appSecret:[infoConfigDic objectForKey:@"shareSDKWeChatappSecret"]] : nil;
          }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
