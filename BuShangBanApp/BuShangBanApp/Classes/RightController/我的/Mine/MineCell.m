//
//  MineCell.m
//  BuShangBanApp
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "MineCell.h"

@implementation MineCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor=[UIColor whiteColor];
        _contentImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/6-22 * adapt.scaleWidth, 28.f * adapt.scaleHeight, 44 *adapt.scaleWidth, 44 * adapt.scaleWidth)];
        [self addSubview:_contentImageView];
        
        _contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 20)];
        _contentLabel.bottom=self.height-28.f* adapt.scaleHeight;
        _contentLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:_contentLabel];
    }
    return self;
}



-(void)setImage:(UIImage *)image title:(NSAttributedString *)title
{
    self.contentImageView.image=image;
    CGSize size=image.size;
    self.contentImageView.size=CGSizeMake(size.width *adapt.scaleWidth, size.height *adapt.scaleHeight);
    self.contentImageView.left=(kScreenWidth/3-1)/2+size.width/2;
    self.contentLabel.attributedText=title;
}
@end
