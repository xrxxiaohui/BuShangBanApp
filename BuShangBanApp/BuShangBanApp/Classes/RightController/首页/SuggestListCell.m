//
//  SuggestListCell.m
//  BuShangBanApp
//
//  Created by Zuo on 16/5/8.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SuggestListCell.h"
#import "CustomLabel.h"

@interface SuggestListCell() {

    UILabel *nameLabel;
    UIButton *_rightAvarButton;
    UILabel *_mainContentLabel;
    NSMutableArray *dataArray;
    UIImageView *mainImageView;
    
    CustomLabel *topTitleLabel;
}

@end

@implementation SuggestListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createBackgroundView];
        [self customView];
    }
    
    return self;
}

-(void)refreshUI {
    
    NSString *imageStr = [[self.dataInfo objectForKey:@"feature_image"] safeString];
    [mainImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
    
    NSString *summaryStr = [[self.dataInfo objectForKey:@"summary"] safeString];
    [_mainContentLabel setText:summaryStr];
    
    NSString *nameString = [[self.dataInfo valueForKeyPath:@"author.username"] safeString];
    [nameLabel setText:nameString];
    NSString *avatarString = [[self.dataInfo valueForKeyPath:@"author.avatar.url"] safeString];
    [_rightAvarButton sd_setImageWithURL:[NSURL URLWithString:avatarString] forState:UIControlStateNormal];

    NSString *titleStr = [[self.dataInfo objectForKey:@"title"] safeString];
    [topTitleLabel setText:titleStr];
    topTitleLabel.numberOfLines = 2;

//    NSString *largeImageString = [self.dataInfo valueForKeyPath:@"feature_image.large"];
//
//    [mainImageView sd_setImageWithURL:[NSURL URLWithString:largeImageString] placeholderImage:nil];
//    
//    NSString *summaryStr = [[self.dataInfo objectForKey:@"brief"] safeString];
//    [_mainContentLabel setText:summaryStr];
//    
//    NSString *nameString = [[self.dataInfo valueForKeyPath:@"author_info.author_name"] safeString];
//    [nameLabel setText:nameString];
//    NSString *avatarString = [[self.dataInfo valueForKeyPath:@"author.avatar.url"] safeString];
//    [_rightAvarButton sd_setImageWithURL:[NSURL URLWithString:avatarString] forState:UIControlStateNormal];
}

-(void)customView{
    
    topTitleLabel = [[CustomLabel alloc] init];
    [topTitleLabel setFrame:CGRectMake(72*kDefaultBiLi, (118-64)*kDefaultBiLi, 270*kDefaultBiLi, 50)];
    [self addSubview:topTitleLabel];
    
    //渐变颜色的起始颜色
    UIColor *startColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:1.0];
    //渐变颜色的结束颜色
    UIColor *endColor = [UIColor colorWithRed:227 green:227 blue:227 alpha:0.5];
    CAGradientLayer *bgLayer = [[CAGradientLayer alloc]init];
    bgLayer.frame = topTitleLabel.frame;
    [bgLayer setColors:[[NSArray alloc]initWithObjects:(id)startColor.CGColor,(id)endColor.CGColor, nil]];
    [self.layer insertSublayer:bgLayer atIndex:0];
    //对customLabel中的属性进行初始化
    [topTitleLabel setTextColor:[UIColor whiteColor]];
    //    topTitleLabel.glowColor  = [UIColor initWithWhite:0 alpha:0.8];
    topTitleLabel.glowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    topTitleLabel.glowAmount = 12;
    topTitleLabel.textAlignment = NSTextAlignmentCenter;
    topTitleLabel.glowoffset = CGSizeMake(0.0, 0.0);
    topTitleLabel.text = @"";
    topTitleLabel.font = [UIFont systemFontOfSize:18];
    
    _rightAvarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightAvarButton setFrame:CGRectMake(kScreenWidth-81*kDefaultBiLi, (292+90-70)*kScreenWidth/414, 28, 28)];
    [self addSubview:_rightAvarButton];
    [_rightAvarButton.layer setMasksToBounds:YES];
    _rightAvarButton.layer.cornerRadius = 14;
    [_rightAvarButton setBackgroundColor:[UIColor blackColor]];
    
    nameLabel = [[UILabel alloc] init];
    [nameLabel setFrame:CGRectMake(100, 320*kDefaultBiLi, kScreenWidth-97*kDefaultBiLi-100, 13)];
    [nameLabel setTextAlignment:NSTextAlignmentRight];
    [nameLabel setFont:[UIFont systemFontOfSize:12]];
    //    [nameLabel setText:@"不上班"];
    [nameLabel setTextColor:COLOR(56, 56, 56)];
    [self addSubview:nameLabel];
    
    _mainContentLabel = [[UILabel alloc] init];
    //    [_mainContentLabel setText:@"无论创业还是职场，总会有一时流行的东西，然后若有一天你也想站在顶端受人尊敬，那么最好的办法就是提高自己！"];
    [_mainContentLabel setFont:[UIFont systemFontOfSize:16]];
    [_mainContentLabel setFrame:CGRectMake(55*kDefaultBiLi, 380*kScreenWidth/414, 304*kDefaultBiLi, 100)];
    _mainContentLabel.numberOfLines = 0;
    [_mainContentLabel setTextColor:COLOR(56, 56, 56)];
    [self addSubview:_mainContentLabel];
    
}

-(void)createBackgroundView{
    
    UIView *backgroundView = [[UIView alloc] init];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
//    [backgroundView.layer setMasksToBounds:YES];
    backgroundView.layer.cornerRadius = 10;
    
    
    backgroundView.layer.shadowColor = [UIColor colorWithRed:0xe3/255. green:0xe3/255. blue:0xe3/255. alpha:1].CGColor;
    backgroundView.layer.shadowRadius = 7;
    backgroundView.layer.shadowOpacity = 1;
//    backgroundView.layer.borderWidth = 15.0f;
    backgroundView.layer.shadowOffset = CGSizeMake(0,2);
    
    [backgroundView setFrame:CGRectMake(37*kDefaultBiLi, 20*kDefaultBiLi, 340*kDefaultBiLi, 500*kDefaultBiLi)];
//    backgroundView.userInteractionEnabled = YES;
    [self addSubview:backgroundView];
    
//    UITapGestureRecognizer *fingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toWebDetailPage)];
//    
//    [backgroundView addGestureRecognizer: fingerTap];

    mainImageView = [[UIImageView alloc] init];
//    mainImageView.userInteractionEnabled = YES;
    [mainImageView.layer setMasksToBounds:YES];
    mainImageView.layer.cornerRadius = 10;
    
    [mainImageView setFrame:CGRectMake(37*kDefaultBiLi, 20*kDefaultBiLi, 340*kDefaultBiLi,340*kDefaultBiLi)];
//    UITapGestureRecognizer *fingerTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toWebDetailPage)];
//    [mainImageView addGestureRecognizer: fingerTap1];
    [self addSubview:mainImageView];
    
    UIImageView *mengbanImageView = [[UIImageView alloc] init];
    [mengbanImageView setImage:[UIImage imageNamed:@"mengban"]];
    [mengbanImageView setFrame:mainImageView.frame];
    [self addSubview:mengbanImageView];
    mengbanImageView.userInteractionEnabled = YES;
    
    UIImageView *maskView = [[UIImageView alloc]init];
    [maskView setImage:[UIImage imageNamed:@"MaskR10"]];
    [maskView setFrame:CGRectMake(37*kDefaultBiLi, 270*kDefaultBiLi-10, 340*kDefaultBiLi, 90*kDefaultBiLi+10)];
    [self addSubview:maskView];
    
}

//-(void)toWebDetailPage{
//    
//    DCBlockRun(_toWebDetailPageBlock)
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
