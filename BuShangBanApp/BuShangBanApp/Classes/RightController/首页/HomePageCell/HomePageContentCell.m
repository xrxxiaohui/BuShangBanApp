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
    
    UIView *_redPencilLine;
}

@end

@implementation HomePageContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _leftUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftUpButton setFrame:CGRectMake(12, 0, 34, 40)];
        [_leftUpButton setImage:[UIImage imageNamed:@"greenBackground"] forState:UIControlStateNormal];
//        [_leftUpButton setTitle:@"设计" forState:UIControlStateNormal];
        [self.contentView addSubview:_leftUpButton];
        
        _leftUpLabel = [[UILabel alloc] init];
        [_leftUpLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_leftUpLabel setTextColor:COLOR(255, 255, 255)];
        [_leftUpLabel setFrame:CGRectMake(2, 8, 35, 15)];
        [_leftUpLabel setText:@"设计"];
        [_leftUpButton addSubview:_leftUpLabel];
        
        _rightAvarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightAvarButton setFrame:CGRectMake(kScreenWidth-12-28, 16, 28, 28)];
//        [_rightAvarButton setImage:[UIImage imageNamed:@"greenBackground"] forState:UIControlStateNormal];
        [self.contentView addSubview:_rightAvarButton];
        [_rightAvarButton.layer setMasksToBounds:YES];
        _rightAvarButton.layer.cornerRadius = 14;
        [_rightAvarButton setBackgroundColor:[UIColor blackColor]];
        [self.contentView addSubview:_rightAvarButton];
        
        _centerImageView = [[UIImageView alloc] init];
        [_centerImageView setImage:[UIImage imageNamed:@"tree.jpeg"]];
        [_centerImageView setFrame:CGRectMake(12, 60, kScreenWidth-24, 200)];
        [self.contentView addSubview:_centerImageView];
        
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
        [_mainContentLabel setFrame:CGRectMake(20, _mainTitleLabel.bottom+8, kScreenWidth-40, 45)];
        _mainContentLabel.numberOfLines = 0;
        [_mainContentLabel setTextColor:COLOR(99, 99, 99)];
        [self.contentView addSubview:_mainContentLabel];
        
        _zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zanButton setFrame:CGRectMake(kScreenWidth-50, _mainContentLabel.bottom+10, 12, 12)];
        [_zanButton addTarget:self action:@selector(zanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_zanButton];
        
        _remarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_remarkButton setFrame:CGRectMake(kScreenWidth-50, _mainContentLabel.bottom+10, 12, 12)];
        [_remarkButton addTarget:self action:@selector(commentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_remarkButton];

        _shareButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setFrame:CGRectMake(kScreenWidth-50, _mainContentLabel.bottom+10, 12, 12)];
        [_shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_shareButton];

        
    }
    
    return self;
}

-(void)refreshUI {
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
