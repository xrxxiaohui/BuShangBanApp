//
//  SuggestPageViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/4/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SuggestPageViewController.h"
#import "JuXingView.h"

@interface SuggestPageViewController ()

@end

@implementation SuggestPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self customNavigationBarWithTitle:@"推荐文章"];
//    [self dissmissLeftItem];
    [self.view setBackgroundColor:COLOR(206, 205, 205)];
    [self createBackgroundView];
    [self customView];
//    [self createWhiteView];
//    [self.view setNeedsDisplay];
    
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
}

-(void)toListPage{

    
}

-(void)closePage{

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)createBackgroundView{

    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:effectview];
    
    UIView *backgroundView = [[UIView alloc] init];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    [backgroundView.layer setMasksToBounds:YES];
    backgroundView.layer.cornerRadius = 10;
    [backgroundView setFrame:CGRectMake(37*kDefaultBiLi, 90*kDefaultBiLi, 340*kDefaultBiLi, 501*kDefaultBiLi)];
    [self.view addSubview:backgroundView];
    
    UIImageView *image = [[UIImageView alloc] init];
    [image setImage:[UIImage imageNamed:@"tree.jpeg"]];
    [image.layer setMasksToBounds:YES];
    image.layer.cornerRadius = 10;
    [image setFrame:CGRectMake(37*kDefaultBiLi, 90*kDefaultBiLi, 340*kDefaultBiLi,340*kDefaultBiLi)];
    [self.view addSubview:image];
    
    UIImageView *maskView = [[UIImageView alloc]init];
    [maskView setImage:[UIImage imageNamed:@"Mask"]];
    [maskView setFrame:CGRectMake(37*kDefaultBiLi, 340*kDefaultBiLi, 340*kDefaultBiLi, 90*kDefaultBiLi)];
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
