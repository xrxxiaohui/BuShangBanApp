//
//  FindView.m
//  BuShangBanApp
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "FindView.h"
#import "FindViewController.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]
#define findViewController  [[FindViewController alloc]init]
#define margin 6
#define marginTop floor(40 * adapt.scaleHeight)
#define marginLeft floor((kScreenWidth-75* adapt.scaleWidth*3)/4)
#define TAG 1000


@implementation FindView
{
    CGFloat _left;
    CGFloat _top;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.frame = CGRectMake(0, 64, kScreenWidth, 448 * adapt.scaleHeight+12);
    if ( self )
    {
        self.backgroundColor = [UIColor whiteColor];
        NSArray *nomalImageArray = @[@"产品3",@"设计3", @"技术3", @"媒体3", @"运营3", @"创业3", @"大公司3", @"同好3", @"热门3"];
        NSArray *titleArray = @[@"产品",@"设计", @"技术", @"媒体", @"运营&市场", @"创业", @"大公司", @"同好", @"热门"];
        _left = marginLeft;
        _top = marginTop;

        for (int i = 0; i < 9; i++ )
        {
            UIButton *btn = [self __buttonWithNomalImage:[UIImage imageNamed:nomalImageArray[i]]  tag:TAG + i];
            btn.left = _left;
            btn.top = _top;
            UILabel *label = [self __labelWithText:titleArray[i] btn:btn];
            if ( i % 3 == 2 ) {
                _top = marginTop + label.bottom;
                _left = marginLeft;
            }
            else
                _left = marginLeft + btn.right;
        }
        
    }
    return self;
}

- (UIButton *)__buttonWithNomalImage:(UIImage *)nomalImage tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:nomalImage forState:UIControlStateNormal];
    btn.size = CGSizeMake(75*adapt.scaleWidth, 75*adapt.scaleWidth);
    btn.layer.cornerRadius = btn.width / 2;
    btn.tag = tag;
    [btn addTarget:findViewController action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

- (UILabel *)__labelWithText:(NSString *)text btn:(UIButton *)btn {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont fontWithName:fontName size:12.f];
    
    label.textColor = [UIColor colorWithHexString:@"#383838"];
    [label sizeToFit];
    label.top = btn.bottom + margin;
    label.centerX = btn.centerX;
    [self addSubview:label];
    
    return label;
}
@end
