//
//  WechatShareView.m
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/13.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "WechatShareView.h"
#import <ShareSDK/ShareSDK.h>

@interface WechatShareView () {

    UIView *_shareDishView;
}

@end

@implementation WechatShareView

-(id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor =[UIColor colorWithRed:0./255. green:0./255. blue:0./255. alpha:0.5];
        
        UITapGestureRecognizer *fingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissShareView)];
        [self addGestureRecognizer: fingerTap];
        
        _shareDishView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenBounds.size.height, kScreenBounds.size.width, 225)];
        //    UIView *shareview = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenBounds.size.height-225+20, kScreenBounds.size.width, 225)];
        _shareDishView.backgroundColor =COLOR(0xf1, 0xf1, 0xf1);
        [self addSubview:_shareDishView];
        
        //微信button
        UIButton *weixinButton = [[UIButton alloc] initWithFrame:CGRectMake(35*kScreenWidth/320, 50, 50, 50)];
        UIImage *weixinImage = [UIImage imageNamed:@"wechat"];
        [weixinButton setBackgroundImage: weixinImage forState:UIControlStateNormal ];
        [weixinButton addTarget:self action:@selector(ShowShareView:)forControlEvents:UIControlEventTouchUpInside];
        weixinButton.tag = 0;
        [_shareDishView addSubview:weixinButton];
        
        UILabel *labelWeixin;
        if(iPhone6)
            labelWeixin = [[UILabel alloc] initWithFrame:CGRectMake(45*kScreenWidth/320-1, weixinButton.bottom+7, 33, 15)];
        else if (iPhone6p)
            labelWeixin = [[UILabel alloc] initWithFrame:CGRectMake(45*kScreenWidth/320-2, weixinButton.bottom+7, 33, 15)];
        else
            labelWeixin= [[UILabel alloc] initWithFrame:CGRectMake(45*kScreenWidth/320, weixinButton.bottom+7, 33, 15)];
        labelWeixin.textAlignment = NSTextAlignmentCenter;
        labelWeixin.backgroundColor = [UIColor clearColor];
        labelWeixin.textColor = [UIColor colorWithRed:48./255. green:48./255. blue:48./255. alpha:1];
        labelWeixin.font = [UIFont systemFontOfSize:13];
        labelWeixin.text = @"微信";
        [_shareDishView addSubview:labelWeixin];
        
        UIButton *friendsButton;
        friendsButton = [[UIButton alloc] initWithFrame:CGRectMake(weixinButton.right+50*kScreenWidth/320+kScreenWidth/320, 50, 50, 50)];
        
        UIImage *friendsButtonImage = [UIImage imageNamed:@"friendsShare"];
        [friendsButton setBackgroundImage: friendsButtonImage forState:UIControlStateNormal ];
        [friendsButton addTarget:self action:@selector(ShowShareView:)forControlEvents:UIControlEventTouchUpInside];
        friendsButton.tag = 1;
        [_shareDishView addSubview:friendsButton];
        
        UILabel *friendsLabel;
        if(iPhone6)
            friendsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140*kScreenWidth/320-2-10, weixinButton.bottom+7, 48, 15)];
        else if (iPhone6p)
            friendsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140*kScreenWidth/320-2-16, weixinButton.bottom+7, 48, 15)];
        else
            friendsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140*kScreenWidth/320-2, weixinButton.bottom+7, 48, 15)];
        
        friendsLabel.textAlignment = NSTextAlignmentCenter;
        friendsLabel.backgroundColor = [UIColor clearColor];
        friendsLabel.textColor = [UIColor colorWithRed:48./255. green:48./255. blue:48./255. alpha:1];
        friendsLabel.font = [UIFont systemFontOfSize:13];
        friendsLabel.text = @"朋友圈";
        [_shareDishView addSubview:friendsLabel];
        
        UIButton *sinaButton;
        sinaButton  = [[UIButton alloc] initWithFrame:CGRectMake(friendsButton.right+50*kScreenWidth/320+kScreenWidth/320, 50, 50, 50)];
        UIImage *sinaButtonImage = [UIImage imageNamed:@"weixinSave"];
        [sinaButton setBackgroundImage: sinaButtonImage forState:UIControlStateNormal ];
        [sinaButton addTarget:self action:@selector(ShowShareView:)forControlEvents:UIControlEventTouchUpInside];
        sinaButton.tag = 2;
        [_shareDishView addSubview:sinaButton];
        
        UILabel *sinaLabel;
        if(iPhone6)
            sinaLabel = [[UILabel alloc] initWithFrame:CGRectMake(230*kScreenWidth/320-11, weixinButton.bottom+6, 58, 15)];
        else if (iPhone6p)
            sinaLabel = [[UILabel alloc] initWithFrame:CGRectMake(230*kScreenWidth/320-20, weixinButton.bottom+7, 58, 15)];
        else
            sinaLabel = [[UILabel alloc] initWithFrame:CGRectMake(230*kScreenWidth/320+3, weixinButton.bottom+7, 58, 15)];
        sinaLabel.textAlignment = NSTextAlignmentCenter;
        sinaLabel.backgroundColor = [UIColor clearColor];
        sinaLabel.textColor = [UIColor colorWithRed:48./255. green:48./255. blue:48./255. alpha:1];
        sinaLabel.font = [UIFont systemFontOfSize:13];
        sinaLabel.text = @"微信收藏";
        [_shareDishView addSubview:sinaLabel];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(kScreenWidth/2-16, _shareDishView.frame.size.height-50, 32, 32);
        [backButton addTarget:self action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
        [backButton setBackgroundColor:[UIColor clearColor]];
        [backButton setBackgroundImage:[UIImage imageNamed:@"shareCancle"] forState:UIControlStateNormal];
        [_shareDishView addSubview:backButton];
    }
    
    return self;
}

-(id)initWechatShareView {

    self = [[WechatShareView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+20)];
    
    if (self) {
        self.alpha = 0;
    }
    
    return self;
}

- (void)ShowShareView:(UIButton *)sender {
    
    ShareType type = 0;
    switch (sender.tag) {
        case 0:
            type = ShareTypeWeixiSession;
            break;
        case 1:
            type = ShareTypeWeixiTimeline;
            break;
        case 2:
            type = ShareTypeWeixiFav;
            break;
        default:
            break;
    }
    
    NSString* path = [[NSBundle mainBundle]pathForResource:@"Icon" ofType:@"png"];
    
    
    id<ISSContent> publishContent = [ShareSDK content:SafeForString(self.shareDesc) defaultContent:nil image:[ShareSDK imageWithPath:path] title:SafeForString(self.shareTitle) url:SafeForString(self.shareUrl) description:SafeForString(self.shareDesc) mediaType:SSPublishContentMediaTypeNews];
    
    //2.分享
    [ShareSDK showShareViewWithType:type container:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        //如果分享成功
        if (state == SSResponseStateSuccess) {
            NSLog(@"分享成功");
            [self performSelector:@selector(dismissShareView) withObject:nil afterDelay:1.5];
            [MBProgressHUD showSuccess:@"分享成功"];
            
        }else if (state == SSResponseStateFail) {
            NSLog(@"分享失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
            [MBProgressHUD showSuccess:@"分享失败"];
            [self performSelector:@selector(dismissShareView) withObject:nil afterDelay:1.5];
        }else if (state == SSResponseStateCancel){
            NSLog(@"分享取消");
            [MBProgressHUD showSuccess:@"分享取消"];
            [self performSelector:@selector(dismissShareView) withObject:nil afterDelay:1.5];
        }
    }];
}


- (void)dismissShareView
{
    
    __weak typeof(self) weakSelf = self;
    //    CGFloat screenHeight=kScreenBounds.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        
        _shareDishView.top = weakSelf.height;
        [weakSelf setAlpha:0];
        
    }completion:^(BOOL finished){
        
    }];
    
}

-(void)showUI {

    __weak typeof(self) weakSelf = self;
    //    CGFloat screenHeight=kScreenBounds.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        
        _shareDishView.top = weakSelf.height - _shareDishView.height;
        [weakSelf setAlpha:1];
        
    }completion:^(BOOL finished){
        
    }];
}

-(void)refreshUI {

}

-(void)dealloc {

    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
