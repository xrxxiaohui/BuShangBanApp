//
//  MessageDetailViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/5/12.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController (){

}

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customNavigationBarWithTitle:self.titles];
    self.view.backgroundColor=bgColor;

    
}

-(void)createMainView{

    UIImageView *bubbleView = [[UIImageView alloc] init];
    [bubbleView setImage:[UIImage imageNamed:@""]];
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
