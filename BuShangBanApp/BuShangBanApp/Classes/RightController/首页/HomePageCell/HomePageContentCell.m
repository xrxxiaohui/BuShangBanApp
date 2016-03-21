//
//  HomePageContentCell.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "HomePageContentCell.h"

@interface HomePageContentCell() {
    
    UIButton *_leftUpButton;//左上图
    UIButton *_rightAvarButton;//右上图
    UIButton *_shareButton;//分享
    UIButton *_remarkButton;//评论
    UIButton *_zanButton;//赞

    
    UIImageView *_redLineImageView;
    UILabel *_leftUpLabel;
    UILabel *_mainTitleLabel;
    UILabel *_mainContentLabel;
    UIImageView *_centerImageView;
}

@end

@implementation HomePageContentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
