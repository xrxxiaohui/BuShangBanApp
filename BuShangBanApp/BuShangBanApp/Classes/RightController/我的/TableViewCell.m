//
//  TableViewCell.m
//  BuShangBanApp
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "TableViewCell.h"
#import "SettingViewController.h"

@implementation TableViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (UITextField *)contentTF {
    if ( !_contentTF ) {
        _contentTF = [[UITextField alloc] init];
        _contentTF.size = CGSizeMake(150, 30);
        _contentTF.font = [UIFont fontWithName:@"PingFang TC" size:15];
        _contentTF.centerY = self.centerY;
        _contentTF.left = kScreenWidth - 160.f;
        _contentTF.textAlignment = NSTextAlignmentRight;
        _contentTF.borderStyle = UITextBorderStyleNone;
        _contentTF.font = [UIFont systemFontOfSize:14];
        _contentTF.textColor = [UIColor colorWithHexString:@"#7c7c7c"];
        _contentTF.userInteractionEnabled = NO;
        _contentTF.returnKeyType = UIReturnKeyDefault;
        [_contentTF resignFirstResponder];
        [self addSubview:_contentTF];
    }
    return _contentTF;
}

- (UIButton *)headBtn {
    if ( !_headBtn ) {
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.size = CGSizeMake(58, 58);
        _headBtn.layer.cornerRadius = _headBtn.width / 2;
        _headBtn.clipsToBounds = YES;
        [_headBtn addTarget:[[SettingViewController alloc] init] action:@selector(setHeadImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_headBtn];
    }
    return _headBtn;
}

- (UITextView *)profileTextView {
    if ( !_profileTextView ) {
        _profileTextView = [[UITextView alloc] init];
        _profileTextView.userInteractionEnabled = NO;
        _profileTextView.size = CGSizeMake(272, 86);
        _profileTextView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        _profileTextView.font = [UIFont fontWithName:fontName size:15];
        _profileTextView.textColor = [UIColor colorWithHexString:@"#383838"];
        _profileTextView.userInteractionEnabled = NO;
        _profileTextView.layer.cornerRadius = 8.f;
        [self addSubview:_profileTextView];
    }
    return _profileTextView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _profileTextView.left = 100;
    _profileTextView.top = 8.f;

    _headBtn.top = 11.f;
    _headBtn.left = self.width - 70.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
