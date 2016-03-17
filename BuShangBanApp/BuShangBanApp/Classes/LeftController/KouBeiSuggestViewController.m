//
//  KouBeiSuggestViewController.m
//  ShunShunLiuXue
//
//  Created by Peter Lee on 15/10/21.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "KouBeiSuggestViewController.h"

@interface KouBeiSuggestViewController ()

@end

@implementation KouBeiSuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showHeaderView];
}


-(void)showHeaderView{
    
    [self createNavWithTitle:@"口碑推荐" createMenuItem:^UIView *(int nIndex)
     {
         if (nIndex == 2)
         {
             //左侧返回
             UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             [btn setFrame:CGRectMake(7.5f, (self.navView.height - 40)/2, 40, 40)];
             [btn setImage:[UIImage imageNamed:@"returnPic"] forState:UIControlStateNormal];
             [btn setImage:[UIImage imageNamed:@"returnLighted"] forState:UIControlStateHighlighted];
             [btn addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
             //             btn.showsTouchWhenHighlighted = YES;
             [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
             
             return btn;
         }
         return nil;
     }];
}

-(void)returnBack{

    [self.navigationController popViewControllerAnimated:YES];
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
