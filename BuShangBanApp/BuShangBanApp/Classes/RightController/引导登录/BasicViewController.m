//
//  BasicViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "BasicViewController.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]

@interface BasicViewController ()

@end

@implementation BasicViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=bgColor;
    
    _closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    _closeBtn.titleLabel.font=[UIFont fontWithName:@"PingFang TC-Light" size:14];
    _closeBtn.frame=CGRectMake(16, 33, 22, 22);
    _closeBtn.tag=1000;
    [self.view addSubview:_closeBtn];
    
    _contentView=[[UIView alloc]initWithFrame:self.view.bounds];
    _contentView.backgroundColor=bgColor;
    _contentView.top=134 *adapt.scaleHeight;
    [self.view addSubview:_contentView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}

-(UITextField *)textFieldWithPlaceHolder:(NSString *)placeholder imageNamed:(NSString *)imageNamed
{
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 300, 48)];
    textField.centerX=self.view.centerX;
    textField.placeholder=placeholder;
    textField.font=[UIFont fontWithName:@"PingFang TC-Light" size:14];
    textField.leftView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageNamed]];
    textField.leftViewMode=UITextFieldViewModeAlways;
    textField.borderStyle=UITextBorderStyleNone;
    textField.font=[UIFont fontWithName:fontName size:14];
    [_contentView addSubview:textField];
    return textField;
}

-(UIButton *)buttonWithImageName:(NSString *)imageName  tag:(NSInteger)tag frame:(CGRect)frame title:(NSString *)title
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=[UIFont fontWithName:@"PingFang TC-Light" size:14];
    btn.frame=frame;
    btn.tag=tag;
    return btn;
}

-(CAShapeLayer *)shapeLayerWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.strokeColor=[UIColor colorWithHexString:@"383838"].CGColor;
    shapeLayer.lineCap   = kCALineCapRound;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    shapeLayer.path = path.CGPath;
    [_contentView.layer addSublayer:shapeLayer];
    return shapeLayer;
}

-(void)showKeyBoard:(NSNotification *)noti
{
}

-(void)hideKeyBoard:(NSNotification *)noti
{
    
}


-(void)clickEvent:(UIButton *)sender
{
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
