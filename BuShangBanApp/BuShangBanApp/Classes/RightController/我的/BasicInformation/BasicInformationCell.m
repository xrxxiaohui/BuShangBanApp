//
//  BasicInformationCell.m
//  BuShangBanApp
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "BasicInformationCell.h"

#import "BasicInformationViewController.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]

@implementation BasicInformationCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self ) {
        self.textLabel.font = [UIFont fontWithName:fontName size:14.f];
    }
    return self;
}

- (UITextField *)contentTF {
    if ( !_contentTF ) {
        _contentTF = [[UITextField alloc] init];
        _contentTF.size = CGSizeMake(200 , 30);
        _contentTF.font = [UIFont fontWithName:fontName size:14];
        _contentTF.centerY = self.centerY;
        _contentTF.left = kScreenWidth - 220.f * adapt.scaleWidth-14.f;
        _contentTF.textAlignment = NSTextAlignmentRight;
        _contentTF.borderStyle = UITextBorderStyleNone;
        _contentTF.textColor = [UIColor colorWithHexString:@"#7c7c7c"];
        _contentTF.userInteractionEnabled = NO;
        _contentTF.returnKeyType = UIReturnKeyDone;
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
        [_headBtn addTarget:[[BasicInformationViewController alloc] init] action:@selector(setHeadImage:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_headBtn];
    }
    return _headBtn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _headBtn.top = 11.f;
    _headBtn.left = kScreenWidth - 62.f * adapt.scaleWidth-12;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
