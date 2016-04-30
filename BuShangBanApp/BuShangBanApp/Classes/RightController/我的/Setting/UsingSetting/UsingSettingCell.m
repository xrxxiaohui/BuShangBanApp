//
//  UsingSettingCell.m
//  BuShangBanApp
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "UsingSettingCell.h"
#import "UsingSettingViewController.h"
@interface UsingSettingCell()

@end

@implementation UsingSettingCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.switchView=[[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth-61, 8, 81, 31)];
        [self.switchView addTarget:[[UsingSettingViewController alloc]init] action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.switchView];
        self.textLabel.font=[UIFont fontWithName:fontName size:14];
        self.textLabel.textColor=[UIColor colorWithHexString:@"383838"];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
