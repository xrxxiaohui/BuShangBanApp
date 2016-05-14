//
//  MineCell.h
//  BuShangBanApp
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 Zuo. All rights reserved.
//


@interface MineCell : UICollectionViewCell

#define adapt  [[[ScreenAdapt alloc]init] adapt]

@property(nonatomic,strong)UIImageView *contentImageView;
@property(nonatomic,strong)UILabel *contentLabel;

-(void)setImage:(UIImage *)image title:(NSString *)title;

@end