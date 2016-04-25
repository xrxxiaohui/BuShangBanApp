//
//  OtherViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "OtherViewController.h"

@interface OtherViewController()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *commandTableView;
@property(nonatomic,weak)UIView *maskView;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self __createUI];
}

-(void)settingBtn:(UIButton *)btn
{
    [self __showCommandTableView];
}

-(UIButton *)__btnWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(__btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=[UIFont fontWithName:fontName size:16.f];
    btn.backgroundColor=[UIColor whiteColor];
    btn.tag=tag;
    [self.view addSubview:btn];
    return btn;
}

-(void)__showCommandTableView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.maskView.alpha=0.4f;
        self.commandTableView.top=kScreenHeight-49*3;
    }];
}

-(void)__hideCommandtableView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.maskView.alpha=0.4f;
        self.commandTableView.top=kScreenHeight;
    }completion:^(BOOL finished) {
        [_commandTableView removeFromSuperview];
        [_maskView removeFromSuperview];
    }];
}

-(void)__btnEvent:(UIButton *)sender
{
    if (sender.tag == 1000) {
        sender.selected=!sender.selected;
    }else if(sender.tag == 1001)
    {
        NSLog(@"1001");
    }
}

-(void)__createUI
{
    UIButton *focusBtn=[self __btnWithTitle:@"+关注" tag:1000];
    focusBtn.frame=CGRectMake(0, kScreenHeight-49, kScreenWidth/2, 49);
    [focusBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [focusBtn setTitleColor:[UIColor colorWithHexString:@"f5a623"] forState:UIControlStateNormal];
    [focusBtn setTitleColor:[UIColor colorWithHexString:@"373737"] forState:UIControlStateSelected];
    
    UIButton *chatBtn=[self __btnWithTitle:@"私聊" tag:1001];
    [chatBtn setTitleColor:[UIColor colorWithHexString:@"373737"] forState:UIControlStateNormal];
    chatBtn.frame=CGRectMake(focusBtn.right, kScreenHeight-49, kScreenWidth/2, 49);
    
    [self __shapeLayerWithStartPoint:CGPointMake(0, kScreenHeight-49) endPoint:CGPointMake(kScreenWidth, kScreenHeight-49)];
    [self __shapeLayerWithStartPoint:CGPointMake(self.view.width/2,  kScreenHeight-45) endPoint:CGPointMake(self.view.width/2,kScreenHeight-4 )];
    [self __shapeLayerWithStartPoint:CGPointMake(0, kScreenHeight-1) endPoint:CGPointMake(kScreenWidth, kScreenHeight-1)];
}


- (CAShapeLayer *)__shapeLayerWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.strokeColor=[UIColor colorWithHexString:@"d9d9d9"].CGColor;
    shapeLayer.lineCap   = kCALineCapRound;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    return shapeLayer;
}

-(UITableView *)commandTableView
{
    if (!_commandTableView) {
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 49*3) style:UITableViewStyleGrouped];
        tableView.contentSize=CGSizeMake(self.view.width, 49*3);
        tableView.delegate=self;
        tableView.dataSource=self;
        [self.view addSubview:tableView];
        _commandTableView=tableView;
    }
    return _commandTableView;
}

-(UIView *)maskView
{
    if (!_maskView) {
        UIView *view=[[UIView alloc]initWithFrame:self.view.bounds];
        view.backgroundColor=[UIColor grayColor];
        view.alpha=1;
        _maskView=view;
        [self.view addSubview:_maskView];
    }
    return _maskView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    label.font=[UIFont fontWithName:fontName size:16];
    label.textColor=[UIColor colorWithHexString:@"616161"];
    label.textAlignment=NSTextAlignmentCenter;
    [cell addSubview:label];
    switch (indexPath.row) {
        case 0:
            label.text=@"分 享";
            break;
        case 1:
            label.text=@"屏 蔽";
            break;
        case 2:
            label.text=@"取 消";
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            [UIView animateWithDuration:0.5 animations:^{
                self.commandTableView.height=kScreenHeight;
            }completion:^(BOOL finished) {
                [self.commandTableView removeFromSuperview];
            }];
            break;
    }
    [self __hideCommandtableView];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
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
