//
//  MineViewController.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

<<<<<<< HEAD:BuShangBanApp/BuShangBanApp/Classes/RightController/我的/MineViewController.h
#import "MineSectionHeaderView.h"
=======
@class MineSectionHeaderView;
>>>>>>> 631fb96176c49484a20f939c338bac2508d197c6:BuShangBanApp/BuShangBanApp/Classes/RightController/我的/Mine/MineViewController.h

@interface MineViewController : QHBasicViewController

@property(nonatomic,strong)NSMutableArray *titleDataSource;
@property(nonatomic,strong)NSMutableArray *imageDataSource;
@property(nonatomic,strong)MineSectionHeaderView *sectionHeaderView;
-(void)settingBtn:(UIButton *)btn;

@end

