//
//  SuggestListCell.m
//  BuShangBanApp
//
//  Created by Zuo on 16/5/8.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SuggestListCell.h"

@interface SuggestListCell() {

    UILabel *nameLabel;
    UIButton *_rightAvarButton;
    UILabel *_mainContentLabel;
    NSMutableArray *dataArray;
    UIImageView *mainImageView;
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
    [backgroundView.layer setMasksToBounds:YES];
    backgroundView.layer.cornerRadius = 10;
    backgroundView.layer.shadowColor = COLOR(227, 227, 227).CGColor;
    backgroundView.layer.shadowRadius = 10;
    backgroundView.layer.shadowOpacity = 0.5;
//    backgroundView.layer.borderWidth = 15.0f;
    backgroundView.layer.shadowOffset = CGSizeMake(0,-3);
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
