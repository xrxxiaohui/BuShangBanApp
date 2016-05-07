//
//  HomeHeadViewCell.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "HomeHeadViewCell.h"

@interface HomeHeadViewCell() {
    
    UIView *_leftBackgroundView;
    
    UIButton *_leftBigImageView;//左大图
    UIButton *_rightUpImageView;//右上图
    UIButton *_rightDownImageView;//右下图
    
    UILabel *_leftBigLabel;
    UILabel *_leftSmallLabel;
    
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
        _leftBigImageView.frame = CGRectMake(0, 0, kScreenWidth*276/414, kScreenWidth/414*276);
        _leftBigImageView.tag = 0;

        [_leftBigImageView.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _leftBigImageView.imageView.contentMode =  UIViewContentModeScaleAspectFill;
        _leftBigImageView.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _leftBigImageView.imageView.clipsToBounds  = YES;
        
        _leftBigImageView.clipsToBounds = YES;
        
        [self.contentView addSubview:_leftBigImageView];
        
        
        _rightUpImageView = [[UIButton alloc] init];
        _rightUpImageView.frame = CGRectMake(_leftBigImageView.right, 0, kScreenWidth*138/414, kScreenWidth/414*138);
        _rightUpImageView.tag = 1;

         [_rightUpImageView.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _rightUpImageView.imageView.contentMode =  UIViewContentModeScaleAspectFill;
        _rightUpImageView.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightUpImageView.imageView.clipsToBounds  = YES;

        [self.contentView addSubview:_rightUpImageView];
        
        _rightDownImageView = [[UIButton alloc] init];
        _rightDownImageView.frame = CGRectMake(_leftBigImageView.right, _rightUpImageView.bottom, kScreenWidth*138/414, kScreenWidth/414*138);
        _rightDownImageView.tag = 2;

        //图片只显示一部分
        [_rightDownImageView.imageView setContentScaleFactor:[[UIScreen mainScreen] scale]];
        _rightDownImageView.imageView.contentMode =  UIViewContentModeScaleAspectFill;
        _rightDownImageView.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _rightDownImageView.imageView.clipsToBounds  = YES;
        
        [self.contentView addSubview:_rightDownImageView];
        
        //////////////////////左边label背景图/////////////////////
        
        _leftBackgroundView = [[UIView alloc] init];
        [_leftBackgroundView setFrame:CGRectMake(0, 212*kScreenWidth/414, _leftBigImageView.width, 64*kScreenWidth/414)];
         [_leftBigImageView addSubview:_leftBackgroundView];
        
        
        _leftBigLabel = [[UILabel alloc] init];
        [_leftBigLabel setFrame:CGRectMake(0, 212*kScreenWidth/414, _leftBigImageView.width, 16)];
        [_leftBigLabel setTextColor:[UIColor whiteColor]];
        
        _leftBigLabel.numberOfLines = 1;
//        _leftBigLabel.shadowColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        [_leftBigLabel setFont:[UIFont systemFontOfSize:16]];
        [_leftBigImageView addSubview:_leftBigLabel];

        
        _leftSmallLabel = [[UILabel alloc] init];
        [_leftSmallLabel setFrame:CGRectMake(0, 238*kScreenWidth/414, _leftBigImageView.width, 38*kScreenWidth/414)];
        [_leftSmallLabel setTextColor:[UIColor whiteColor]];
        
        _leftSmallLabel.numberOfLines = 0;
        //        _leftBigLabel.shadowColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        [_leftSmallLabel setFont:[UIFont systemFontOfSize:12]];
        [_leftBigImageView addSubview:_leftSmallLabel];
        
        
        //////////////////////////////////////////
        _rightUpLabel = [[UILabel alloc] init];
        [_rightUpLabel setFrame:CGRectMake(0, _rightUpImageView.bottom-34, _rightUpImageView.width, 34)];
        [_rightUpLabel setTextColor:[UIColor whiteColor]];
        
       
        _rightUpLabel.shadowColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        [_rightUpLabel setFont:[UIFont systemFontOfSize:12]];
        [_rightUpImageView addSubview:_rightUpLabel];

        _rightDownLabel = [[UILabel alloc] init];
        [_rightDownLabel setFrame:CGRectMake(0, _rightDownImageView.bottom-34-kScreenWidth/414*138, _rightDownImageView.width, 34)];
        [_rightDownLabel setTextColor:[UIColor whiteColor]];
        
       
        _rightDownLabel.shadowColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        [_rightDownLabel setFont:[UIFont systemFontOfSize:12]];
        [_rightDownImageView addSubview:_rightDownLabel];

    }
    
    return self;
}

-(void)refreshUI {

    if([self.dataArray count]>1){
    
        NSDictionary *leftDataDic = [[self.dataArray objectAtIndex:0] safeDictionary];
        NSDictionary *rightUpDataDic = [[self.dataArray objectAtIndex:1] safeDictionary];
        NSDictionary *rightDownDataDic = [[self.dataArray objectAtIndex:2] safeDictionary];
        
        NSString *briefString = [NSString stringWithFormat:@"  %@",[leftDataDic objectForKey:@"brief"]];
        NSString *briefString1 = [NSString stringWithFormat:@"  %@",[rightUpDataDic objectForKey:@"brief"]];
        NSString *briefString2 = [NSString stringWithFormat:@"  %@",[rightDownDataDic objectForKey:@"brief"]];
        
        NSString *titleString = [NSString stringWithFormat:@"%@",[leftDataDic objectForKey:@"title"]];
        NSString *titleString1 = [NSString stringWithFormat:@"%@",[rightUpDataDic objectForKey:@"title"]];
        NSString *titleString2 = [NSString stringWithFormat:@"%@",[rightDownDataDic objectForKey:@"title"]];
        
        NSString *largeImageString = [leftDataDic valueForKeyPath:@"feature_image.large"];
        NSString *largeImageString1 = [rightUpDataDic valueForKeyPath:@"feature_image.large"];
        NSString *largeImageString2 = [rightDownDataDic valueForKeyPath:@"feature_image.large"];

        [_leftBigImageView sd_setBackgroundImageWithURL:[NSURL URLWithString:largeImageString] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"260"]];
        [_rightUpImageView sd_setBackgroundImageWithURL:[NSURL URLWithString:largeImageString1] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"154"]];
        [_rightDownImageView sd_setBackgroundImageWithURL:[NSURL URLWithString:largeImageString2] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"154"]];
    
//        [self addJianBianColor:_leftBigLabel];
        [self addJianBianColor:_leftBackgroundView];
        [self addJianBianColor:_rightUpLabel];
        [self addJianBianColor:_rightDownLabel];
        
        [_leftBigLabel setText:[NSString stringWithFormat:@"  %@",titleString]];
        [_leftSmallLabel setText:[NSString stringWithFormat:@"  %@",briefString]];
        
        [_rightUpLabel setText:[NSString stringWithFormat:@"  %@",titleString1]];
        [_rightDownLabel setText:[NSString stringWithFormat:@"  %@",titleString2]];
        
    }
    
}

-(void)addJianBianColor:(UIView *)label{
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, label.width,label.height);
    layer.colors = [NSArray arrayWithObjects:(id)[UIColor clearColor].CGColor, (id)[UIColor colorWithWhite:0 alpha:0.6].CGColor, nil];
//    for (CALayer *sublayer in [label.layer sublayers]) {
//        [sublayer removeFromSuperlayer];
//    }
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
