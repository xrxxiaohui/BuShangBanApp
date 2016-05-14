//
//  BootstrapOneViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "BootstrapOneViewController.h"
#import "BuShangBanImagePicker.h"
#import "AddressChoicePickerView.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]

@interface BootstrapOneViewController ()<UITextFieldDelegate>

@end

@implementation BootstrapOneViewController
{
    UIButton *_tempBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self __crateUI];
}

-(void)__crateUI
{
    self.headBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self __btn:self.headBtn imageName:@"defaultHead" tag:1000];
    self.headBtn.frame=CGRectMake((kScreenWidth-80)/2, 38, 80, 80);
    
    self.photoBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self __btn:self.photoBtn imageName:@"photo" tag:1000];
    self.photoBtn.frame=CGRectMake(kScreenWidth/2+10, 0, 22, 16);
    self.photoBtn.bottom=self.headBtn.bottom-5;
    
    self.maleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self __btn:self.maleBtn imageName:@"man_nomal" tag:1001];
    [self.maleBtn setImage:[UIImage imageNamed:@"men_selected"] forState:UIControlStateSelected];
    self.maleBtn.frame=CGRectMake(kScreenWidth/2-44, self.headBtn.bottom+30, 44, 44);
    self.maleBtn.selected=YES;
    _tempBtn=self.maleBtn;
   
    self.femaleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self __btn:self.femaleBtn imageName:@"female_nomal" tag:1002];
    [self.femaleBtn setImage:[UIImage imageNamed:@"female_selected"] forState:UIControlStateSelected];
    self.femaleBtn.frame=CGRectMake(kScreenWidth/2, self.headBtn.bottom+30, 44, 44);
    
    self.nickNameTF=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 300*adapt.scaleWidth, 48)];
    [self __textFieldWithTextField:self.nickNameTF imageNamed:@"nickname" placeHolder:@"昵称"];
    self.nickNameTF.centerX=self.view.centerX;
    self.nickNameTF.top=198;
    
    self.placeTF=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, 300*adapt.scaleWidth, 48)];
    [self __textFieldWithTextField:self.placeTF imageNamed:@"loaction" placeHolder:@"地点"];
    self.placeTF.centerX=self.view.centerX;
    self.placeTF.delegate=self;
    self.placeTF.top=self.nickNameTF.bottom;
    
    [self __shapeLayerWithStartPoint:CGPointMake(self.nickNameTF.left, self.nickNameTF.bottom-8) endPoint:CGPointMake(self.nickNameTF.right, self.nickNameTF.bottom-8)];
    [self __shapeLayerWithStartPoint:CGPointMake(self.placeTF.left, self.placeTF.bottom-8) endPoint:CGPointMake(self.placeTF.right, self.placeTF.bottom-8)];
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.nickNameTF resignFirstResponder];
    
    AddressChoicePickerView *addressChoice=[[AddressChoicePickerView alloc]init];
    addressChoice.block=^(AddressChoicePickerView *view, UIButton *btn, AreaObject *locate){
        textField.text=[NSString stringWithFormat:@"%@",locate];
    };
    [addressChoice show];
    
    return NO;
}

-(void)__clickEvent:(UIButton *)btn
{
    if (btn.tag ==1000)
        [BuShangBanImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
            [_headBtn setImage:image forState:UIControlStateNormal];
            _headBtn.layer.cornerRadius=_headBtn.width/2;
            _headBtn.clipsToBounds=YES;
        }];
    else
        if (!btn.selected)
        {
            _tempBtn.selected=NO;
            btn.selected=YES;
            _tempBtn=btn;
        }
}

-(UIButton *)__btn:(UIButton *)btn imageName:(NSString *)imageName tag:(NSInteger)tag
{
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(__clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=tag;
    [self.view addSubview:btn];
    return btn;
}

-(UITextField *)__textFieldWithTextField:(UITextField *)textField imageNamed:(NSString *)imageNamed placeHolder:(NSString *)placeHolder
{
    UIImage *image=[UIImage imageNamed:imageNamed];
    UIImageView *imageView=[[UIImageView alloc]initWithImage:image];
    imageView.frame=CGRectMake(0, 0,image.size.width, image.size.height);
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, image.size.width+8, image.size.height)];
    [leftView addSubview:imageView];
    textField.leftView=leftView;
    textField.leftViewMode=UITextFieldViewModeAlways;
    textField.borderStyle=UITextBorderStyleNone;
    textField.font=[UIFont fontWithName:fontName size:14];
    textField.placeholder=placeHolder;
    [self.view addSubview:textField];
    return textField;
}

-(CAShapeLayer *)__shapeLayerWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.strokeColor=[UIColor colorWithHexString:@"383838"].CGColor;
    shapeLayer.lineCap   = kCALineCapRound;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    return shapeLayer;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
