//
//  MineSectionHeaderView.m
//  BuShangBanApp
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "MineSectionHeaderView.h"
#import "MineViewController.h"


@interface MineSectionHeaderView ()

@property(nonatomic, strong) UILabel *nickNameLabel;

@end

@implementation MineSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if ( self ) {
        self.frame = CGRectMake(0, 0, kScreenWidth, sectionHeaderViewHeight * adapt.scaleHeight);
        [self addSubview:self.bgImageView];
        [self addSubview:self.headImageBtn];
        [self addSubview:self.settingBtn];
        _focusMeLabel=[[UILabel alloc]initWithFrame:CGRectMake(126*adapt.scaleWidth, 162*adapt.scaleHeight, 80, 14)];
        _focusMeLabel.tag=10000;
        [self addSubview:_focusMeLabel];
        
        [self __shapeLayerWithStartPoint:CGPointMake(kScreenWidth/2, 168*adapt.scaleHeight) endPoint:CGPointMake(kScreenWidth/2, 168*adapt.scaleHeight+12)];
        
        _myFocusLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2+14*adapt.scaleWidth, 162*adapt.scaleHeight, 80, 14)];
        _myFocusLabel.tag=10001;
        [self addSubview:_myFocusLabel];
    }
    return self;
}


- (CAShapeLayer *)__shapeLayerWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.strokeColor=[UIColor colorWithHexString:@"d9d9d9"].CGColor;
    shapeLayer.lineCap   = kCALineCapRound;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    return shapeLayer;
}

-(UILabel *)labelWithLable:(UILabel *)label  Titlt:(NSString *)title digit:(int)digit 
{
    NSDictionary *placeHoldTextDic=@{NSFontAttributeName:[UIFont fontWithName:fontName size:10],NSForegroundColorAttributeName:placeHoldTextColor};
    NSMutableAttributedString *mutableAttributedString =[[NSMutableAttributedString alloc]initWithString:title attributes:placeHoldTextDic];

    NSDictionary *nomalTextDic=@{NSFontAttributeName:[UIFont fontWithName:fontName size:14],NSForegroundColorAttributeName:nomalTextColor};
    [mutableAttributedString appendAttributedString:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %d",digit] attributes:nomalTextDic]];
    label.attributedText=mutableAttributedString;
    [label sizeToFit];
    return label;
}



-(UIButton *)btnWithTitle:(NSString *)title
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
    
}


- (void)nickNameLabelWithNickName:(NSString *)nickName label:(NSString *)label {
    if ( !_nickNameLabel ) {
        _nickNameLabel = [[UILabel alloc] init];
        nickName = [NSString stringWithFormat:@"%@  |  ", nickName];
        
        NSDictionary *nickNameDic =
        @{NSForegroundColorAttributeName : placeHoldTextColor, NSFontAttributeName : [UIFont fontWithName:fontName size:15.f]};
        NSDictionary *labelDic =
        @{NSForegroundColorAttributeName : placeHoldTextColor, NSFontAttributeName : smallerFont};
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:nickName attributes:nickNameDic];
        [attr appendAttributedString:[[NSAttributedString alloc] initWithString:label attributes:labelDic]];
        _nickNameLabel.attributedText = attr;
        
        [_nickNameLabel sizeToFit];
        _nickNameLabel.centerX = self.centerX;
        _nickNameLabel.top = 128.f * adapt.scaleHeight;
        [self addSubview:_nickNameLabel];
    }
}

- (UIImageView *)bgImageView {
    if ( !_bgImageView ) {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.image = [UIImage imageNamed:@"bg"];
    }
    return _bgImageView;
}

- (UIButton *)settingBtn {
    if (!_settingBtn ) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settingBtn addTarget:[[MineViewController alloc] init] action:@selector(settingBtn:) forControlEvents:UIControlEventTouchUpInside];
        _settingBtn.size=CGSizeMake(50, 50);
        _settingBtn.left = kScreenWidth - _settingBtn.width;
        _settingBtn.top = 33.f;
    }
    return _settingBtn;
}

- (UIButton *)headImageBtn {
    if ( !_headImageBtn ) {
        _headImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_headImageBtn addTarget:[[MineViewController alloc] init] action:@selector(settingBtn:) forControlEvents:UIControlEventTouchUpInside];
        _headImageBtn.userInteractionEnabled = NO;
        _headImageBtn.frame = CGRectMake(0, 50 * adapt.scaleHeight, 58, 58);
        _headImageBtn.centerX = self.centerX;
        _headImageBtn.layer.cornerRadius = 29.f;
        _headImageBtn.clipsToBounds = YES;
        _headImageBtn.layer.borderWidth = 1.f;
        _headImageBtn.layer.borderColor = [UIColor colorWithHexString:@"#c6c6c6"].CGColor;
    }
    return _headImageBtn;
}
//-(UIVisualEffectView *)blurView
//{
//    if (!_blurView) {
//        _blurView=[[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//        _blurView.frame=self.frame;
//        [self.bgImageView addSubview:_blurView];
//    }
//    return _blurView;
//}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self endEditing:YES];
}

@end
