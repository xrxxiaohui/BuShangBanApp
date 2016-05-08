//
//  BaseWebViewController.m
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/12.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "BaseWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <StoreKit/StoreKit.h>
#import "WechatShareView.h"
//#import <ShareSDK/ShareSDK.h>

CGFloat const gestureMinimumTranslation = 2.0 ;

typedef enum : NSInteger {
    
    kCameraMoveDirectionNone,
    
    kCameraMoveDirectionUp,
    
    kCameraMoveDirectionDown,
    
    kCameraMoveDirectionRight,
    
    kCameraMoveDirectionLeft
    
} CameraMoveDirection ;


@interface BaseWebViewController () <UIWebViewDelegate,SKStoreProductViewControllerDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate> {

    UIWebView *_webView;
    WechatShareView *_wechatShareView;
    
    UIButton *_shareButton;//分享
    UIButton *_remarkButton;//评论
    UIButton *_zanButton;//赞
    UILabel *_shareNumLabel;
    UILabel *_commentNumLabel;
    UILabel *_zanNumLabel;
    CameraMoveDirection direction;
    UIView *bottomViews;
}
@property (nonatomic, retain) UIView *backgroundViews;
@property (nonatomic, retain) UIView *shareView;

@end

@implementation BaseWebViewController

-(void)viewDidLoad {

    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    [self customNavigationBarWithTitle:@""];
    [self customWebView];

    [self customRightBtn];
    
//    _wechatShareView = [[WechatShareView alloc] initWechatShareView];
//    [self.view addSubview:_wechatShareView];

    if (self.isTestWeb) {
        [self setWebUrl:@"http://wangchaotest.duapp.com/2/index.html"];
    }
//    self.webUrl = @"http://wangchaotest.duapp.com/2/index.html";
    NSURLRequest *_request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.webUrl]];
    [_webView loadRequest:_request];
    
    [self bottomView];
    
}

-(void)customWebView {

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, _navHeight, self.view.width, self.view.height - _navHeight)];
    [_webView setScalesPageToFit:NO];
    [_webView setDelegate:self];
    [_webView setContentMode:UIViewContentModeTop];
    
    UIPanGestureRecognizer *recognizer = [[ UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handleSwipe:)];
    recognizer.delegate = self;
    [_webView addGestureRecognizer:recognizer];
    
    [self.view addSubview:_webView];
}


- ( void )handleSwipe:( UIPanGestureRecognizer *)gesture{
    
    CGPoint translation = [gesture translationInView: self .view];
    
    if (gesture.state == UIGestureRecognizerStateBegan ){
        
        direction = kCameraMoveDirectionNone;
    }else if (gesture.state == UIGestureRecognizerStateChanged && direction == kCameraMoveDirectionNone){
        
        direction = [ self determineCameraDirectionIfNeeded:translation];
        
        // ok, now initiate movement in the direction indicated by the user's gesture
        switch (direction) {
                
            case kCameraMoveDirectionDown:
                NSLog (@ "Start moving down" );
                [self nohiddenNavigationBar];
                [self noHideBottomView];
                _webView.frame = CGRectMake(0, _navHeight, self.view.width, self.view.height - _navHeight);
                break ;
                
            case kCameraMoveDirectionUp:
                
                NSLog (@ "Start moving up" );
                [self hiddenNavigationBar];
                [self hideBottomView];
                [_webView setFrame:CGRectMake(0, 0, self.view.width, self.view.height - _navHeight+64)];
                break ;
                
            case kCameraMoveDirectionRight:
                
                NSLog (@ "Start moving right" );
                break ;
                
            case kCameraMoveDirectionLeft:
                
                NSLog (@ "Start moving left" );
                break ;
                
            default :
                break ;
                
        }
        
    }
    
    else if (gesture.state == UIGestureRecognizerStateEnded ){
        
        NSLog (@ "Stop" );
        
    }
    
}

- ( CameraMoveDirection )determineCameraDirectionIfNeeded:( CGPoint )translation
{
    if (direction != kCameraMoveDirectionNone)
        return direction;
    
    // determine if horizontal swipe only if you meet some minimum velocity
    if (fabs(translation.x) > gestureMinimumTranslation)
        
    {
        BOOL gestureHorizontal = NO;
        
        if (translation.y == 0.0 )
            gestureHorizontal = YES;
        
        else
            gestureHorizontal = (fabs(translation.x / translation.y) > 5.0 );
        
        if (gestureHorizontal)
        {
            if (translation.x > 0.0 )
                return kCameraMoveDirectionRight;
            
            else
                return kCameraMoveDirectionLeft;
        }
        
    }
    
    // determine if vertical swipe only if you meet some minimum velocity
    
    else if (fabs(translation.y) > gestureMinimumTranslation)
    {
        
        BOOL gestureVertical = NO;
        
        if (translation.x == 0.0 )
            
            gestureVertical = YES;
        
        else
            
            gestureVertical = (fabs(translation.y / translation.x) > 5.0 );
        
        if (gestureVertical)
            
        {
            
            if (translation.y > 0.0 )
                
                return kCameraMoveDirectionDown;
            
            else
                
                return kCameraMoveDirectionUp;
            
        }
        
    }
    
    return direction;
    
}

-(void)hideBottomView{

    bottomViews.hidden = YES;
}

-(void)noHideBottomView{
    
    bottomViews.hidden = NO;
}

-(void)bottomView{

    bottomViews = [[UIView alloc] init];
    [bottomViews setFrame:CGRectMake(0, self.view.height-49, kScreenWidth, 49)];
    [self.view addSubview:bottomViews];
    
    UIImageView *bottomImageView = [[UIImageView alloc] init];
    [bottomViews addSubview:bottomImageView];
    [bottomImageView setImage:[UIImage imageNamed:@"bar"]];
    [bottomImageView setFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    bottomImageView.userInteractionEnabled = YES;
    
    
    _zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_zanButton setFrame:CGRectMake(296*kScreenWidth/414, 15, 14, 14)];
    [_zanButton setFrame:CGRectMake(kScreenWidth-60, 15, 14, 14)];
    [_zanButton setImage:[UIImage imageNamed:@"like_nomal"] forState:UIControlStateNormal];
    [_zanButton addTarget:self action:@selector(zanButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomImageView addSubview:_zanButton];
    
    _zanNumLabel = [[UILabel alloc] init];
    _zanNumLabel.frame = CGRectMake(_zanButton.right+4, _zanButton.y+2, 25, 12);
    [_zanNumLabel setFont:[UIFont systemFontOfSize:12]];
    [_zanNumLabel setText:@"122"];
    [_zanNumLabel setTextColor:COLOR(124, 124, 124)];
    [bottomImageView addSubview:_zanNumLabel];
    
    _remarkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_remarkButton setFrame:CGRectMake(kScreenWidth-120, 15, 14, 14)];
    [_remarkButton addTarget:self action:@selector(commentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_remarkButton setImage:[UIImage imageNamed:@"comment_nomal"] forState:UIControlStateNormal];
    [bottomImageView addSubview:_remarkButton];
    
    _commentNumLabel = [[UILabel alloc] init];
    _commentNumLabel.frame = CGRectMake(_remarkButton.right+4, _remarkButton.y+2, 25, 12);
    [_commentNumLabel setFont:[UIFont systemFontOfSize:12]];
    [_commentNumLabel setText:@"0"];
    [_commentNumLabel setTextColor:COLOR(124, 124, 124)];
    [bottomImageView addSubview:_commentNumLabel];
    
    _shareButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    [_shareButton setFrame:CGRectMake(kScreenWidth-180, 15, 14, 14)];
    [_shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_shareButton setImage:[UIImage imageNamed:@"share_nomal"] forState:UIControlStateNormal];
    [bottomImageView addSubview:_shareButton];
    
    _shareNumLabel = [[UILabel alloc] init];
    _shareNumLabel.frame = CGRectMake(_shareButton.right+4, _shareButton.y+2, 25, 12);
    [_shareNumLabel setFont:[UIFont systemFontOfSize:12]];
    [_shareNumLabel setText:@"122"];
    [_shareNumLabel setTextColor:COLOR(124, 124, 124)];
    [bottomImageView addSubview:_shareNumLabel];

    
    NSString *likes_count = [NSString stringWithFormat:@"%@",[self.dataDics valueForKeyPath:@"related_post.likes_count"]];
    [_zanNumLabel setText:likes_count];
    
    NSString *share_count = [NSString stringWithFormat:@"%@",[self.dataDics valueForKeyPath:@"related_post.share_count"]];
    
    [_shareNumLabel setText:share_count];
    
    NSString *comment_count = [NSString stringWithFormat:@"%@",[self.dataDics valueForKeyPath:@"related_post.comment_count"]];
    [_commentNumLabel setText:comment_count];
}

-(void)zanButtonClick{

    
}

-(void)commentButtonClick{

    
}

-(void)setWebUrl:(NSString *)webUrl {

    _webUrl = webUrl;
    NSURLRequest *_request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_webUrl]];
    [_webView loadRequest:_request];
}

-(void)customRightBtn {

    //右侧消息按钮
    
    NSString *categoryStr =[[self.dataDics valueForKeyPath:@"related_post.category.name"] safeString];

    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(self.navView.width - 75, self.navView.height -0, 60, 12)];
//    [shareButton setImage:[UIImage imageNamed:@"share_nomal"] forState:UIControlStateNormal];
//    [shareButton setImage:[UIImage imageNamed:@"share_selected"] forState:UIControlStateHighlighted];
    //             [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:COLOR(56, 56, 56) forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [shareButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [shareButton setTitle:categoryStr forState:UIControlStateNormal];
    
    [self customRightItemWithBtn1:shareButton];
}

- (void)shareBtnClick:(id)sender
{
    [_wechatShareView setShareUrl:self.webUrl];
    [_wechatShareView setShareTitle:self.title];
    [_wechatShareView setShareDesc:self.title];
    [_wechatShareView showUI];
}

- (void)shareButtonClick
{
    
    UIView *backgroundview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight+20)];
    backgroundview.backgroundColor =[UIColor colorWithRed:0./255. green:0./255. blue:0./255. alpha:0.2];
    
    UITapGestureRecognizer *fingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissShareView)];
    [backgroundview addGestureRecognizer: fingerTap];
    
    [self.view addSubview:backgroundview];
    self.backgroundViews = backgroundview;
    
    UIView *shareview = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenBounds.size.height, kScreenBounds.size.width, 225)];
    shareview.backgroundColor =COLOR(0xf1, 0xf1, 0xf1);
    
    
    //短信button
    UIButton *duanxinButton = [[UIButton alloc] initWithFrame:CGRectMake(47*kScreenWidth/414, 44, 50, 50)];
    UIImage *duanxinImage = [UIImage imageNamed:@"短信"];
    [duanxinButton setBackgroundImage: duanxinImage forState:UIControlStateNormal ];
    [duanxinButton addTarget:self action:@selector(ShowShareView:)forControlEvents:UIControlEventTouchUpInside];
    duanxinButton.tag = 0;
    [shareview addSubview:duanxinButton];
    [self.view addSubview:shareview];

    UILabel *labelDuanxin;
//    if(iPhone6)
//        labelDuanxin = [[UILabel alloc] initWithFrame:CGRectMake(58*kScreenWidth/320-, duanxinButton.bottom+7, 33, 15)];
//    else if (iPhone6p)
//        labelDuanxin = [[UILabel alloc] initWithFrame:CGRectMake(45*kScreenWidth/320-2, duanxinButton.bottom+7, 33, 15)];
//    else
//        labelDuanxin= [[UILabel alloc] initWithFrame:CGRectMake(45*kScreenWidth/320, duanxinButton.bottom+7, 33, 15)];
    labelDuanxin = [[UILabel alloc] initWithFrame:CGRectMake(58*kScreenWidth/414, duanxinButton.bottom+14, 33, 15)];
    labelDuanxin.textAlignment = NSTextAlignmentCenter;
    labelDuanxin.backgroundColor = [UIColor clearColor];
    labelDuanxin.textColor = [UIColor colorWithRed:124./255. green:124./255. blue:124./255. alpha:1];
    labelDuanxin.font = [UIFont systemFontOfSize:12];
    labelDuanxin.text = @"聊天";
    [shareview addSubview:labelDuanxin];

    
    //微信button
    UIButton *weixinButton = [[UIButton alloc] initWithFrame:CGRectMake((47+90)*kScreenWidth/414, 44, 50, 50)];
    UIImage *weixinImage = [UIImage imageNamed:@"微信"];
    [weixinButton setBackgroundImage: weixinImage forState:UIControlStateNormal ];
    [weixinButton addTarget:self action:@selector(ShowShareView:)forControlEvents:UIControlEventTouchUpInside];
    weixinButton.tag = 0;
    [shareview addSubview:weixinButton];
    [self.view addSubview:shareview];
    
    UILabel *labelWeixin;
    if(iPhone6)
//        labelWeixin = [[UILabel alloc] initWithFrame:CGRectMake(45*kScreenWidth/320-1, weixinButton.bottom+7, 33+33, 15)];
//    else if (iPhone6p)
//        labelWeixin = [[UILabel alloc] initWithFrame:CGRectMake(45*kScreenWidth/320-2, weixinButton.bottom+7, 33+33, 15)];
//    else
        labelWeixin= [[UILabel alloc] initWithFrame:CGRectMake(138*kScreenWidth/414-6, weixinButton.bottom+14, 33+33, 15)];
    labelWeixin.textAlignment = NSTextAlignmentCenter;
    labelWeixin.backgroundColor = [UIColor clearColor];
    labelWeixin.textColor = [UIColor colorWithRed:124./255. green:124./255. blue:124./255. alpha:1];
    labelWeixin.font = [UIFont systemFontOfSize:12];
    labelWeixin.text = @"微信好友";
    [shareview addSubview:labelWeixin];
    
    UIButton *friendsButton;
    friendsButton = [[UIButton alloc] initWithFrame:CGRectMake((138+90)*kScreenWidth/414, 44, 50, 50)];
    
    UIImage *friendsButtonImage = [UIImage imageNamed:@"朋友圈"];
    [friendsButton setBackgroundImage: friendsButtonImage forState:UIControlStateNormal ];
    [friendsButton addTarget:self action:@selector(ShowShareView:)forControlEvents:UIControlEventTouchUpInside];
    friendsButton.tag = 1;
    [shareview addSubview:friendsButton];
    
    UILabel *friendsLabel;
//    if(iPhone6)
//        friendsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140*kScreenWidth/320-2-10, weixinButton.bottom+7, 48, 15)];
//    else if (iPhone6p)
//        friendsLabel = [[UILabel alloc] initWithFrame:CGRectMake(140*kScreenWidth/320-2-16, weixinButton.bottom+7, 48, 15)];
//    else
        friendsLabel = [[UILabel alloc] initWithFrame:CGRectMake((138+90)*kScreenWidth/414, weixinButton.bottom+15, 48, 15)];
    
    friendsLabel.textAlignment = NSTextAlignmentCenter;
    friendsLabel.backgroundColor = [UIColor clearColor];
    friendsLabel.textColor = [UIColor colorWithRed:124./255. green:124./255. blue:124./255. alpha:1];
    friendsLabel.font = [UIFont systemFontOfSize:12];
    friendsLabel.text = @"朋友圈";
    [shareview addSubview:friendsLabel];
    
    UIButton *sinaButton;
    sinaButton  = [[UIButton alloc] initWithFrame:CGRectMake((138+180)*kScreenWidth/414, 44, 50, 50)];
    UIImage *sinaButtonImage = [UIImage imageNamed:@"微博"];
    [sinaButton setBackgroundImage: sinaButtonImage forState:UIControlStateNormal ];
    [sinaButton addTarget:self action:@selector(ShowShareView:)forControlEvents:UIControlEventTouchUpInside];
    sinaButton.tag = 2;
    [shareview addSubview:sinaButton];
    
    UILabel *sinaLabel;
//    if(iPhone6)
//        sinaLabel = [[UILabel alloc] initWithFrame:CGRectMake(230*kScreenWidth/320-11, weixinButton.bottom+6, 58, 15)];
//    else if (iPhone6p)
//        sinaLabel = [[UILabel alloc] initWithFrame:CGRectMake(230*kScreenWidth/320-20, weixinButton.bottom+7, 58, 15)];
//    else
        sinaLabel = [[UILabel alloc] initWithFrame:CGRectMake((138+90+90)*kScreenWidth/414-2, weixinButton.bottom+15, 58, 15)];
    sinaLabel.textAlignment = NSTextAlignmentCenter;
    sinaLabel.backgroundColor = [UIColor clearColor];
    sinaLabel.textColor = [UIColor colorWithRed:124./255. green:124./255. blue:124./255. alpha:1];
    sinaLabel.font = [UIFont systemFontOfSize:12];
    sinaLabel.text = @"微博";
    [shareview addSubview:sinaLabel];
    self.shareView = shareview;
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.frame = CGRectMake(0, 142*kScreenWidth/414, kScreenWidth, 49);
    [cancleButton addTarget:self action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [cancleButton.titleLabel setTextColor:COLOR(56, 56, 56)];
    [cancleButton.titleLabel setText:@"取消"];

    [cancleButton setBackgroundColor:[UIColor clearColor]];
//    [cancleButton setBackgroundImage:[UIImage imageNamed:@"shareCancle"] forState:UIControlStateNormal];
    [shareview addSubview:cancleButton];
    
    [UIView animateWithDuration:0.2 animations:^{
        shareview.frame = CGRectMake(0, kScreenHeight - 191+20 - 5, kScreenWidth, 191);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
            shareview.frame = CGRectMake(0,kScreenHeight - 191+20,kScreenWidth, 191);
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)dismissShareView
{
    CGFloat screenHeight=kScreenBounds.size.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.shareView.center = CGPointMake(kScreenBounds.size.width/2, screenHeight);
        self.backgroundViews.backgroundColor = [UIColor clearColor];
    }completion:^(BOOL finished){
        
        [self.shareView removeFromSuperview];
        self.shareView = nil;
        
        [self.backgroundViews removeFromSuperview];
        self.backgroundViews = nil;
        
    }];
    
}


#pragma mark -
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"webViewDidFinishLoad");
    
    //    // 非主时景界面，读取页面的title
    //    if (!self.isMainTravelTime) {
    //        NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
//    NSString *webTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
//    if (webTitle&&[webTitle length]>0) {
//        [self setTitle:webTitle];
//        [self customNavigationTitle:webTitle];
//    }
    //    }
    /*
    JSContext *context =  [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"]; // Undocumented access
    
    __weak typeof(self) weakSelf = self;
    
    context[@"shareWX"] = ^(NSString *param) {
        NSLog(@"User clicked submit. param1=%@", param);
        
        [weakSelf shareBtnClick:nil];
        
//        if ([param isEqualToString:@"friend"]) {
//            // 微信好友
//            
//        }
//        else if ([param isEqualToString:@"timeline"]) {
//            
//            // 朋友圈
//            [self shareBtnClick:nil];
//        }
    };
    
    context[@"promoteApp"] = ^(NSString *param) {
        NSLog(@"User clicked submit. param1=%@", param);
        
        SKStoreProductViewController *skProductViewController = [[SKStoreProductViewController alloc] init];
        skProductViewController.delegate = self;
        [skProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:param}
                                           completionBlock:^(BOOL result, NSError *error){}];
        [self presentViewController:skProductViewController animated:YES completion:nil];
    };
}

-(void)testBtnClick:(UIButton *)sender {
    
    switch (sender.tag) {
        case 0:
        {
            //开始调用自定义的javascript
            [_webView stringByEvaluatingJavaScriptFromString:@"shareWXResult(true);"];
        }
            break;
        case 1:
        {
            //开始调用自定义的javascript
            [_webView stringByEvaluatingJavaScriptFromString:@"shareWXResult(false);"];
        }
            break;
            
        default:
            break;
    }
*/
}

#pragma mark - SKStoreProductViewController Delegate

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

//#pragma mark - Share Wechat 
//
//- (void)showToWechat:(UIButton *)sender {
//    
//    ShareType type = 0;
//    switch (sender.tag) {
//        case 0:
//            type = ShareTypeWeixiSession;
//            break;
//        case 1:
//            type = ShareTypeWeixiTimeline;
//            break;
//        case 2:
//            type = ShareTypeWeixiFav;
//            break;
//        default:
//            break;
//    }
//    
//    NSString* path = [[NSBundle mainBundle]pathForResource:@"Icon" ofType:@"png"];
//    
//    
//    id<ISSContent> publishContent = [ShareSDK content:self.title defaultContent:nil image:[ShareSDK imageWithPath:path] title:self.shareTitle url:self.shareUrl description:nil mediaType:SSPublishContentMediaTypeNews];
//    
//    //2.分享
//    [ShareSDK showShareViewWithType:type container:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:nil result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//        //如果分享成功
//        if (state == SSResponseStateSuccess) {
//            NSLog(@"分享成功");
//            [self performSelector:@selector(dismissShareView) withObject:nil afterDelay:1.5];
//            [MBProgressHUD showSuccess:@"分享成功"];
//            
//        }else if (state == SSResponseStateFail) {
//            NSLog(@"分享失败,错误码:%ld,错误描述%@",(long)[error errorCode],[error errorDescription]);
//            [MBProgressHUD showSuccess:@"分享失败"];
//            [self performSelector:@selector(dismissShareView) withObject:nil afterDelay:1.5];
//        }else if (state == SSResponseStateCancel){
//            NSLog(@"分享取消");
//            [MBProgressHUD showSuccess:@"分享取消"];
//            [self performSelector:@selector(dismissShareView) withObject:nil afterDelay:1.5];
//        }
//    }];
//}

@end
