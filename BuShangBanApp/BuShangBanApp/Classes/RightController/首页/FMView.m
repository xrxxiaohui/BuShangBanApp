//
//  FMView.m
//  BuShangBanApp
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "FMView.h"
#import "HomePageViewController.h"
@implementation FMView

static FMView *_FMView=nil;

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self=[super initWithFrame:frame])
    {
        HomePageViewController *homeVC=[[HomePageViewController alloc]init];
        
        UIButton *stopAndStartBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *startImage=[UIImage imageNamed:@"play"];
        [stopAndStartBtn setBackgroundImage:startImage forState:UIControlStateNormal];
        [stopAndStartBtn setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateSelected];
        stopAndStartBtn.frame=CGRectMake(0,0, startImage.size.width,  startImage.size.height);
        [stopAndStartBtn addTarget:homeVC action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        stopAndStartBtn.tag=10000;
        [self addSubview:stopAndStartBtn];
        
        UIButton *closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *closeImage=[UIImage imageNamed:@"closeBtn"];
        [closeBtn setBackgroundImage:closeImage forState:UIControlStateNormal];
        closeBtn.frame=CGRectMake(kScreenWidth-closeImage.size.width,0, closeImage.size.width,closeImage.size.height);
        [closeBtn addTarget:homeVC action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
        closeBtn.tag=10001;
        [self addSubview:closeBtn];
        
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(stopAndStartBtn.right,0, kScreenWidth-stopAndStartBtn.width-closeBtn.width, 40)];
        titleLabel.font=[UIFont fontWithName:fontName size:12];
        [self addSubview:titleLabel];
    }
    return self;
}



-(void)clickEvent:(UIButton *)sender
{
    if (sender.tag==10002)
    {
        !sender.selected ? [self __showFM]:[self __hideFM];
        sender.selected=!sender.selected;
    }else if(sender.tag==10000){
        
    }else if(sender.tag==10001){
        
    }
}

-(void)__showFM
{
    if (!_FMView) {
        _FMView=[[FMView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        _FMView.alpha=0;
//        [self.view addSubview:_FMView];
    }
    [UIView animateWithDuration:0.5 animations:^{
        _FMView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)__hideFM
{
    
}

@end
