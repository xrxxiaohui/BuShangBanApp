//
//  SettingCell.m
//  BuShangBanApp
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SettingCell.h"
#import "SettingViewController.h"

@implementation SettingCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(12,11, 58, 58)];
        _headImageView.layer.cornerRadius=29.f;
        _headImageView.clipsToBounds=YES;
        [self addSubview:_headImageView];
        
        _titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 22, 100, 15)];
        _titleLabel.font=[UIFont fontWithName:fontName size:15];
        _titleLabel.textColor=[UIColor colorWithHexString:@"383838"];
        [self addSubview:_titleLabel];
        
        _detailTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, 47, 100, 12)];
        _detailTitleLabel.font=[UIFont fontWithName:fontName size:12];
        _detailTitleLabel.textColor=[UIColor colorWithHexString:@"7c7c7c"];
        [self addSubview:_detailTitleLabel];
        
        _editBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.frame=CGRectMake(kScreenWidth-44, 0, 44, 44);
        [_editBtn setImage:[UIImage imageNamed:@"modify"] forState:UIControlStateNormal];
        [_editBtn addTarget:[[SettingViewController alloc]init]  action:@selector(btnEvent) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_editBtn];
    }
    return self;
}

@end
