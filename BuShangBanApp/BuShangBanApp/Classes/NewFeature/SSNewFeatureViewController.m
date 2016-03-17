//
//  SSNewFeatureViewController.m
//  ShunShunLiuXue
//
//  Created by AndyJerry on 15/9/15.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "SSNewFeatureViewController.h"
#import "UIWindow+Extension.h"
#import <POP.h>


@interface SSNewFeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SSNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
}


- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _scrollView.pagingEnabled = YES;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [_scrollView setDelegate:self];
        for (int i = 0; i < 4; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"NewFeature%d", i+1]];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
            imageView.image = image;
            imageView.left = self.view.width * i;
            [_scrollView addSubview:imageView];
            if (i == 3) { // 最后一个imageView添加按钮
                [self setupLastImageView:imageView];
            }
        }

        _scrollView.contentSize = CGSizeMake(self.view.width * 4, self.view.height);
    }
    return _scrollView;
}


- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互功能
    imageView.userInteractionEnabled = YES;

    UIButton *_arrowIcon = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 25 - 20, kScreenHeight - 25, 25, 25)];
    [_arrowIcon setImage:[UIImage imageNamed:@"left_ arrow_icon.png"] forState:UIControlStateNormal];
    [_arrowIcon setImage:[UIImage imageNamed:@"left_ arrow_icon.png"] forState:UIControlStateHighlighted];
    [_arrowIcon addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [_arrowIcon setUserInteractionEnabled:NO];
    [imageView addSubview:_arrowIcon];
    
    
    [self animationWithArrow:_arrowIcon];
    
    
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"origin.x";
//    animation.fromValue = @(kScreenWidth - 25 - 20);
//    animation.toValue = @(kScreenWidth - 25 - 80);
////    animation.additive = YES;
//    animation.repeatCount = HUGE_VALF;
//    animation.duration = 0.75;
//    
//    [_arrowIcon.layer addAnimation:animation forKey:@"basic"];
    
//    _arrowIcon.layer.origin = CGPointMake(kScreenWidth - 25 - 20, kScreenHeight - 25);
    
    // 2.开始
//    UIButton *startBtn = [[UIButton alloc] init];
//    [startBtn setBackgroundImage:[UIImage imageNamed:@"start_normal"] forState:UIControlStateNormal];
//    [startBtn setBackgroundImage:[UIImage imageNamed:@"start_select"] forState:UIControlStateHighlighted];
//    startBtn.size = startBtn.currentBackgroundImage.size;
//    startBtn.centerX = self.view.centerX;
//    startBtn.bottom = self.view.height - 95;
//    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
//    [imageView addSubview:startBtn];
}

-(void)animationWithArrow:(UIButton *)sender {

    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    //    NSInteger height = CGRectGetHeight(self.view.bounds);
    //    NSInteger width = CGRectGetWidth(self.view.bounds);
    
    //    CGFloat centerX = arc4random() % width;
    //    CGFloat centerY = arc4random() % height;
    anim.springSpeed = 60;
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth - 25 - 30, sender.centerY)];
    anim.dynamicsMass = 3;
    
    [sender pop_addAnimation:anim forKey:@"leftcenter"];
    
    POPSpringAnimation *animRight = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    
    //    NSInteger height = CGRectGetHeight(self.view.bounds);
    //    NSInteger width = CGRectGetWidth(self.view.bounds);
    
    //    CGFloat centerX = arc4random() % width;
    //    CGFloat centerY = arc4random() % height;
    animRight.springSpeed = 50;
    animRight.toValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth - 25 - 20, sender.centerY)];
    animRight.dynamicsMass = 3;
    
    [sender pop_addAnimation:animRight forKey:@"rightcenter"];
    
    
    [self performSelector:@selector(animationWithArrow:) withObject:sender afterDelay:1];
}

- (void)startClick {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window switchRootViewController];
}


#pragma mark - Scroll View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
    if (scrollView.contentOffset.x > 4*kScreenWidth - kScreenWidth + 20) {
        [self startClick];
    }
    else {
        
    }
}


@end
