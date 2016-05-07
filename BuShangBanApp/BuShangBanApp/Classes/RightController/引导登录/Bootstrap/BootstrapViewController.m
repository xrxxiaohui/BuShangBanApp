//
//  BootstrapViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "BootstrapViewController.h"
#import "BootstrapOneViewController.h"
#import "BootstrapTwoViewController.h"
#import "BootstrapThriViewController.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]

@interface BootstrapViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextBtnBottomConstraint;

@property (weak, nonatomic) IBOutlet UILabel *promptLabel;
@property (strong, nonatomic) IBOutlet UIView *promptLabelTopConstarin;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property(nonatomic,strong)UIPageViewController *pageViewController;
@property(nonatomic,strong)NSArray *viewControllerS;
@property(nonatomic,strong)NSArray *titleArray;

@end

@implementation BootstrapViewController
{
    NSInteger _currentIndex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self __initUI];
}

-(void)__initUI
{
    _currentIndex=0;
    self.viewControllerS=@[[[BootstrapOneViewController alloc]init],[[BootstrapTwoViewController alloc]init],[[BootstrapThriViewController alloc]init]];
    self.titleArray=@[@"请问您是？",@"上班的时候你是？",@"不上班你关注？"];
    
    self.labelTopConstraint.constant*=adapt.scaleHeight;
    self.nextBtnBottomConstraint.constant*=adapt.scaleHeight;
    
    self.promptLabel.font=[UIFont fontWithName:@"PingFang SC Light" size:16];
    self.promptLabel.textColor=nomalTextColor;
    self.promptLabel.text=self.titleArray[0];
    
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    self.nextBtn.titleLabel.font=[UIFont fontWithName:@"PingFang SC Light" size:16];

    self.pageViewController=[[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
     navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.view.frame=self.view.bounds;
    self.pageViewController.view.top=self.promptLabel.bottom;
    self.pageViewController.view.height=self.nextBtn.top-self.promptLabel.bottom;
    [self.pageViewController setViewControllers:@[_viewControllerS[_currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

- (IBAction)clickEvent:(UIButton *)sender {
    _currentIndex++;
    if (_currentIndex<[_viewControllerS count]){
        [self.pageViewController setViewControllers:@[_viewControllerS[_currentIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        self.promptLabel.text=self.titleArray[_currentIndex];
    }
    if(_currentIndex==[_viewControllerS count]-1)
        [self.nextBtn setTitle:@"进入" forState:UIControlStateNormal];
    if(_currentIndex==[_viewControllerS count])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
        [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedItem"];
        [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedItems"];
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}
@end
