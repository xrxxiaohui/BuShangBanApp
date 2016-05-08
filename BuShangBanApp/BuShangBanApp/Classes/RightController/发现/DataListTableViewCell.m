//
//  DataListTableViewCell.m
//  BuShangBanApp
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "DataListTableViewCell.h"

@implementation DataListTableViewCell
{
    UIButton *_leftUpButton;//左上图
    UIButton *_rightAvarButton;//右上图
    UIButton *_shareButton;//分享
    UIButton *_remarkButton;//评论
    UIButton *_zanButton;//赞
    
    UIImageView *_redLineImageView;;
    
    UIView *_redPencilLine;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _leftUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftUpButton setFrame:CGRectMake(12+12, 12, 34, 40)];
        [_leftUpButton setImage:[UIImage imageNamed:@"greenBackground"] forState:UIControlStateNormal];
    
        
        _leftUpLabel = [[UILabel alloc] init];
        [_leftUpLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_leftUpLabel setTextColor:COLOR(255, 255, 255)];
        [_leftUpLabel setFrame:CGRectMake(2, 8, 35, 15)];
        [_leftUpLabel setText:@"设计"];
        [_leftUpButton addSubview:_leftUpLabel];
        
        _rightAvarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightAvarButton setFrame:CGRectMake(kScreenWidth-24-28, 198, 28, 28)];
        [self.contentView addSubview:_rightAvarButton];
        [_rightAvarButton.layer setMasksToBounds:YES];
        _rightAvarButton.layer.cornerRadius = 14;
        [_rightAvarButton setBackgroundColor:[UIColor blackColor]];
        
        _centerImageView = [[UIImageView alloc] init];
        [_centerImageView setImage:[UIImage imageNamed:@"tree.jpeg"]];
        [_centerImageView setFrame:CGRectMake(12, 12, kScreenWidth-24, 200)];
        [self.contentView addSubview:_centerImageView];
        [self.contentView addSubview:_leftUpButton];
        [self.contentView addSubview:_rightAvarButton];
        
        _redPencilLine = [[UIView alloc] initWithFrame:CGRectMake(12, _centerImageView.bottom+13, 2, 16)];
        [_redPencilLine setBackgroundColor:kAppRedColor];
        [self.contentView addSubview:_redPencilLine];
        
        _mainTitleLabel = [[UILabel alloc] init];
        [_mainTitleLabel setText:@"程序员一生平安"];
        [_mainTitleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        [_mainTitleLabel setTextColor:COLOR(58, 58, 58)];
        [_mainTitleLabel setFrame:CGRectMake(20, _centerImageView.bottom+14, kScreenWidth-40, 16)];
        [self.contentView addSubview:_mainTitleLabel];
        
        _mainContentLabel = [[UILabel alloc] init];
        [_mainContentLabel setText:@"无论创业还是职场，总会有一时流行的东西，然后若有一天你也想站在顶端受人尊敬，那么最好的办法就是提高自己！"];
        [_mainContentLabel setFont:[UIFont systemFontOfSize:12]];
        [_mainContentLabel setFrame:CGRectMake(20, _mainTitleLabel.bottom+8, kScreenWidth-40, 30)];
        _mainContentLabel.numberOfLines = 0;
        [_mainContentLabel setTextColor:COLOR(99, 99, 99)];
        [self.contentView addSubview:_mainContentLabel];
        
        _zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zanButton setFrame:CGRectMake(kScreenWidth-60, _mainContentLabel.bottom+10, 14, 14)];
        [_zanButton setImage:[UIImage imageNamed:@"like_nomal"] forState:UIControlStateNormal];
        [_zanButton addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_zanButton];
        
        _zanNumLabel = [[UILabel alloc] init];
        _zanNumLabel.frame = CGRectMake(_zanButton.right+4, _zanButton.y, 25, 12);
        [_zanNumLabel setFont:[UIFont systemFontOfSize:12]];
        [_zanNumLabel setText:@"122"];
        [_zanNumLabel setTextColor:COLOR(124, 124, 124)];
        [self.contentView addSubview:_zanNumLabel];
        
        _remarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_remarkButton setFrame:CGRectMake(kScreenWidth-120, _mainContentLabel.bottom+10, 14, 14)];
        [_remarkButton addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_remarkButton setImage:[UIImage imageNamed:@"comment_nomal"] forState:UIControlStateNormal];
        [self.contentView addSubview:_remarkButton];
        
        _commentNumLabel = [[UILabel alloc] init];
        _commentNumLabel.frame = CGRectMake(_remarkButton.right+4, _remarkButton.y, 25, 12);
        [_commentNumLabel setFont:[UIFont systemFontOfSize:12]];
        [_commentNumLabel setText:@"122"];
        [_commentNumLabel setTextColor:COLOR(124, 124, 124)];
        [self.contentView addSubview:_commentNumLabel];
        
        _shareButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setFrame:CGRectMake(kScreenWidth-180, _mainContentLabel.bottom+10, 14, 14)];
        [_shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_shareButton setImage:[UIImage imageNamed:@"share_nomal"] forState:UIControlStateNormal];
        [self.contentView addSubview:_shareButton];
        
        _shareNumLabel = [[UILabel alloc] init];
        _shareNumLabel.frame = CGRectMake(_shareButton.right+4, _shareButton.y, 25, 12);
        [_shareNumLabel setFont:[UIFont systemFontOfSize:12]];
        [_shareNumLabel setText:@"122"];
        [_shareNumLabel setTextColor:COLOR(124, 124, 124)];
        [self.contentView addSubview:_shareNumLabel];
        
        
        UIImageView *lineImageView1 = [[UIImageView alloc] init];
        lineImageView1.backgroundColor = kCommonBottomLineColor;
        [lineImageView1 setFrame:CGRectMake(0, _shareButton.bottom+8, kScreenWidth, 0.5)];
        [self.contentView addSubview:lineImageView1];
        
        UIView *grayView = [[UIView alloc] init];
        [grayView setBackgroundColor:COLOR(249, 249, 249)];
        [grayView setFrame:CGRectMake(0, _shareButton.bottom+8.5, kScreenWidth, 12)];
        [self.contentView addSubview:grayView];
    }
    return self;
}




+(CGFloat)getCellHeight {
    return 325;
}

-(void)zanButtonClick:(UIButton *)sender {
    DCBlockRun(_zanButtonActionBlock)
}
-(void)commentButtonClick:(UIButton *)sender {
    
    DCBlockRun(_commentButtonActionBlock)
}

-(void)shareButtonClick:(UIButton *)sender {
    DCBlockRun(_shareButtonActionBlock)
}

@end
