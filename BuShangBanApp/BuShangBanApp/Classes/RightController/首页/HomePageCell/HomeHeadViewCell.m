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
        _leftBigImageView.frame = CGRectMake(0, 0.5, kScreenWidth*260/414, kScreenWidth/414*260);
        _leftBigImageView.tag = 0;

//        UIImage *finalImage = [self cuverImage:[UIImage imageNamed:@"1.jpg"] andRect:_leftBigImageView.frame];

        [_leftBigImageView setImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
        [_leftBigImageView.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _leftBigImageView.imageView.contentMode =  UIViewContentModeScaleAspectFill;
        _leftBigImageView.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _leftBigImageView.imageView.clipsToBounds  = YES;
        [self.contentView addSubview:_leftBigImageView];
        
        _rightUpImageView = [[UIButton alloc] init];
        _rightUpImageView.frame = CGRectMake(_leftBigImageView.right, 0.5, kScreenWidth*154/414, kScreenWidth/414*130);
        _rightUpImageView.tag = 1;

        [_rightUpImageView setImage:[UIImage imageNamed:@"2.jpg"] forState:UIControlStateNormal];
        [_rightUpImageView.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _rightUpImageView.imageView.contentMode =  UIViewContentModeScaleAspectFill;
        _rightUpImageView.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightUpImageView.imageView.clipsToBounds  = YES;


        [self.contentView addSubview:_rightUpImageView];
        
        _rightDownImageView = [[UIButton alloc] init];
        _rightDownImageView.frame = CGRectMake(_leftBigImageView.right, _rightUpImageView.bottom, kScreenWidth*154/414, kScreenWidth/414*130);
        _rightDownImageView.tag = 2;

        //图片只显示一部分
        [_rightDownImageView setImage:[UIImage imageNamed:@"3.jpg"] forState:UIControlStateNormal];
        [_rightDownImageView.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _rightDownImageView.imageView.contentMode =  UIViewContentModeScaleAspectFill;
        _rightDownImageView.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightDownImageView.imageView.clipsToBounds  = YES;
        [self.contentView addSubview:_rightDownImageView];
        
        ///////////////////////////////////////////
        _leftBigLabel = [[UILabel alloc] init];
        [_leftBigLabel setFrame:CGRectMake(0, _leftBigImageView.bottom-34, _leftBigImageView.width, 34)];
        [_leftBigLabel setTextColor:[UIColor whiteColor]];
        
//        [_leftBigLabel setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
        
        [self addJianBianColor:_leftBigLabel];
        
        _leftBigLabel.numberOfLines = 0;
        _leftBigLabel.shadowColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        [_leftBigLabel setFont:[UIFont systemFontOfSize:16]];
        [_leftBigImageView addSubview:_leftBigLabel];

        //////////////////////////////////////////
        _rightUpLabel = [[UILabel alloc] init];
        [_rightUpLabel setFrame:CGRectMake(0, _rightUpImageView.bottom-34, _rightUpImageView.width, 34)];
        [_rightUpLabel setTextColor:[UIColor whiteColor]];
        
        [self addJianBianColor:_rightUpLabel];
        
        _rightUpLabel.shadowColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        [_rightUpLabel setFont:[UIFont systemFontOfSize:16]];
        [_rightUpImageView addSubview:_rightUpLabel];

        /////////////////////////////////////////
        _rightDownLabel = [[UILabel alloc] init];
        [_rightDownLabel setFrame:CGRectMake(0, _rightDownImageView.bottom-34-kScreenWidth/414*130, _rightDownImageView.width, 34)];
        [_rightDownLabel setTextColor:[UIColor whiteColor]];
        [self addJianBianColor:_rightDownLabel];
       
        _rightDownLabel.shadowColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        [_rightDownLabel setFont:[UIFont systemFontOfSize:16]];
        [_rightDownImageView addSubview:_rightDownLabel];

        [_leftBigLabel setText:@"  程序员的黄金时代"];
        [_rightUpLabel setText:@"  看我美不美"];
        [_rightDownLabel setText:@"  我就不上班"];

    }
    
    return self;
}

-(void)refreshUI {

//    [_leftBigLabel setText:@"程序员的黄金时代"];
//    [_rightUpLabel setText:@"看我美不美"];
//    [_rightDownLabel setText:@"不上班呀不上班"];
    
}

-(void)addJianBianColor:(UILabel *)label{

    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, label.width,label.height);
    layer.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithWhite:0 alpha:0.6].CGColor, nil];
    for (CALayer *sublayer in [label.layer sublayers]) {
        [sublayer removeFromSuperlayer];
    }
    [label.layer insertSublayer:layer atIndex:0];
    
}

-(UIImage *)cuverImage:(UIImage *)image andRect:(CGRect)rect{


    CGImageRef imageRef=CGImageCreateWithImageInRect([image CGImage],rect);
    UIImage *image1=[UIImage imageWithCGImage:imageRef];
    return image1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
