//
//  OccupationSelectorView.m
//  OccupationSelectot
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "OccupationSelectorView.h"

@interface OccupationSelectorView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,weak)UIPickerView *occupationSelector;

@property(nonatomic,strong)NSArray *dataSource;

@property(nonatomic,strong)UIButton *okBtn;
@property(nonatomic,strong)UIButton *cancelBtn;

@property(nonatomic,copy)NSString *contentText;
@end

@implementation OccupationSelectorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (self) {
            self.frame=CGRectMake(0,0, kScreenWidth, kScreenHeight);
            self.backgroundColor=[UIColor clearColor];
            
            self.bgView=[[UIView alloc]initWithFrame:self.bounds];
            self.bgView.backgroundColor=[UIColor blackColor];
            self.bgView.alpha=0.4;
            [self addSubview:self.bgView];
            
            self.backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-250, kScreenWidth, 250)];
            self.backgroundView.backgroundColor=[UIColor whiteColor];
            self.backgroundView.layer.cornerRadius=10.f;
            [self addSubview:self.backgroundView];
            
            _dataSource=@[@"创作",@"运营",@"产品",@"技术",@"设计",@"投资",@"市场",@"行政"];
            [self.occupationSelector selectRow:INT32_C(_dataSource.count/2) inComponent:0 animated:YES];
            _contentText=self.dataSource[INT32_C(_dataSource.count/2)];
            _cancelBtn= [self btnWithTitle:@"取 消" tag:1001 x:10];
            _okBtn = [self btnWithTitle:@"确 定" tag:1000 x:kScreenWidth-44-10];
        }
    }
    return self;
}

- (void)show {
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    [win addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.occupationSelector.top=40;
        _okBtn.height=30;
        _cancelBtn.height=30;
        [self layoutIfNeeded];
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.occupationSelector.top=240;
        _okBtn.height=0;
        _cancelBtn.height=0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) { [self removeFromSuperview]; }];
}

-(void)clickEvent:(UIButton *)sender
{
    if (sender.tag == 1000)
        _contentString=_contentText;
    if (_occupationSelectorBlock)
        _occupationSelectorBlock(self,_contentString);
    [self hide];
}


-(UIButton *)btnWithTitle:(NSString *)title tag:(NSInteger)tag x:(CGFloat )x
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    btn.layer.cornerRadius=4.f;
    btn.clipsToBounds=YES;
    btn.tag=tag;
    btn.frame=CGRectMake(x,5, 44, 0);
    [self.backgroundView addSubview:btn];
    return btn;
}

-(UIPickerView *)occupationSelector
{
    if (!_occupationSelector) {
        UIPickerView *pickView=[[UIPickerView alloc]initWithFrame:CGRectMake(0,200, kScreenWidth, 200)];
        pickView.delegate=self;
        pickView.dataSource=self;
        pickView.layer.cornerRadius=10.f;
        pickView.backgroundColor=[UIColor whiteColor];
        _occupationSelector=pickView;
        [self.backgroundView addSubview:_occupationSelector];
    }
    return _occupationSelector;
}

#pragma mark  ----  delegate  ----

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataSource.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 150.f;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *) view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.font=[UIFont fontWithName:fontName size:20];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _dataSource[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _contentText=_dataSource[row];
}
@end
