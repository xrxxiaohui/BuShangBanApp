//
//  SuggestListViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/5/8.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SuggestListViewController.h"
#import "MJRefresh.h"
#import "SuggestListCell.h"
#import "BaseWebViewController.h"

#define URL @"https://leancloud.cn:443/1.1/classes/Post?where=%7B%22featured_at%22%3A%7B%22%24exists%22%3Atrue%7D%7D&limit=100&skip=1&order=-featured_at&&keys=-body&include=author"

@interface SuggestListViewController ()<UITableViewDelegate,UITableViewDataSource>{

    NSMutableArray *_dataArray;
    UITableView *_mainTableView;

}

@end

@implementation SuggestListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBarWithTitle:@"每日首推"];
    self.view.backgroundColor=bgColor;
    
    
    
    [self initData];
    [self createTabelView];
    [self fetchData];
}

-(void)initData{
    _dataArray = [[NSMutableArray alloc] init];
}

-(void)createTabelView{
  
    UIImageView *lineImageView = [[UIImageView alloc] init];
    lineImageView.backgroundColor = COLOR(0xd9, 0xd9, 0xd9);
    [lineImageView setFrame:CGRectMake(0, 64, kScreenWidth, 1)];
    [self.view addSubview:lineImageView];
    
        
    CGFloat height = kScreenHeight-65 ;
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.view.width, height) style:UITableViewStylePlain];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _mainTableView.backgroundColor = COLOR(249, 249, 249);
    _mainTableView.backgroundColor = [UIColor clearColor];
//    _mainTableView.opaque = YES;
    _mainTableView.alpha = 0.98;
    //设置下拉刷新回调
    [_mainTableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(fetchData)];
    //    [_mainTableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(requestDataMore)];
    
    
    UIImageView *backgroungImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardBackground"]];
    backgroungImageView.frame = CGRectMake(0, 65, kScreenWidth, kScreenHeight);
    
    UIVisualEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [backgroungImageView addSubview:effectview];
    [self.view addSubview:backgroungImageView];
    [self.view addSubview:_mainTableView];

    
//    UIImageView *lineImageView1 = [[UIImageView alloc] init];
//    lineImageView1.backgroundColor = COLOR(0xd9, 0xd9, 0xd9);
//    [lineImageView1 setFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 1)];
//    [self.view addSubview:lineImageView1];
    
}

-(void)fetchData {
    
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
    [_urlParamsReq setUrlString:URL];
    
    NSDictionary *_tempParam = @{@"bid":@"888888"};
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successReq){
        
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        NSArray *_resultArray = [[_successInfo objectForKey:@"results"] safeArray];
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
   
        return  500*kDefaultBiLi+20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndentifier = @"SuggestListCell";
    SuggestListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[SuggestListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
        

    NSDictionary *tempDic = [[_dataArray objectAtIndex:indexPath.row] safeDictionary];
    [cell setDataInfo:tempDic];
    [cell refreshUI];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_dataArray.count>0){
        NSDictionary *tempDataDic = [[_dataArray objectAtIndex:0] safeDictionary];
        NSString *linkStr = [tempDataDic objectForKey:@"link"];
        
        BaseWebViewController*baseWebView=[[BaseWebViewController alloc]init];
        baseWebView.isTestWeb = NO;
        baseWebView.webUrl = linkStr;
        [self presentViewController:baseWebView animated:YES completion:nil];
        
        //        [[SliderViewController sharedSliderController].navigationController pushViewController:vc animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
