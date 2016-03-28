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
#define marginTop floor(50 * adapt.scaleHeight)
#define marginLeft floor((kScreenWidth-150)/4)
#define TAG 1000


@implementation FindView {
    CGFloat _left;
    CGFloat _top;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.frame = CGRectMake(0, 64, kScreenWidth, 404 * adapt.scaleHeight);
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        NSArray *nomalImageArray = @[@"find", @"find", @"find", @"find", @"find", @"find", @"find", @"find", @"find", @"find"];
        NSArray *selectedImageArray = @[@"find", @"find", @"find", @"find", @"find", @"find", @"find", @"find", @"find", @"find"];

        NSArray *titleArray = @[@"技术", @"产品", @"设计", @"投资", @"管理", @"媒体", @"市场", @"运营", @"热门"];

        _left = marginLeft;
        _top = marginTop;

        for (int i = 0; i < 9; i++) {
            UIButton *btn = [self buttonWithNomalImage:[UIImage imageNamed:nomalImageArray[i]] selectedImage:[UIImage imageNamed:selectedImageArray[i]] tag:TAG + i];
            btn.left = _left;
            btn.top = _top;
            UILabel *label = [self labelWithText:titleArray[i] btn:btn];
            if (i % 3 == 2) {
                _top = marginTop + label.bottom;
                _left = marginLeft;
            }
            else {
                _left = marginLeft + btn.right;
            }
        }
    }
    return self;
}


- (UIButton *)buttonWithNomalImage:(UIImage *)nomalImage selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:nomalImage forState:UIControlStateNormal];
    [btn setBackgroundImage:selectedImage forState:UIControlStateSelected];
    btn.size = CGSizeMake(50, 50);
    btn.layer.cornerRadius = btn.width / 2;
    btn.tag = tag;
    [btn addTarget:findViewController action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
}

- (UILabel *)labelWithText:(NSString *)text btn:(UIButton *)btn {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:12.f];
    label.textColor = [UIColor colorWithHexString:@"#383838"];
    [label sizeToFit];
    label.top = btn.bottom + margin;
    label.centerX = btn.centerX;
    [self addSubview:label];
    return label;
}
@end
