//
//  TableHeaderView.m
//  BuShangBanApp
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "TableHeaderView.h"
#import "MineViewController.h"



@interface TableHeaderView()

@property(nonatomic,strong)UIButton *settingBtn;
@property(nonatomic,strong)UILabel *nickNameLabel;
@property(nonatomic,strong)UILabel *descriptionLabel;

@end



@implementation TableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.bgImageView];
        [self addSubview:self.headImageView];
        [self addSubview:self.settingBtn];
    }
    return self;
}

-(void)nickNameLabelWithNickName:(NSString *)nickName label:(NSString *)label
{
    [self __nickNameLabel];
    //    self.nickNameLabel.attributedText
    self.nickNameLabel.text=[NSString stringWithFormat:@"%@%@",nickName,label];
    [_nickNameLabel sizeToFit];
    _nickNameLabel.centerX=self.centerX;
    _nickNameLabel.top=128.f;
    [self addSubview:_nickNameLabel];
}

-(void)descriptionLabelWithText:(NSString *)text
{
    [self __descriptionLabel];
    _descriptionLabel.text=text;
    [_descriptionLabel sizeToFit];
    _descriptionLabel.centerX=self.centerX;
    _descriptionLabel.top=163.f;
    [self addSubview:_descriptionLabel];
}


-(UIImageView *)bgImageView
{
    if (!_bgImageView)
    {
        _bgImageView=[[UIImageView alloc]init];
        _bgImageView.size=self.size;
        _bgImageView.left=0;
        _bgImageView.top=0;     
        _bgImageView.image=[UIImage imageNamed:@"bg"];
    }
    return _bgImageView;
}

-(UIButton *)settingBtn
{
    if (!_settingBtn)
    {
        _settingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_settingBtn setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        _settingBtn.size=_settingBtn.currentBackgroundImage.size;
        _settingBtn.left=self.width-16.f-_settingBtn.width;
        _settingBtn.top=33.f;
        [_settingBtn addTarget:[[MineViewController alloc] init] action:@selector(settingBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingBtn;
}

-(UIImageView *)headImageView
{
    if (!_headImageView)
    {
        _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 58, 58)];
        _headImageView.centerX=self.centerX;
        _headImageView.layer.cornerRadius=29.f;
        _headImageView.layer.borderWidth=1.f;
        _headImageView.layer.borderColor=[UIColor colorWithHexString:@"#c6c6c6"].CGColor;
        _headImageView.image=[UIImage imageNamed:@"Default avatar"];
    }
    return _headImageView;
}


-(UILabel *)__nickNameLabel
{
    if (!_nickNameLabel)
    {
        _nickNameLabel=[[UILabel alloc]init];
        _nickNameLabel.font=[UIFont systemFontOfSize:15.f];
    }
    return _nickNameLabel;
}

-(UILabel *)__descriptionLabel
{
    if (!_descriptionLabel)
    {
        _descriptionLabel=[[UILabel alloc]init];
        _descriptionLabel.font=[UIFont systemFontOfSize:12.f];
        _descriptionLabel.textColor=[UIColor colorWithHexString:@"#7c7c7c"];
    }
    return _descriptionLabel;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self endEditing:YES];
}

@end
