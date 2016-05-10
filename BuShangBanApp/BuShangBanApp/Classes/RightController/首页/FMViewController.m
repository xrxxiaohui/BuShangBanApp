//
//  FMViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/5/9.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "FMViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface FMViewController ()
{
    AVPlayer *_broadcastPlay;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation FMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _broadcastPlay=[[AVPlayer alloc]initWithURL:[NSURL URLWithString:@""]];
    _broadcastPlay.volume=3;
    
    [_broadcastPlay play];
}

-(void)__loadData
{
    
}
- (IBAction)clickBtn:(UIButton *)sender {
    if(sender.tag == 1000)
    {
        sender.selected=!sender.selected;
        sender.selected?[_broadcastPlay play]:[_broadcastPlay pause];
    }
    else
    {
        [_broadcastPlay pause];
        [UIView animateWithDuration:0.5 animations:^{
            self.view.height=0;
            self.view.alpha=0;
        }completion:^(BOOL finished) {
           [self.view removeFromSuperview]; 
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
