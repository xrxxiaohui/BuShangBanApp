//
//  HomeHeadViewCell.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "HomeHeadViewCell.h"

@interface HomeHeadViewCell() {
    
    UIButton *_leftBigImageView;//左大图
    UIButton *_rightUpImageView;//右上图
    UIButton *_rightDownImageView;//右下图
    
    UILabel *_leftBigLabel;
    UILabel *_rightUpLabel;
    UILabel *_rightDownLabel;
}

@end



@implementation HomeHeadViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _leftBigImageView = [[UIButton alloc] init];
        _leftBigImageView.frame = CGRectMake(0, 0, kScreenWidth*0.68, kScreenWidth/414*260);
        _leftBigImageView.tag = 0;
        [self.contentView addSubview:_leftBigImageView];
        
        _rightUpImageView = [[UIButton alloc] init];
        _rightUpImageView.frame = CGRectMake(0, 0, kScreenWidth*0.32, kScreenWidth/414*130);
        _rightUpImageView.tag = 1;
        [self.contentView addSubview:_rightUpImageView];
        
        _rightDownImageView = [[UIButton alloc] init];
        _rightDownImageView.frame = CGRectMake(0, 0, kScreenWidth*0.32, kScreenWidth/414*130);
        _rightDownImageView.tag = 2;
        [self.contentView addSubview:_rightDownImageView];
        
        ///////////////////////////////////////////
        _leftBigLabel = [[UILabel alloc] init];
        [_leftBigLabel setFrame:CGRectMake(0, _leftBigImageView.bottom-34, _leftBigImageView.width, 34)];
        [_leftBigLabel setTextColor:[UIColor whiteColor]];
        
        [_leftBigLabel setBackgroundColor:[UIColor clearColor]];
        _leftBigLabel.shadowColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        [_leftBigLabel setFont:[UIFont systemFontOfSize:16]];
        [_leftBigImageView addSubview:_leftBigLabel];

        //////////////////////////////////////////
        _rightUpLabel = [[UILabel alloc] init];
        [_rightUpLabel setFrame:CGRectMake(0, _rightUpImageView.bottom-34, _rightUpImageView.width, 34)];
        [_rightUpLabel setTextColor:[UIColor whiteColor]];
        
        [_rightUpLabel setBackgroundColor:[UIColor clearColor]];
        _rightUpLabel.shadowColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        [_rightUpLabel setFont:[UIFont systemFontOfSize:16]];
        [_rightUpImageView addSubview:_rightUpLabel];

        /////////////////////////////////////////
        _rightDownLabel = [[UILabel alloc] init];
        [_rightDownLabel setFrame:CGRectMake(0, _rightDownImageView.bottom-34, _rightDownImageView.width, 34)];
        [_rightDownLabel setTextColor:[UIColor whiteColor]];
        
        [_rightDownLabel setBackgroundColor:[UIColor clearColor]];
        _rightDownLabel.shadowColor = [UIColor colorWithWhite:0.1 alpha:0.5];
        [_rightDownLabel setFont:[UIFont systemFontOfSize:16]];
        [_rightDownImageView addSubview:_rightDownLabel];

        
    }
    
    return self;
}

-(void)refreshUI {

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
