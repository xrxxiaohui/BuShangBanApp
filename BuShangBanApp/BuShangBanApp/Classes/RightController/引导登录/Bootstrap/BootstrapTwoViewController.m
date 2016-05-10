//
//  BootstrapTwoViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "BootstrapTwoViewController.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]

@interface BootstrapTwoViewController ()
{
    UIButton *_technologyBtn;
    UIButton *_productBtn;
    UIButton *_designBtn;
    UIButton *_operationBtn;
    UIButton *_administrationBtn;
    UIButton *_marketBtn;
    UIButton *_contentBtn;
    UIButton *_investBtn;
}

@end

@implementation BootstrapTwoViewController
{
    UIButton *_tempButton;
    CGFloat _top;
    CGFloat _left;
    CGFloat _widthSpace;
    CGFloat _heigntSpace;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self __createUI];
}

-(void)__createUI
{
    _widthSpace=(kScreenWidth-3*72*adapt.scaleWidth)/4;
    _heigntSpace=56 * adapt.scaleHeight;;
    _top=90 * adapt.scaleHeight;
    _left=_widthSpace;
    
    _technologyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _productBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _designBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _operationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _administrationBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _marketBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _contentBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _investBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    NSArray *imageNameArray=@[@"技术2",@"产品2",@"设计2",@"运营2",@"行政2",@"市场2",@"创作2",@"投资2"];
    NSArray *titleArray=@[@"技术",@"产品",@"设计",@"运营",@"行政",@"市场",@"创作",@"投资"];
    NSArray *btnArray  =[NSArray arrayWithObjects:_technologyBtn,_productBtn,_designBtn,_operationBtn,_administrationBtn,_marketBtn,_contentBtn,_investBtn, nil];
    
    for (int i=0; titleArray.count>i; i++)
    {
        [self __btn:((UIButton *)btnArray[i]) title:titleArray[i] image:[UIImage imageNamed:imageNameArray[i]] tag:1000+i];
        if ( i % 3 == 2 ) {
            _top = _heigntSpace + ((UIButton *)btnArray[i]).bottom;
            _left = _widthSpace;
        }
        else
            _left = _widthSpace + ((UIButton *)btnArray[i]).right;
    }
    CGFloat margin=(kScreenWidth-2*72*adapt.scaleWidth)/3;
    _contentBtn.left=margin;
    _investBtn.left=_contentBtn.right+margin;
}

-(UIButton *)__btn:(UIButton *)btn title:(NSString *)title  image:(UIImage *)image tag:(NSInteger)tag {
    btn.frame=CGRectMake(_left, _top, 72 *adapt.scaleWidth, 72 *adapt.scaleWidth);
    [btn setTitleColor:[UIColor colorWithHexString:@"383838"] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:@"" forState:UIControlStateSelected];
    [btn setBackgroundImage:image forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"72x72"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(__clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=tag;
    [self.view addSubview:btn];
    return btn;
}

- (void)__clickEvent:(UIButton *)sender {
    if (!sender.selected)
    {
        if (_tempButton.selected)
            _tempButton.selected=!_tempButton.selected;
        sender.selected=!sender.selected;
        _tempButton=sender;
        [[NSUserDefaults standardUserDefaults] setObject:sender.titleLabel.text forKey:@"selectedItem"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    else
        sender.selected=!sender.selected;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end
