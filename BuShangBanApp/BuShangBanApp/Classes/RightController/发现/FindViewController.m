//
//  FindViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "FindViewController.h"
#import "FindView.h"
#import "DataListViewController.h"
#import "SliderViewController.h"

//https://leancloud.cn:443/1.1/classes/PostCategory?order=-sort&&keys=-ACL%2C-createdAt%2C-updatedAt

#define URL @"PostCategory?order=-sort&&keys=-ACL%2C-createdAt%2C-updatedAt"

@interface FindViewController ()
@property(nonatomic,strong)NSDictionary *dic;
@property(nonatomic,strong)NSMutableArray *articalInfoArray;
@end

@implementation FindViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBarWithTitle:@"发现"];
    FindView *findView = [[FindView alloc] init];
    self.dic=@{@"1000":@"产品",@"1001":@"设计",@"1002":@"技术", @"1003":@"市场", @"1004":@"运营", @"1005":@"创业",@"1006": @"大公司", @"1007":@"干货",@"1008": @"热门"};
    [self.view addSubview:findView];
    
    SSLXUrlParamsRequest *_urlParamsReq1 = [[SSLXUrlParamsRequest alloc] init];
    [_urlParamsReq1 setUrlString:URL];
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq1 successBlock:^(SSLXResultRequest *successReq){
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        self.articalInfoArray=_successInfo[@"results"];

        self.articalInfoArray=[self __sortContentWithkeys:@[@"产品",@"设计",@"技术",@"媒体",@"运营&市场",@"创业",@"大公司",@"同好",@"默认分类"]];
    }failureBlock:^(SSLXResultRequest *failReq){
        NSDictionary *_failDict = [failReq.responseString objectFromJSONString];
        NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
        _errorMsg? [MBProgressHUD showError:_errorMsg]: [MBProgressHUD showError:kMBProgressErrorTitle];
    }];
}


- (void)clickEvent:(UIButton *)button
{
    NSInteger Index=button.tag;
    DataListViewController *dataListViewController = [[DataListViewController alloc] initWithTitle:[self.dic objectForKey:[NSString stringWithFormat:@"%ld",Index] ]objectID:[self.articalInfoArray[Index-1000] objectForKey:@"objectId"]];
    [[SliderViewController sharedSliderController].navigationController pushViewController:dataListViewController animated:YES];
}

-(NSMutableArray*)__sortContentWithkeys:(NSArray *)keys
{
    NSMutableArray *arr=[NSMutableArray new];
    for(int i=0;i<self.articalInfoArray.count; i++)
        for(NSDictionary *dic in self.articalInfoArray)
        {
            NSLog(@"%@",dic[@"name"]);
            if ([dic[@"name"] isEqualToString:keys[i]])
                [arr addObject:dic];
        }
    return arr;
}

@end
