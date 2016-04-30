//
//  MineSectionHeaderView.h
//  BuShangBanApp
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 Zuo. All rights reserved.
//



#import "ScreenAdapt.h"
#import "UIView+Frame.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]
#define sectionHeaderViewHeight 200

@interface MineSectionHeaderView : UICollectionReusableView

@property(nonatomic, strong) UIImageView *bgImageView;
@property(nonatomic, strong) UIButton *headImageBtn;
@property(nonatomic, strong) UIButton *settingBtn;
//@property(nonatomic,strong)UIVisualEffectView *blurView;

- (void)nickNameLabelWithNickName:(NSString *)nickName label:(NSString *)label;

- (void)descriptionLabelWithText:(NSString *)text;

@end
