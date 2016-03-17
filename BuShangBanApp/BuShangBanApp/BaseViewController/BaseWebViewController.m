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

@interface BaseWebViewController () <UIWebViewDelegate,SKStoreProductViewControllerDelegate> {

    UIWebView *_webView;
    WechatShareView *_wechatShareView;
}
@property (nonatomic, retain) UIView *backgroundViews;
@property (nonatomic, retain) UIView *shareView;

@end

@implementation BaseWebViewController

-(void)viewDidLoad {

    [super viewDidLoad];
    
    [self customWebView];

    [self customRightBtn];
    
    _wechatShareView = [[WechatShareView alloc] initWechatShareView];
    [self.view addSubview:_wechatShareView];
    
    if (self.isTestWeb) {
        [self setWebUrl:@"http://192.168.1.105:3000/app"];
    }
    
    NSURLRequest *_request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.webUrl]];
    [_webView loadRequest:_request];
}

-(void)customWebView {

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, _navHeight, self.view.width, self.view.height - _navHeight)];
    [_webView setScalesPageToFit:YES];
    [_webView setDelegate:self];
    [_webView setContentMode:UIViewContentModeTop];
    [self.view addSubview:_webView];
}

-(void)setWebUrl:(NSString *)webUrl {

    _webUrl = webUrl;
    NSURLRequest *_request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_webUrl]];
    [_webView loadRequest:_request];
}

-(void)customRightBtn {

    //右侧消息按钮
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(self.navView.width - 40, self.navView.height - 35, 25, 25)];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareButton setBackgroundImage:[UIImage imageNamed:@"shareLighted"] forState:UIControlStateHighlighted];
    //             [shareButton setTitle:@"分享" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self customRightItemWithBtn:shareButton];
}

- (void)shareBtnClick:(id)sender
{
    [_wechatShareView setShareUrl:self.webUrl];
    [_wechatShareView setShareTitle:self.title];
    [_wechatShareView setShareDesc:self.title];
    [_wechatShareView showUI];
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSLog(@"webViewDidFinishLoad");
    
    //    // 非主时景界面，读取页面的title
    //    if (!self.isMainTravelTime) {
    //        NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSString *webTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    if (webTitle&&[webTitle length]>0) {
        [self setTitle:webTitle];
        [self customNavigationTitle:webTitle];
    }
    //    }
    
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
