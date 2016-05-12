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
        _contentTF = [[UITextField alloc] init];
        _contentTF.font = [UIFont fontWithName:fontName size:14];
        _contentTF.frame=CGRectMake(kScreenWidth/2, 17, kScreenWidth/2-12, 14);
        _contentTF.textAlignment = NSTextAlignmentRight;
        _contentTF.borderStyle = UITextBorderStyleNone;
        _contentTF.textColor = [UIColor colorWithHexString:@"#7c7c7c"];
        _contentTF.userInteractionEnabled = NO;
        _contentTF.returnKeyType = UIReturnKeyDone;
        [_contentTF resignFirstResponder];
        [self addSubview:_contentTF];
        _headBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _headBtn.frame=CGRectMake(kScreenWidth-70, 11, 58, 58);
        _headBtn.layer.cornerRadius = _headBtn.width / 2;
        _headBtn.clipsToBounds = YES;
    }
    return self;
}

@end
