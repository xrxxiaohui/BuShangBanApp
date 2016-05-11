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
{
    CGFloat _bottom;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _bottom=0;
    self.view.backgroundColor=bgColor;
    
    _closeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    _closeBtn.frame=CGRectMake(6, 20, 44,44);
    _closeBtn.tag=1000;
    [self.view addSubview:_closeBtn];
    
    _contentView=[[UIView alloc]initWithFrame:self.view.bounds];
    _contentView.backgroundColor=bgColor;
    _contentView.top=150 *adapt.scaleHeight;
    [self.view addSubview:_contentView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}

-(UITextField *)textFieldWithPlaceHolder:(NSString *)placeholder imageNamed:(NSString *)imageNamed
{
    UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 300 * adapt.scaleWidth, 48)];
    textField.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    textField.centerX=self.view.centerX;
    textField.placeholder=placeholder;
    textField.font=[UIFont fontWithName:fontName size:14];
    UIImage *image=[UIImage imageNamed:imageNamed];
    UIImageView *imageView=[[UIImageView alloc]initWithImage:image];
    imageView.frame=CGRectMake(0, 0,image.size.width, image.size.height);
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, image.size.width+8, image.size.height)];
    [leftView addSubview:imageView];
    textField.leftView=leftView;
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
    btn.backgroundColor=[UIColor whiteColor];
    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=[UIFont fontWithName:fontName size:14];
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
    CGRect frame=[[noti userInfo][UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    if (frame.origin.y<_contentView.bottom) {
        _bottom=_contentView.bottom;
        _contentView.bottom=frame.origin.y;
    }
}

-(void)hideKeyBoard:(NSNotification *)noti
{
    if (_bottom != 0)
        _contentView.bottom=_bottom;
}


-(void)clickEvent:(UIButton *)sender
{
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
