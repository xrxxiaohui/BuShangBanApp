//
//  HomePageViewController.m
//  ShunShunLiuXue
//
//  Created by Peter Lee on 15/8/10.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "HomePageViewController.h"
#import "SliderViewController.h"

@interface HomePageViewController () {

}

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self customNavigationBarWithTitle:@"不上班"];
    [self customNavigationBarWithImage:@"logo"];
    UIButton *mentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mentionButton setFrame:CGRectMake(self.navView.width - 60, (self.navView.height - 40)/2, 60, 40)];
    [mentionButton setImage:[UIImage imageNamed:@"newSearch"] forState:UIControlStateNormal];
    [self customRightItemWithBtn:mentionButton];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
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
