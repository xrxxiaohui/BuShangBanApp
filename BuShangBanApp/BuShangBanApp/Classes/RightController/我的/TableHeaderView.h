//
//  TableHeaderView.h
//  BuShangBanApp
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "BaseView.h"
#import "ScreenAdapt.h"
#import "UIView+Frame.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]
#define tableHeaderViewHeight 200

@interface TableHeaderView : BaseView
@property(nonatomic, strong) UIImageView *bgImageView;
@property(nonatomic, strong) UIButton *headImageBtn;
//@property(nonatomic,strong)UIVisualEffectView *blurView;

- (void)nickNameLabelWithNickName:(NSString *)nickName label:(NSString *)label;

- (void)descriptionLabelWithText:(NSString *)text;

@end
