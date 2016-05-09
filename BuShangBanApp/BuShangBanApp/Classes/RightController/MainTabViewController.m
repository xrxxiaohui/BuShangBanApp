//
//  MainTabViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "MainTabViewController.h"

#import "UserAccountManager.h"
#import "SSLXResultRequest.h"
#import "SSLXNetworkManager.h"

#import "LocationManager.h"
#import "APIRequestManager.h"


#import "HomePageViewController.h"
#import "FindViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"

@interface MainTabViewController () <UITabBarControllerDelegate> {
    BOOL _needPop;
    UIControl *_shadowView;
}

@end

@implementation MainTabViewController

static MainTabViewController *main;

+ (MainTabViewController *)getMain {
    return main;
}

- (id)init {
    self = [super init];

    main = self;

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoFirstpage) name:@"gotoFirstPage" object:nil];

    if ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 6 ) {
        [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    }

    _tabController = [[UITabBarController alloc] init];
    [_tabController.tabBar setBackgroundColor:[UIColor whiteColor]];
    [_tabController.view setFrame:self.view.frame];
    [self.view addSubview:_tabController.view];
    _tabController.delegate = self;

    HomePageViewController *homePageViewController = [[HomePageViewController alloc] init];
    MineViewController *mineViewController = [[MineViewController alloc] init];
    MessageViewController *messageController = [[MessageViewController alloc] init];
    FindViewController *findViewController = [[FindViewController alloc] init];

    _tabController.viewControllers = @[homePageViewController, findViewController, messageController, mineViewController];

    [self reloadImage];
    //    [[UITabBarItem appearance] setTitleTextAttributes:
    //        [NSDictionary dictionaryWithObjectsAndKeys:RGBA(96, 164, 222, 1), UITextAttributeTextColor, nil]
    //                                             forState:UIControlStateNormal];
    //    [[UITabBarItem appearance] setTitleTextAttributes:
    //        [NSDictionary dictionaryWithObjectsAndKeys:RGBA(96, 164, 222, 1), UITextAttributeTextColor, nil]
    //                                             forState:UIControlStateSelected];
    //    [_tabC.tabBar setTintColor:RGBA(96, 164, 222, 1)];
    [_tabController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBottom"]];
    _tabController.tabBar.translucent = YES;
//    [_tabController.tabBar setAlpha:0.94];
    [_tabController.tabBar setClipsToBounds:YES];
    [_tabController setSelectedIndex:0];


    _shadowView = [[UIControl alloc] initWithFrame:CGRectMake(0, self.view.height - _tabController.tabBar.height, _tabController.tabBar.width, _tabController.tabBar.height)];
    [_shadowView addTarget:self action:@selector(shadowViewClick:) forControlEvents:UIControlEventTouchUpInside];
    [_shadowView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3f]];
    [_shadowView setAlpha:0.01];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    effectview.frame = CGRectMake(0, 0, _tabController.tabBar.width, _tabController.tabBar.height);
    
    [_shadowView addSubview:effectview];
    [self.view addSubview:_shadowView];


//    [self addLoginOrRigistView];

}

-(void)gotoFirstpage
{
    [_tabController setSelectedIndex:0];
}


- (void)shadowViewClick:(UIControl *)control {
    
}

//-(void)pushToDemoExample {
//
//    DemoExampleController *_demoExampleController = [[DemoExampleController alloc] init];
//    [[SliderViewController sharedSliderController].navigationController pushViewController:_demoExampleController animated:YES];
//}

- (void)dismissShadowViewNotification:(NSNotification *)notify {

    [UIView animateWithDuration:0.3f animations:^{
        _shadowView.alpha = 0;
    }];
}

- (void)showShadowViewNotification:(NSNotification *)notify {

    [UIView animateWithDuration:0.3f animations:^{
        _shadowView.alpha = 1;
    }];
}


- (void)reloadImage {
    [super reloadImage];

    //    NSString *imageName = nil;
    //    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1 && [QHConfiguredObj defaultConfigure].nThemeIndex != 0)
    //    {
    //        imageName = @"tabbar_bg_ios7.png";
    //    }else
    //    {
    //        imageName = @"tabbar_bg.png";
    //    }
    //    [_tabController.tabBar setBackgroundImage:[QHCommonUtil imageNamed:imageName]];

    //  UIImage *tempImage = [self imageWithColor:[UIColor whiteColor] size:CGSizeMake(_tabController.tabBar.width, _tabController.tabBar.height)];
    [_tabController.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBottom"]];
    //    _tabController.tabBar.translucent = YES;
    //    [_tabController.tabBar setBackgroundColor:[UIColor redColor]];
//    [_tabController.tabBar setAlpha:0.94];

    NSArray *ar = _tabController.viewControllers;
    NSMutableArray *arD = [NSMutableArray new];
    [ar enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        //        UITabBarItem *item = viewController.tabBarItem;
        UITabBarItem *item = nil;
        switch ( idx ) {
            case 0: {
                //首页
                item = [[UITabBarItem alloc] initWithTitle:@"阅读" image:nil tag:0];
                [item setImage:[[QHCommonUtil imageNamed:@"read_icon_nomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[QHCommonUtil imageNamed:@"read_icon_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

                break;
            }
            case 1: {
                //发现
                item = [[UITabBarItem alloc] initWithTitle:@"发现" image:nil tag:1];
                [item setImage:[[QHCommonUtil imageNamed:@"find_icon_nomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[QHCommonUtil imageNamed:@"find_icon_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
            }
                break;
            case 2: {
                //消息
                item = [[UITabBarItem alloc] initWithTitle:@"消息" image:nil tag:1];
                [item setImage:[[QHCommonUtil imageNamed:@"information_icon_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[QHCommonUtil imageNamed:@"information_icon_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

            }
                break;
            case 3: {
                //我的
                item = [[UITabBarItem alloc] initWithTitle:@"我的" image:nil tag:3];
                [item setImage:[[QHCommonUtil imageNamed:@"personal_icon_nomal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
                [item setSelectedImage:[[QHCommonUtil imageNamed:@"personal_icon_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

                break;
            }

        }
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR(7, 139, 109), NSFontAttributeName : [UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : kTabBtnNormalColor, NSFontAttributeName : [UIFont systemFontOfSize:10]} forState:UIControlStateNormal];

        viewController.tabBarItem = item;
        [arD addObject:viewController];
        
    }];
    _tabController.viewControllers = arD;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

}

#pragma mark - PopupView Delegate

- (void)backToHomeController {

    [_tabController setSelectedIndex:0];
}

#pragma mark - LocationManagerCompletionNotification Method

- (void)locationManagerCompletionNotification:(NSNotification *)noti {

    //    CLLocationCoordinate2D myCoordinate = [LocationManager Instance].location.coordinate;

    [[APIRequestManager sharedInstance] postDeviceTokenReq];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
