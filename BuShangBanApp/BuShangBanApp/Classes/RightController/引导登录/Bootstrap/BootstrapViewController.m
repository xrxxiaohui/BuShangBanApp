//
//  BootstrapViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#define saveInformationURL  @"https://api.leancloud.cn/1.1/users/%@"

#import "BootstrapViewController.h"
#import "BootstrapOneViewController.h"
#import "BootstrapTwoViewController.h"
#import "BootstrapThriViewController.h"
#import "ConstObject.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]

@interface BootstrapViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextBtnBottomConstraint;

@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (strong, nonatomic) IBOutlet UIView *promptLabelTopConstarin;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property(nonatomic,strong)UIPageViewController *pageViewController;
@property(nonatomic,strong)NSArray *viewControllerS;
@property(nonatomic,strong)NSArray *titleArray;

@end

@implementation BootstrapViewController
{
    NSInteger _currentIndex;
    NSMutableDictionary *_mutableDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self __initUI];
}

-(void)__initUI
{
    _mutableDic=[NSMutableDictionary dictionary];
    _currentIndex=0;
    self.viewControllerS=@[[[BootstrapOneViewController alloc]init],[[BootstrapTwoViewController alloc]init],[[BootstrapThriViewController alloc]init]];
    self.titleArray=@[@"请问您是？",@"上班的时候你是？",@"不上班你关注？"];
    
    self.labelTopConstraint.constant*=adapt.scaleHeight;
    self.nextBtnBottomConstraint.constant*=adapt.scaleHeight;
    
    self.promptLabel.font=[UIFont fontWithName:fontName size:16];
    self.promptLabel.textColor=nomalTextColor;
    self.promptLabel.text=self.titleArray[0];
    
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextBtn.titleLabel.font=[UIFont fontWithName:fontName size:16];

    self.pageViewController=[[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
     navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.view.frame=self.view.bounds;
    self.pageViewController.view.top=self.promptLabel.bottom;
    self.pageViewController.view.height=self.nextBtn.top-self.promptLabel.bottom;
    [self.pageViewController setViewControllers:@[_viewControllerS[_currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}
- (IBAction)back:(UIButton *)sender {
    _currentIndex--;
    if (_currentIndex>=0)
    {
        [self.pageViewController setViewControllers:@[_viewControllerS[_currentIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
        self.promptLabel.text=self.titleArray[_currentIndex];
    }else
    {
        _currentIndex=0;
    }
    if(_currentIndex!=[_viewControllerS count]-1)
        [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
}

- (IBAction)clickEvent:(UIButton *)sender {
    _currentIndex++;
    if (_currentIndex<[_viewControllerS count]){
        [self.pageViewController setViewControllers:@[_viewControllerS[_currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        self.promptLabel.text=self.titleArray[_currentIndex];
    }
    if(_currentIndex==[_viewControllerS count]-1)
        [self.nextBtn setTitle:@"进入" forState:UIControlStateNormal];
    if(_currentIndex==[_viewControllerS count])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"Loginned"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        NSDictionary *dic=@{
            @"sex":((BootstrapOneViewController *)_viewControllerS[0]).maleBtn.selected?@"男":@"女",
            @"city_name":SafeForString(((BootstrapOneViewController *)_viewControllerS[0]).placeTF.text),
            @"nickname":SafeForString(((BootstrapOneViewController *)_viewControllerS[0]).nickNameTF.text),
            @"profession":SafeForString(((BootstrapTwoViewController *)_viewControllerS[1]).selectedItem),
            @"interest":SafeForArray(((BootstrapThriViewController *)_viewControllerS[2]).selectedItems)
            };
        
        SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
        _urlParamsReq.requestMethod =  YTKRequestMethodPut;
        [_urlParamsReq setParamsDict:dic];
        NSString *finalObjectID = [[ConstObject instance] objectIDss];
        NSLog(@"========%@",finalObjectID);
        [_urlParamsReq setUrlString:[NSString stringWithFormat:saveInformationURL,finalObjectID]];
        
        [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successRequest){
            if([successRequest.responseJSONObject objectForKey:@"updatedAt"])
                [MBProgressHUD showSuccess:@"恭喜您注册成功！"];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:@"1" forKey:kLoginStatus];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"judgeLoginStatus" object:nil];
            
        } failureBlock:^(SSLXResultRequest *failRequest){
            NSString *_errorMsg = [[failRequest.responseString objectFromJSONString] objectForKey:@"error"];
            _errorMsg?[MBProgressHUD showError:_errorMsg]:[MBProgressHUD showError:kMBProgressErrorTitle];
        }];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
