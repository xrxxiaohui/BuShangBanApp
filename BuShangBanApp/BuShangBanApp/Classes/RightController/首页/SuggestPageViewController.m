//
//  SuggestPageViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/4/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SuggestPageViewController.h"
#import "JuXingView.h"
#import "DetailViewController.h"
#import "BaseWebViewController.h"
#import "SuggestListViewController.h"

@interface SuggestPageViewController (){

    UILabel *nameLabel;
    UIButton *_rightAvarButton;
    UILabel *_mainContentLabel;
    NSMutableArray *dataArray;
    UIImageView *mainImageView;
    
}

@end

@implementation SuggestPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self customNavigationBarWithTitle:@"推荐文章"];
//    [self dissmissLeftItem];
    [self.view setBackgroundColor:[UIColor clearColor]];
//    self.view.alpha = 0.8;
    [self createBackgroundView];
    [self customView];
    [self fetchData];
    dataArray = [NSMutableArray arrayWithCapacity:1];
    
}

-(void)fetchData {
    
    // 请求
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
    [_urlParamsReq setUrlString:@"https://leancloud.cn:443/1.1/classes/Post?limit=1&&order=-featured_at&&keys=-body&include=author"];
        
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successReq){
        
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        NSArray *_resultArray = [[_successInfo objectForKey:@"results"] safeArray];
        [dataArray addObjectsFromArray:_resultArray];
        [self reloadData];
        
    } failureBlock:^(SSLXResultRequest *failReq){
        
        NSDictionary *_failDict = [failReq.responseString objectFromJSONString];
        NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
        if (_errorMsg) {
            [MBProgressHUD showError:_errorMsg];
            
        }
        else {
            [MBProgressHUD showError:kMBProgressErrorTitle];
        }
    }];
}


-(void)customView{

    UIButton *listPageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [listPageButton setBackgroundImage:[UIImage imageNamed:@"listPageButton"] forState:UIControlStateNormal];
    [listPageButton setFrame:CGRectMake(125*kDefaultBiLi, (kScreenHeight-83), 22, 22)];

    [listPageButton addTarget:self action:@selector(toListPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:listPageButton];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setFrame:CGRectMake((kScreenWidth-125)*kDefaultBiLi, (kScreenHeight-83), 22, 22)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closePage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    
    
    _rightAvarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightAvarButton setFrame:CGRectMake(kScreenWidth-81*kDefaultBiLi, (292+90)*kScreenWidth/414, 28, 28)];
    [self.view addSubview:_rightAvarButton];
    [_rightAvarButton.layer setMasksToBounds:YES];
    _rightAvarButton.layer.cornerRadius = 14;
    [_rightAvarButton setBackgroundColor:[UIColor blackColor]];
    
    nameLabel = [[UILabel alloc] init];
    [nameLabel setFrame:CGRectMake(100, 390*kDefaultBiLi, kScreenWidth-97*kDefaultBiLi-100, 13)];
    [nameLabel setTextAlignment:NSTextAlignmentRight];
    [nameLabel setFont:[UIFont systemFontOfSize:12]];
//    [nameLabel setText:@"不上班"];
    [nameLabel setTextColor:COLOR(56, 56, 56)];
    [self.view addSubview:nameLabel];
    
    _mainContentLabel = [[UILabel alloc] init];
//    [_mainContentLabel setText:@"无论创业还是职场，总会有一时流行的东西，然后若有一天你也想站在顶端受人尊敬，那么最好的办法就是提高自己！"];
    [_mainContentLabel setFont:[UIFont systemFontOfSize:16]];
    [_mainContentLabel setFrame:CGRectMake(55*kDefaultBiLi, 450*kScreenWidth/414, 304*kDefaultBiLi, 125)];
    _mainContentLabel.numberOfLines = 0;
    [_mainContentLabel setTextColor:COLOR(56, 56, 56)];
    
    [self.view addSubview:_mainContentLabel];
    
}

-(void)reloadData{

    if(dataArray.count>0){
        NSDictionary *tempDataDic = [[dataArray objectAtIndex:0] safeDictionary];
        NSString *imageStr = [[tempDataDic objectForKey:@"feature_image"] safeString];
        [mainImageView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:nil];
        
        NSString *summaryStr = [[tempDataDic objectForKey:@"summary"] safeString];
        [_mainContentLabel setText:summaryStr];
        
        NSString *nameString = [[tempDataDic valueForKeyPath:@"author.username"] safeString];
        [nameLabel setText:nameString];
        NSString *avatarString = [[tempDataDic valueForKeyPath:@"author.avatar.url"] safeString];
        [_rightAvarButton sd_setImageWithURL:[NSURL URLWithString:avatarString] forState:UIControlStateNormal];
        
        
    }
}

-(void)toListPage{

    SuggestListViewController *suggestListViewController = [[SuggestListViewController alloc] init];
    [self presentViewController:suggestListViewController animated:YES completion:nil];

    
}

-(void)toWebDetailPage{

    if(dataArray.count>0){
        NSDictionary *tempDataDic = [[dataArray objectAtIndex:0] safeDictionary];
        NSString *linkStr = [tempDataDic objectForKey:@"link"];
        
         BaseWebViewController*baseWebView=[[BaseWebViewController alloc]init];
        baseWebView.isTestWeb = NO;
        baseWebView.webUrl = linkStr;
        [self presentViewController:baseWebView animated:YES completion:nil];
        
//        [[SliderViewController sharedSliderController].navigationController pushViewController:vc animated:YES];
    }
}

-(void)closePage{

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createBackgroundView{

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pictureName= [NSString stringWithFormat:@"screenShow.png"];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
    
    UIImage *localImage = [UIImage imageWithContentsOfFile:savedImagePath];
    UIImageView *backgroungImageView = [[UIImageView alloc] initWithImage:localImage];
    backgroungImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    UIVisualEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [backgroungImageView addSubview:effectview];
    [self.view addSubview:backgroungImageView];
    
    UIView *backgroundView = [[UIView alloc] init];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    [backgroundView.layer setMasksToBounds:YES];
    backgroundView.layer.cornerRadius = 10;
    [backgroundView setFrame:CGRectMake(37*kDefaultBiLi, 90*kDefaultBiLi, 340*kDefaultBiLi, 501*kDefaultBiLi)];
    backgroundView.userInteractionEnabled = YES;
    [self.view addSubview:backgroundView];
    
    UITapGestureRecognizer *fingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toWebDetailPage)];
    [backgroundView addGestureRecognizer:fingerTap];
    mainImageView = [[UIImageView alloc] init];
    mainImageView.userInteractionEnabled = YES;
//    [mainImageView setImage:[UIImage imageNamed:@"tree.jpeg"]];
    [mainImageView.layer setMasksToBounds:YES];
    mainImageView.layer.cornerRadius = 10;
         
    [mainImageView setFrame:CGRectMake(37*kDefaultBiLi, 90*kDefaultBiLi, 340*kDefaultBiLi,340*kDefaultBiLi)];
    UITapGestureRecognizer *fingerTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toWebDetailPage)];
    [mainImageView addGestureRecognizer: fingerTap1];

    [self.view addSubview:mainImageView];
    
    UIImageView *maskView = [[UIImageView alloc]init];
    [maskView setImage:[UIImage imageNamed:@"MaskR10"]];
    [maskView setFrame:CGRectMake(37*kDefaultBiLi, 340*kDefaultBiLi-10, 340*kDefaultBiLi, 90*kDefaultBiLi+10)];
    [self.view addSubview:maskView];

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
