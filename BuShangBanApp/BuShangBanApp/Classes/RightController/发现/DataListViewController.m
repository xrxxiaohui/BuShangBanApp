//
//  DataListViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "DataListViewController.h"
#import "DetailViewController.h"
#import "DataListTableViewCell.h"
#import "BaseWebViewController.h"

//https://leancloud.cn:443/1.1/classes/Post?where=%7B%22category%22%3A%7B%22__type%22%3A%22Pointer%22%2C%22className%22%3A%22PostCagegory%22%2C%22objectId%22%3A%22571eae66c4c9710056d94de6%22%7D%7D&&&order=-sort&&keys=-body

#define URL @"https://leancloud.cn:443/1.1/classes/Post?where=%7B%22category%22%3A%7B%22__type%22%3A%22Pointer%22%2C%22className%22%3A%22PostCagegory%22%2C%22objectId%22%3A%22571eae66c4c9710056d94de6%22%7D%7D&&&order=-sort&&keys=-body&include=author,category"

@interface DataListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView  *tabelView;
@property(nonatomic,strong)NSArray *results;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *URLArray;
@property(nonatomic,strong)NSMutableArray *imageURLArray;
@property(nonatomic,strong)NSMutableArray *profileArray;
@property(nonatomic,strong)NSMutableArray *avarArray;
@property(nonatomic,strong)NSDictionary *tempDic;

@end


@implementation DataListViewController
{
    NSString *_title;
    NSString *_objectID;
}

-(instancetype)init
{
    if (self=[super init]) {
        self.URLArray=[NSMutableArray array];
        self.titleArray=[NSMutableArray array];
        self.profileArray=[NSMutableArray array];
        self.imageURLArray=[NSMutableArray array];
        self.avarArray=[NSMutableArray array];
    }
    return self;
}

-(instancetype)initWithTitle:(NSString *)titile objectID:(NSString *)objectID
{
    if ([self init]) {
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
    [_urlParamsReq1 setUrlString:URL];
    NSDictionary *_paramsDict = @{  @"category":_title?_title:@0   };
    [_urlParamsReq1 setParamsDict:_paramsDict];
    _urlParamsReq1.requestMethod = YTKRequestMethodPost;
    
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq1 successBlock:^(SSLXResultRequest *successReq){
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        self.results=_successInfo[@"results"];
        self.tempDic = _successInfo;
        for (NSDictionary *dic in self.results)
        {
//            if ([dic[@"author"][@"objectId"] isEqualToString:_objectID])
             NSString *avatarString = [[dic valueForKeyPath:@"author.avatar.url"] safeString];
            
            [self.URLArray addObject:dic[@"link"]];
            [self.titleArray addObject:dic[@"title"]];
            [self.profileArray addObject:dic[@"summary"]];
            [self.imageURLArray addObject:dic[@"feature_image"]];
            [self.avarArray addObject:avatarString];
        }
        self.tabelView.backgroundColor=bgColor;
    } failureBlock:^(SSLXResultRequest *failReq){
        NSString *_errorMsg = [[failReq.responseString objectFromJSONString] valueForKeyPath:@"result.error.errorMessage"];
        _errorMsg? [MBProgressHUD showError:_errorMsg]: [MBProgressHUD showError:kMBProgressErrorTitle];
    }];
}

-(UITableView *)tabelView
{
    if (!_tabelView) {
        _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tabelView.delegate=self;
        _tabelView.dataSource=self;
        _tabelView.separatorColor=[UIColor whiteColor];
        [_tabelView registerClass:[DataListTableViewCell class] forCellReuseIdentifier:@"DataListTableViewCell"];
        [self.view addSubview:_tabelView];
    }
    return _tabelView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.results.count;
}

-(DataListTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"DataListTableViewCell";
    DataListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (!cell)
        cell = [[DataListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.leftUpLabel.text=_title;
    [cell.leftUpLabel sizeToFit];
    cell.mainContentLabel.text=self.profileArray[indexPath.row];
    cell.mainTitleLabel.text=self.titleArray[indexPath.row];
    [cell.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"place"]];
    [cell.rightAvarButton sd_setImageWithURL:[NSURL URLWithString:self.avarArray[indexPath.row]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"authoravar"] options:SDWebImageRefreshCached];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *urlStr = self.URLArray[indexPath.row];
    BaseWebViewController *baseWebView = [[BaseWebViewController alloc] init];
    baseWebView.isTestWeb = NO;
    baseWebView.webUrl = urlStr;
    baseWebView.dataDics = self.tempDic;
    [[SliderViewController sharedSliderController].navigationController pushViewController:baseWebView animated:YES ];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DataListTableViewCell getCellHeight];
}

@end
