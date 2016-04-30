//
//  BootstrapThriViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "BootstrapThriViewController.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]

@interface BootstrapThriViewController ()
{
    UIButton *_personalInterestBtn;
    UIButton *_bigCompany;
    UIButton *_practicalBtn;
    UIButton *_skillGetBtn;
    UIButton *_productBtn;
    UIButton *_investBtn;
    UIButton *_famousSynopsisBtn;
    
    NSArray *_titleArray;
}
@end

@implementation BootstrapThriViewController
{
    CGFloat _top;
    CGFloat _left;
    CGFloat _widthSpace;
    CGFloat _heigntSpace;
    NSMutableArray *_selectedItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self __createUI];
    _selectedItems=[NSMutableArray arrayWithCapacity:7];
}

-(void)__createUI
{
    _widthSpace=(kScreenWidth-3*96*adapt.scaleWidth)/4;
    _heigntSpace=32 * adapt.scaleHeight;;
    _top=90 * adapt.scaleHeight;
    _left=_widthSpace;
    
    _personalInterestBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _bigCompany=[UIButton buttonWithType:UIButtonTypeCustom];
    _practicalBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _skillGetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _productBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _investBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _famousSynopsisBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    NSArray *imageNameArray=@[@"个人兴趣",@"大公司3",@"行业干货",@"技能get",@"新产品",@"投资创业",@"大牛语录"];
                _titleArray=@[@"个人兴趣",@"大公司",@"行业干货",@"技能get",@"新产品",@"投资创业",@"大牛语录"];
    NSArray *btnArray  =[NSArray arrayWithObjects:_personalInterestBtn,_bigCompany,_practicalBtn,_skillGetBtn,_productBtn,_investBtn,_famousSynopsisBtn, nil];
    
    for (int i=0; _titleArray.count>i; i++)
    {
        [self __btn:((UIButton *)btnArray[i]) title:_titleArray[i] image:[UIImage imageNamed:imageNameArray[i]] tag:1000+i];
        if ( i % 3 == 2 ) {
            _top = _heigntSpace + ((UIButton *)btnArray[i]).bottom;
            _left = _widthSpace;
        }
        else
            _left = _widthSpace + ((UIButton *)btnArray[i]).right;
    }
    _famousSynopsisBtn.centerX=self.view.centerX;
}

-(UIButton *)__btn:(UIButton *)btn title:(NSString *)title  image:(UIImage *)image tag:(NSInteger)tag {
    btn.frame=CGRectMake(_left, _top, 96*adapt.scaleWidth, 96*adapt.scaleWidth);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"383838"] forState:UIControlStateNormal];
    [btn setTitle:@"" forState:UIControlStateSelected];
    [btn setBackgroundImage:image forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"96x96"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(__clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag=tag;
    [self.view addSubview:btn];
    return btn;
}

- (void)__clickEvent:(UIButton *)sender {
    NSInteger index=sender.tag-1000;
    if (sender.selected) {
        if ([_selectedItems containsObject:_titleArray[index]])
            [ _selectedItems removeObject:_titleArray[index]];
    }
    else
    {
        if (![_selectedItems containsObject:_titleArray[index]])
            [ _selectedItems addObject:_titleArray[index]];
    }
    sender.selected=!sender.selected;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
