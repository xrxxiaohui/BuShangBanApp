//
//  QHBasicViewController.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QHCommonUtil.h"
//#import "UITempletViewController.h"

#define kMBProgressLoadingTitle    @"数据加载中.."
#define kMBProgressErrorTitle      @"服务器繁忙，请稍后再试"

typedef void(^backBlock)(void);
typedef void(^actionBlock)(void);

@interface QHBasicViewController : UIViewController

@property (nonatomic, strong) UIImageView *statusBarView;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, assign, readonly) int nMutiple;
@property (nonatomic, strong) NSArray *arParams;
@property (nonatomic, strong) UIView *rightV;

// cellHeight key value
@property (nonatomic, strong) NSMutableDictionary *indexPathHeightDict;

@property (nonatomic, copy) backBlock baseBackBlock;

- (id)initWithFrame:(CGRect)frame param:(NSArray *)arParams;

- (void)createNavWithTitle:(NSString *)szTitle createMenuItem:(UIView *(^)(int nIndex))menuItem;

- (void)createAnswerNavWithTitle:(NSString *)szTitle createMenuItem:(UIView *(^)(int nIndex))menuItem;
- (void)createNavWithSearchBar:(NSString *)szTitle createMenuItem:(UIView *(^)(int nIndex))menuItem;

- (void)reloadImage;

- (void)reloadImage:(NSNotificationCenter *)notif;

- (void)subReloadImage;

- (void)addObserver;


// custom view method
-(void)customNavigationTitle:(NSString *)title ;
-(void)customNavigationBarWithTitle:(NSString *)title ;
-(void)customLeftItemWithBtn:(UIButton *)sender;
-(void)customRightItemWithBtn:(UIButton *)sender;
-(void)customNavigationBarWithImage:(NSString *)image;

@end
