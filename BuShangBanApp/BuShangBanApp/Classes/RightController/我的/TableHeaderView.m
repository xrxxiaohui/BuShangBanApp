//
//  TableHeaderView.m
//  BuShangBanApp
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "TableHeaderView.h"
#import "MineViewController.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]
#define tableHeaderViewHeight 200

@interface TableHeaderView ()

@property(nonatomic, strong) UIButton *settingBtn;
@property(nonatomic, strong) UILabel *nickNameLabel;
@property(nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation TableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        self.frame = CGRectMake(0, 0, kScreenWidth, tableHeaderViewHeight * adapt.scaleHeight);
        [self addSubview:self.bgImageView];
        [self addSubview:self.headImageBtn];
        [self addSubview:self.settingBtn];
    }
    return self;
}

- (void)nickNameLabelWithNickName:(NSString *)nickName label:(NSString *)label {
    if ( !_nickNameLabel ) {
        _nickNameLabel = [[UILabel alloc] init];
        nickName = [NSString stringWithFormat:@"%@   |   ", nickName];

        NSDictionary *nickNameDic =
                @{NSForegroundColorAttributeName : nomalTextColor, NSFontAttributeName : nomalFont};
        NSDictionary *labelDic =
                @{NSForegroundColorAttributeName : placeHoldTextColor, NSFontAttributeName : smallerFont};

        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:nickName attributes:nickNameDic];
        [attr appendAttributedString:[[NSAttributedString alloc] initWithString:label attributes:labelDic]];
        _nickNameLabel.attributedText = attr;

        [_nickNameLabel sizeToFit];
        _nickNameLabel.centerX = self.centerX;
        _nickNameLabel.top = 128.f * adapt.scaleHeight;
        [self addSubview:_nickNameLabel];
    }
}

- (void)descriptionLabelWithText:(NSString *)text {
    if ( !_descriptionLabel ) {
        _descriptionLabel = [[UILabel alloc] init];
        
        _descriptionLabel.font = smallerFont;
        _descriptionLabel.textColor = placeHoldTextColor;
        _descriptionLabel.text = text;
        [_descriptionLabel sizeToFit];
        _descriptionLabel.centerX = self.centerX;
        _descriptionLabel.top = 163.f * adapt.scaleHeight;
        [self addSubview:_descriptionLabel];
    }
}


- (UIImageView *)bgImageView {
    if ( !_bgImageView ) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bgImageView.size = self.size;
        _bgImageView.image = [UIImage imageNamed:@"bg"];
    }
    return _bgImageView;
}

- (UIButton *)settingBtn {
    if ( !_settingBtn ) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_settingBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        [_settingBtn addTarget:[[MineViewController alloc] init] action:@selector(settingBtn:) forControlEvents:UIControlEventTouchUpInside];
        _settingBtn.size=CGSizeMake(44, 44);
        _settingBtn.left = kScreenWidth - _settingBtn.width - 10;
        _settingBtn.top = 33.f;
    }
    return _settingBtn;
}

- (UIButton *)headImageBtn {
    if ( !_headImageBtn ) {
        _headImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headImageBtn addTarget:[[MineViewController alloc] init] action:@selector(settingBtn:) forControlEvents:UIControlEventTouchUpInside];
        _headImageBtn.userInteractionEnabled = NO;
        _headImageBtn.frame = CGRectMake(0, 50 * adapt.scaleHeight, 58, 58);
        _headImageBtn.centerX = self.centerX;
        _headImageBtn.layer.cornerRadius = 29.f;
        _headImageBtn.clipsToBounds = YES;
        _headImageBtn.layer.borderWidth = 1.f;
        _headImageBtn.layer.borderColor = [UIColor colorWithHexString:@"#c6c6c6"].CGColor;
    }
    return _headImageBtn;
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self endEditing:YES];
}

@end
