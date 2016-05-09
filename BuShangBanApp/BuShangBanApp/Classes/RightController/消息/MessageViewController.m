//
//  MessageViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MJRefresh.h"
#import "LoginViewController.h"
#import "BaseWebViewController.h"

@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UITableView *_mainTableView;
    NSMutableArray *_dataArray;
    int page;
    BOOL _logined;
    BOOL _hasPush;
}

@end

@implementation MessageViewController

//https://leancloud.cn:443/1.1/classes/Message?limit=10&&order=-createdAt&&

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBarWithTitle:@"消息"];
//<<<<<<< HEAD
//    
//    self.view.backgroundColor = [UIColor yellowColor];
//    
//    [self initData];
//    [self createTabelView];
//    [self fetchData];
//=======
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"gotoFirstPage" object:nil];
    _logined =[[[NSUserDefaults standardUserDefaults]objectForKey:@"Loginned"] boolValue] ;
    if(!_logined)
    {
        _hasPush=YES;
        [[SliderViewController sharedSliderController].navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
    }
    else
    {
        self.view.backgroundColor = [UIColor yellowColor];
        [self initData];
        [self createTabelView];
        [self fetchData];
    }
//>>>>>>> 7072ceed0cabe37811d67a19de74bf59dc26b3dc
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if(!_hasPush)
        [[SliderViewController sharedSliderController].navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
}

-(void)initData{
    page = 1;
    _dataArray = [[NSMutableArray alloc] init];
}

-(void)createTabelView{
    
    UIImageView *lineImageView = [[UIImageView alloc] init];
    lineImageView.backgroundColor = COLOR(0xd9, 0xd9, 0xd9);
    [lineImageView setFrame:CGRectMake(0, 64, kScreenWidth, 1)];
    [self.view addSubview:lineImageView];
    
    
    CGFloat height = kScreenHeight - 44;
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.view.width, height) style:UITableViewStylePlain];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.backgroundColor = COLOR(249, 249, 249);
    //设置下拉刷新回调
    [_mainTableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //    [_mainTableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(requestDataMore)];
    
    [self.view addSubview:_mainTableView];
    
    UIImageView *lineImageView1 = [[UIImageView alloc] init];
    lineImageView1.backgroundColor = COLOR(0xd9, 0xd9, 0xd9);
    [lineImageView1 setFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 1)];
    [self.view addSubview:lineImageView1];

}

-(void)loadNewData{
    
    page = 1;
    [self fetchData];
}

-(void)fetchData {
    
    // 请求
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
    [_urlParamsReq setUrlString:@"https://leancloud.cn:443/1.1/classes/Message?limit=100&&order=-createdAt&&"];
    
    //    NSDictionary *_tempParam = @{@"bid":@"888888"};
    //    [_urlParamsReq setParamsDict:_tempParam];
    
    NSDictionary *_tempParam = @{@"bid":@"888888"};
    
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successReq){
        
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        NSArray *_resultArray = [[_successInfo objectForKey:@"results"] safeArray];
        //        NSDictionary *_businessData = [_resultInfo objectForKey:@"businessData"];
        //        NSDictionary *_activifyData  = [_businessData objectForKey:@"get_gonglue"];
        //
        //
        //        if ([[_activifyDataa objectForKey:@"results"] isKindOfClass:[NSArray class]]) {
        //
        //            //            [self setAbroadArray:[_activifyData objectForKey:@"results"]];
        //            //            [self.tableView reloadData];
        //        }
        _dataArray =[NSMutableArray arrayWithArray:_resultArray];
        
        [_mainTableView.header endRefreshing];
        [_mainTableView reloadData];
        
    } failureBlock:^(SSLXResultRequest *failReq){
        
        NSDictionary *_failDict = [failReq.responseString objectFromJSONString];
        NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
        if (_errorMsg) {
            [_mainTableView.header endRefreshing];
            [MBProgressHUD showError:_errorMsg];
            
        }
        else {
            [MBProgressHUD showError:kMBProgressErrorTitle];
            [_mainTableView.header endRefreshing];
        }
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return [_dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        
        return 48;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"MessageTableViewCell";
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    NSDictionary *tempDic = [[_dataArray objectAtIndex:indexPath.row] safeDictionary];
    [cell setDataInfo:tempDic];
    [cell refreshUI];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [AVAnalytics event:@"messagePageList_click"];
    BaseWebViewController *baseWebView = [[BaseWebViewController alloc] init];
//    baseWebView.isTestWeb = YES;
    
    NSDictionary *tempDic = [[_dataArray objectAtIndex:indexPath.row] safeDictionary];
    NSString *urlString = [tempDic objectForKey:@"link"];
    baseWebView.isTestWeb = YES;
    baseWebView.webUrl = urlString;
    [[SliderViewController sharedSliderController].navigationController pushViewController:baseWebView animated:YES ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
