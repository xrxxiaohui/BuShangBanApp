//
//  DataListViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "DataListViewController.h"

@interface DataListViewController ()

@end

@implementation DataListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.listTitle)
        [self customNavigationBarWithTitle:self.listTitle];
    else
        [self customNavigationBarWithTitle:@"发现"];

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
