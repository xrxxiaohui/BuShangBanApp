//
//  SettingViewController.h
//  BuShangBanApp
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 Zuo. All rights reserved.
//


@interface SettingViewController : QHBasicViewController

-(void)initWithImageURL:(NSURL *)imageURL;
@property(nonatomic,copy)NSString *userNames;
@property(nonatomic,copy)NSString *detailtext;

//-(void)btnEvent;

@end
