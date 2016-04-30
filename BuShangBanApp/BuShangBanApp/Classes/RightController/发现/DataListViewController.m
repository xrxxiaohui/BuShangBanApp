//
//  DataListViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "DataListViewController.h"
#import "DetailViewController.h"
#import "HomePageContentCell.h"

@interface DataListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView  *tabelView;
@property(nonatomic,strong)NSArray *results;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *URLArray;
@end

//https://leancloud.cn:443/1.1/classes/Post?where=%7B%22category%22%3A%7B%22__type%22%3A%22Pointer%22%2C%22className%22%3A%22PostCagegory%22%2C%22objectId%22%3A%22571eae66c4c9710056d94de6%22%7D%7D&&&order=-sort&&keys=-body

@implementation DataListViewController
{
    NSString *_title;
    NSString *_objectID;
}


-(instancetype)initWithTitle:(NSString *)titile objectID:(NSString *)objectID
{
    if (self=[super init]) {
        _title=titile;
        _objectID=objectID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBarWithTitle:_title];
     self.view.backgroundColor=bgColor;
    
    SSLXUrlParamsRequest *_urlParamsReq1 = [[SSLXUrlParamsRequest alloc] init];
    [_urlParamsReq1 setUrlString:@"Post?where=%7B%22category%22%3A%7B%22__type%22%3A%22Pointer%22%2C%22className%22%3A%22PostCagegory%22%2C%22objectId%22%3A%22571eae66c4c9710056d94de6%22%7D%7D&&&order=-sort&&keys=-body"];
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq1 successBlock:^(SSLXResultRequest *successReq){
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        self.results=_successInfo[@"results"];
        self.tabelView.backgroundColor=bgColor;
    } failureBlock:^(SSLXResultRequest *failReq){
        NSDictionary *_failDict = [failReq.responseString objectFromJSONString];
        NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
        _errorMsg? [MBProgressHUD showError:_errorMsg]: [MBProgressHUD showError:kMBProgressErrorTitle];
    }];
}

-(UITableView *)tabelView
{
    if (!_tabelView) {
        _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tabelView.delegate=self;
        _tabelView.dataSource=self;
        [_tabelView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HomePageContentCell"];
        [self.view addSubview:_tabelView];
    }
    return _tabelView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.results.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"HomePageContentCell";
    HomePageContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[HomePageContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    NSDictionary *tempDic = [[self.results objectAtIndex:indexPath.row] safeDictionary];
    [cell setDataInfo:tempDic];
    [cell refreshUI];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *vc=[[DetailViewController alloc]initWithURL:self.URLArray[indexPath.row]];
    [[SliderViewController sharedSliderController].navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return [HomePageContentCell getCellHeight];
}

@end
