//
//  DetailViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/30.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation DetailViewController
{
    NSString *_URL;
}

-(instancetype)initWithURL:(NSString *)URL
{
    if (self=[super init]) {
        _URL=URL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationBarWithTitle:@"文章"];
    [self defaultLeftItem];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    [_webView setScalesPageToFit:YES];
    [_webView setContentMode:UIViewContentModeTop];
    [self.view addSubview:_webView];
    NSString *webUrl = _URL;
    NSURLRequest *_request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:webUrl]];
    [_webView loadRequest:_request];

}

@end
