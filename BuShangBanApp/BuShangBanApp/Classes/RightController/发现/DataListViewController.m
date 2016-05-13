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

//#define URL @"https://leancloud.cn:443/1.1/classes/Post?where=%7B%22category%22%3A%7B%22__type%22%3A%22Pointer%22%2C%22className%22%3A%22PostCagegory%22%2C%22objectId%22%3A%22571eae66c4c9710056d94de6%22%7D%7D&&&order=-sort&&keys=-body&include=author,category"

#define headUrl @"https://leancloud.cn:443/1.1/classes/Post?where="
#define URL @"{\"category\":{\"__type\":\"Pointer\",\"className\":\"PostCagegory\",\"objectId\":\"%@\"}}"
#define url1 @"order=-published_at"
#define url2 @"-body,-body_html,-ACL"
#define url3 @"category,author"
#define url4 @"limit=100"

#define ChuangyeTouZi @"{\"category\":{\"$in\":[{\"__type\":\"Pointer\",\"className\":\"PostCategory\",\"objectId\":\"573594cb71cfe40057e97b57\"},{\"__type\":\"Pointer\",\"className\":\"PostCategory\",\"objectId\":\"571eb422df0eea0062af7736\"}]}}"

#define MarketYunYing @"{\"category\":{\"$in\":[{\"__type\":\"Pointer\",\"className\":\"PostCategory\",\"objectId\":\"573594c61532bc00653a06fd\"},{\"__type\":\"Pointer\",\"className\":\"PostCategory\",\"objectId\":\"571eb43279bc440066a23361\"}]}}"

@interface DataListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView  *tabelView;
@property(nonatomic,strong)NSArray *results;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *URLArray;
@property(nonatomic,strong)NSMutableArray *imageURLArray;
@property(nonatomic,strong)NSMutableArray *profileArray;
@property(nonatomic,strong)NSMutableArray *avarArray;
@property(nonatomic,strong)NSMutableArray *shareCountArray;
@property(nonatomic,strong)NSMutableArray *likeCountArray;
@property(nonatomic,strong)NSMutableArray *commentCountArray;
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
        self.shareCountArray=[NSMutableArray array];
        self.likeCountArray=[NSMutableArray array];
        self.commentCountArray=[NSMutableArray array];
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
    
    NSString *tempUrl = @"";
    
    if(([_title rangeOfString:@"创业"].location!=NSNotFound)||([_title rangeOfString:@"投资"].location!=NSNotFound)){
    
        tempUrl = ChuangyeTouZi;
    }else if(([_title rangeOfString:@"市场"].location!=NSNotFound)||([_title rangeOfString:@"运营"].location!=NSNotFound)){
    
        tempUrl = MarketYunYing;
    }else{
            tempUrl = [NSString stringWithFormat:URL,_objectID];
    }
    NSString *encodeUrlString =[self encodeToPercentEscapeString:tempUrl];
    NSString *encodeUrlString2 = [self encodeToPercentEscapeString:url2];
    NSString *encodeUrlString3 = [self encodeToPercentEscapeString:url3];

    NSString *finalUrl = [NSString stringWithFormat:@"%@%@&%@&%@&include=%@&keys=%@",headUrl,encodeUrlString,url1,url4,encodeUrlString3,encodeUrlString2];
    
    [_urlParamsReq1 setUrlString:finalUrl];

    _urlParamsReq1.requestMethod = YTKRequestMethodGet;
    
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq1 successBlock:^(SSLXResultRequest *successReq){
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        self.results=_successInfo[@"results"];
        self.tempDic = _successInfo;
        for (NSDictionary *dic in self.results)
        {
             NSString *avatarString = SafeForString([dic valueForKeyPath:@"author.avatar.url"]);
            [self.URLArray addObject:dic[@"link"]];
            [self.titleArray addObject:dic[@"title"]];
            [self.profileArray addObject:dic[@"summary"]];
            [self.imageURLArray addObject:dic[@"feature_image"]];
            [self.commentCountArray addObject:dic[@"comment_count"]];
            [self.likeCountArray addObject:dic[@"like_count"]];
            [self.shareCountArray addObject:dic[@"share_count"]];
            [self.avarArray addObject:avatarString];

        }
        self.tabelView.backgroundColor=bgColor;
    } failureBlock:^(SSLXResultRequest *failReq){
        NSString *_errorMsg = [[failReq.responseString objectFromJSONString] valueForKeyPath:@"result.error.errorMessage"];
        _errorMsg? [MBProgressHUD showError:_errorMsg]: [MBProgressHUD showError:kMBProgressErrorTitle];
    }];
}

- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString* outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, /* allocator */(__bridge CFStringRef)input,NULL, /* charactersToLeaveUnescaped */ (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    return outputStr;
}

-(UITableView *)tabelView
{
    if (!_tabelView) {
        _tabelView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        _tabelView.delegate=self;
        _tabelView.dataSource=self;
        _tabelView.separatorColor=[UIColor whiteColor];
        _tabelView.showsVerticalScrollIndicator=NO;
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
    
    NSString *categoryStr =[_title safeString];
    if([categoryStr isEqualToString:@"默认分类"])
        categoryStr = @"默认";
    else if([categoryStr isEqualToString:@"大公司"])
        categoryStr = @"公司";
    else if ([categoryStr isEqualToString:@"运营&市场"])
        categoryStr = @"运营";
    else if ([categoryStr isEqualToString:@"原创封面"])
        categoryStr = @"原创";

    cell.leftUpLabel.text=categoryStr;
    cell.mainContentLabel.text=self.profileArray[indexPath.row];
    cell.mainTitleLabel.text=self.titleArray[indexPath.row];
    cell.shareNumLabel.text=[NSString stringWithFormat:@"%@",self.shareCountArray[indexPath.row]];
    cell.commentNumLabel.text=[NSString stringWithFormat:@"%@",self.commentCountArray[indexPath.row]];;
    cell.zanNumLabel.text=[NSString stringWithFormat:@"%@",self.likeCountArray[indexPath.row]];
    [cell.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.imageURLArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"place"]];
    [cell.rightAvarButton sd_setImageWithURL:[NSURL URLWithString:self.avarArray[indexPath.row]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"authoravar"] options:SDWebImageRefreshCached];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.URLArray.count>indexPath.row)
    {
        NSString *urlStr = self.URLArray[indexPath.row];
        BaseWebViewController *baseWebView = [[BaseWebViewController alloc] init];
        baseWebView.isTestWeb = NO;
        baseWebView.webUrl = urlStr;
        baseWebView.dataDics = self.tempDic;
        [[SliderViewController sharedSliderController].navigationController pushViewController:baseWebView animated:YES ];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [DataListTableViewCell getCellHeight];
}

@end
/*
 
 
 */
