//
//  FMViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "FMViewController.h"
#import <AVFoundation/AVFoundation.h>

#define URL @"https://leancloud.cn:443/1.1/classes/Broadcast?limit=1&&-order=sort&&keys=-ACL"


@interface FMViewController ()
{
    AVPlayer *_broadcastPlay;
    NSArray  *_dataSource;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation FMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self __loadData];
//    [self __sortData];
    
    
}

-(void)__loadData
{
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
    [_urlParamsReq setUrlString:URL];
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successRequest){
        NSArray *array= [NSArray arrayWithArray:[successRequest.responseString objectFromJSONString][@"results"]];
        [self __playWithDataSource:array];
    } failureBlock:^(SSLXResultRequest *failRequest){
        NSString *_errorMsg = [[failRequest.responseString objectFromJSONString] objectForKey:@"error"];
        _errorMsg?[MBProgressHUD showError:_errorMsg]:[MBProgressHUD showError:kMBProgressErrorTitle];
    }];
}

-(void)__playWithDataSource:(NSArray *)dataSource
{
    _dataSource=[NSArray arrayWithArray:dataSource];
    _broadcastPlay=[[AVPlayer alloc]initWithURL:[NSURL URLWithString:dataSource[0][@"url"]]];
    _titleLabel.text=dataSource[0][@"title"];
    _broadcastPlay.volume=3;
    [_broadcastPlay play];
}

-(void)__sortData
{
    NSMutableArray *sortArray=[NSMutableArray arrayWithCapacity:[_dataSource count]];
    
    for(int i=1;i<=[_dataSource count];i++)
    {
        for (NSDictionary *dic in _dataSource)
            if([dic[@"sort"] integerValue]==i)
                [sortArray addObject:dic];
    }
    _dataSource=sortArray;
}

- (IBAction)clickBtn:(UIButton *)sender {
    if(sender.tag == 1000)
    {
        sender.selected=!sender.selected;
        sender.selected?[_broadcastPlay play]:[_broadcastPlay pause];
    }
    else
    {
        [_broadcastPlay pause];
        [UIView animateWithDuration:0.5 animations:^{
            self.view.height=0;
            self.view.alpha=0;
        }];
    }
}


@end
