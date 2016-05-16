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

    UILabel *_shareNumLabel;
    UILabel *_commentNumLabel;
    UILabel *_zanNumLabel;

    
    UIView *_redPencilLine;
}

@end

@implementation HomePageContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *lineImageView2 = [[UIImageView alloc] init];
        lineImageView2.backgroundColor = kCommonBottomLineColor;
        [lineImageView2 setFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        [self.contentView addSubview:lineImageView2];

        
        self.backgroundColor = [UIColor whiteColor];
        _leftUpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image=[UIImage imageNamed:@"greenBackground"];
        [_leftUpButton setBackgroundImage:image forState:UIControlStateNormal];
        [_leftUpButton setFrame:CGRectMake(12+12, 12, image.size.width, image.size.height)];
        
        _leftUpLabel = [[UILabel alloc] init];
        [_leftUpLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [_leftUpLabel setTextColor:COLOR(255, 255, 255)];
        [_leftUpLabel setFrame:CGRectMake(0,0, image.size.width, image.size.height-10)];
        [_leftUpLabel setText:@"设计"];
        _leftUpLabel.textAlignment=NSTextAlignmentCenter;
        _leftUpLabel.adjustsFontSizeToFitWidth=YES;
        [_leftUpButton addSubview:_leftUpLabel];
        
        _rightAvarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightAvarButton setFrame:CGRectMake(kScreenWidth-24-28, 198, 28, 28)];
//        [_rightAvarButton setImage:[UIImage imageNamed:@"greenBackground"] forState:UIControlStateNormal];
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

       
        UIView *grayView = [[UIView alloc] init];
        [grayView setBackgroundColor:COLOR(249, 249, 249)];
        [grayView setFrame:CGRectMake(0, _shareButton.bottom+8, kScreenWidth, 14)];
        [self.contentView addSubview:grayView];
        
        UIImageView *lineImageView1 = [[UIImageView alloc] init];
        lineImageView1.backgroundColor = kCommonBottomLineColor;
        [lineImageView1 setFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        [grayView addSubview:lineImageView1];
        
        
        
    }
    
    return self;
}

-(void)refreshUI {
//    related_post

    NSString *imageString = [[self.dataInfo objectForKey:@"image"] safeString];
    [_centerImageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:[UIImage imageNamed:@"place"]];
    NSString *titleString = [[self.dataInfo valueForKeyPath:@"related_post.title"] safeString];
    [_mainTitleLabel setText:titleString];
    
    NSString *summaryString = [[self.dataInfo valueForKeyPath:@"related_post.summary"] safeString];
    [_mainContentLabel setText:summaryString];
    
    NSString *avatarString = [[self.dataInfo valueForKeyPath:@"related_post.author.avatar.url"] safeString];
    [_rightAvarButton sd_setImageWithURL:[NSURL URLWithString:avatarString]  forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"authoravar"] options:SDWebImageRefreshCached];

    NSString *likes_count = [NSString stringWithFormat:@"%@",[self.dataInfo valueForKeyPath:@"related_post.like_count"]];
    [_zanNumLabel setText:likes_count];
    
    NSString *share_count = [NSString stringWithFormat:@"%@",[self.dataInfo valueForKeyPath:@"related_post.share_count"]];
    
    [_shareNumLabel setText:share_count];
    
    NSString *comment_count = [NSString stringWithFormat:@"%@",[self.dataInfo valueForKeyPath:@"related_post.comment_count"]];
    [_commentNumLabel setText:comment_count];
    
    NSString *categoryStr =[[self.dataInfo valueForKeyPath:@"related_post.category.name"] safeString];
    if([categoryStr isEqualToString:@"默认分类"])
        categoryStr = @"默认";
    else if([categoryStr isEqualToString:@"大公司"])
        categoryStr = @"公司";
    else if ([categoryStr isEqualToString:@"运营&市场"])
        categoryStr = @"运营";
    else if ([categoryStr isEqualToString:@"原创封面"])
        categoryStr = @"原创";

    
    [_leftUpLabel setText:categoryStr];
    NSLog(@"-----%@",categoryStr);
}


+(CGFloat)getCellHeight {
    
    return 426-60;
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
