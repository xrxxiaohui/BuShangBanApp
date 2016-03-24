//
//  UIWindow+Extension.m
//  Peter Lee
//
//  Created by apple on 15-9-15.
//  Copyright (c) 2015年 Peter Lee. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "SSNewFeatureViewController.h"
#import "SliderViewController.h"
#import "LeftViewController.h"
#import "MLBlackTransition.h"
#import "MainTabViewController.h"
#import "ConstObject.h"

@implementation UIWindow (Extension)
- (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
        self.rootViewController = [self mainVc];
    } else { // 这次打开的版本和上一次不一样，显示新特性
        self.rootViewController = [[SSNewFeatureViewController alloc] init];
        // 将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

//创建主视图和左视图
- (id)mainVc{

//    LeftViewController *leftVC = [[LeftViewController alloc] init];
//    [SliderViewController sharedSliderController].LeftVC = leftVC;
    [SliderViewController sharedSliderController].LeftVC = nil;
    [SliderViewController sharedSliderController].MainVC = [[MainTabViewController alloc] init];
    if(iPhone5)
        [SliderViewController sharedSliderController].LeftSContentOffset=280;
    else if(iPhone6)
        [SliderViewController sharedSliderController].LeftSContentOffset=312;
    else
        [SliderViewController sharedSliderController].LeftSContentOffset=360;
    [SliderViewController sharedSliderController].LeftContentViewSContentOffset = 50;
    [SliderViewController sharedSliderController].LeftSContentScale=1;//缩放
    [SliderViewController sharedSliderController].LeftSJudgeOffset=100;
    [SliderViewController sharedSliderController].changeLeftView = ^(CGFloat sca, CGFloat transX)
    {
//        CGAffineTransform ltransS = CGAffineTransformMakeScale(sca, sca);
//        CGAffineTransform ltransT = CGAffineTransformMakeTranslation(transX, 0);
//        CGAffineTransform lconT = CGAffineTransformConcat(ltransT, ltransS);
//        leftVC.contentView.transform = lconT;
    };

    //手势返回更新为MLBlackTransition
    [MLBlackTransition validatePanPackWithMLBlackTransitionGestureRecognizerType:MLBlackTransitionGestureRecognizerTypePan];

    UINavigationController *naviC = [[UINavigationController alloc] initWithRootViewController:[SliderViewController sharedSliderController]];
    [[ConstObject instance] setMainNavigationController:naviC];
    return naviC;
    
}
@end
