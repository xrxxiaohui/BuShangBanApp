//
//  BaseTipsMoreCell.m
//  ShunShunApp
//
//  Created by Peter Lee on 16/1/14.
//  Copyright © 2016年 顺顺留学. All rights reserved.
//

#import "BaseTipsMoreCell.h"

@interface BaseTipsMoreCell () {

    UIView *_redPencilLine;
    UILabel *_titleTipsLabel;
    
    UIImageView *_moreImageView;
    UIButton *_moreButton;
    
    UIView *_grayGapView;
}

@end

@implementation BaseTipsMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        
        _grayGapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        [_grayGapView setBackgroundColor:COLOR(0xf2, 0xf2, 0xf2)];
        [self.contentView addSubview:_grayGapView];
        
        _redPencilLine = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 2, 16)];
        [_redPencilLine setBackgroundColor:kAppRedColor];
        [self.contentView addSubview:_redPencilLine];
        
        CGFloat _titleFontFloat = 16;
        if (iPhone4 || iPhone5) {
            _titleFontFloat = 15;
        }
        
        _titleTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(_redPencilLine.right + 5, 15, 200, _titleFontFloat)];
        [_titleTipsLabel setTextColor:COLOR(0x38, 0x3d, 0x49)];
        [_titleTipsLabel setFont:[UIFont systemFontOfSize:_titleFontFloat]];
        [_titleTipsLabel setText:self.tipsTitle];
        [self.contentView addSubview:_titleTipsLabel];
        
        _moreImageView = [[UIImageView alloc] init];
        //    moreImageView.frame = CGRectMake(kScreenWidth-21, lineImageView2.bottom+17, 11, 11);
        _moreImageView.frame = CGRectMake(kScreenWidth-21, 17, 11, 11);
        [_moreImageView setImage:[UIImage imageNamed:@"morePic"]];
        //    [mainScrollView addSubview:moreImageView];
        [self.contentView addSubview:_moreImageView];
        //    [moreImageView release];
        [_moreImageView setHidden:YES];
        
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //    [moreButton setFrame:CGRectMake(kScreenWidth-48, lineImageView2.bottom+15, 30, 13)];
        [_moreButton setFrame:CGRectMake(kScreenWidth-48, 15, 30, 13)];
        [_moreButton addTarget:self action:@selector(moreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //    [mainScrollView addSubview:moreButton];
        [self.contentView addSubview:_moreButton];
        [_moreButton setHidden:YES];
        
        UILabel *moreTextLabel = [[UILabel alloc] init];
        [moreTextLabel setText:@"更多"];
        [moreTextLabel setTextColor:[UIColor blackColor]];
        [moreTextLabel setFrame:CGRectMake(0, 0, 30, 13)];
        [moreTextLabel setFont:[UIFont systemFontOfSize:12]];
        [_moreButton addSubview:moreTextLabel];
    }

    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)refreshUI {

    [_titleTipsLabel setText:self.tipsTitle];
    
    if (self.isNeedMoreResult) {
        [_moreButton setHidden:NO];
        [_moreImageView setHidden:NO];
    }
    else {
        [_moreButton setHidden:YES];
        [_moreImageView setHidden:YES];
    }

    
}

//-(void)setIsNeedGrayGap:(BOOL)isNeedGrayGap {
//
//    if (isNeedGrayGap) {
//        _grayGapView.top = [BaseTipsMoreCell getCellHeight] - 10;
//        _grayGapView.height = 10;
//    }
//}

-(void)resetGrayGapTopWithCellHeight:(CGFloat)cellHeight {

    _grayGapView.top = cellHeight - 10;
    _grayGapView.height = 10;
}

-(void)moreButtonClick:(UIButton *)sender {
    
    DCBlockRun(_moreActionBlock)
}

@end
