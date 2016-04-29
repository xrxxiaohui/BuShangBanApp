//
//  OtherViewController.h
//  BuShangBanApp
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

@class MineSectionHeaderView;

@interface OtherViewController : QHBasicViewController

@property(nonatomic,strong)NSMutableArray *titleDataSource;
@property(nonatomic,strong)NSMutableArray *imageDataSource;
@property(nonatomic,strong)MineSectionHeaderView *sectionHeaderView;
-(void)settingBtn:(UIButton *)btn;

@end
