//
//  MineViewController.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "MineSectionHeaderView.h"

@interface MineViewController : QHBasicViewController

@property(nonatomic,strong)NSMutableArray *titleDataSource;
@property(nonatomic,strong)NSMutableArray *imageDataSource;
@property(nonatomic,strong)MineSectionHeaderView *sectionHeaderView;
-(void)settingBtn:(UIButton *)btn;

@end

