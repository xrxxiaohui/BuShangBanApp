//
//  OccupationSelectorView.m
//  OccupationSelectot
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "OccupationSelectorView.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface OccupationSelectorView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIPickerView *occupationSelector;
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
            self.frame=CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight);
            _dataSource=@[@"创  作",@"运  营",@"产  品",@"技  术",@"设  计",@"投  资",@"商务市场销售",@"行  政"];
            self.backgroundColor=[UIColor greenColor];
            [self.occupationSelector selectRow:INT32_C(self.dataSource.count/2) inComponent:0 animated:YES];
            _okBtn = [self btnWithTitle:@"取 消" tag:1001 x:10];
            _cancelBtn= [self btnWithTitle:@"确 定" tag:1000 x:kScreenWidth-44-10];
        }
    }
    return self;
}

- (void)show {
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    [win addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect=self.occupationSelector.frame;
        rect.origin.y=kScreenHeight-200;
        self.occupationSelector.frame=rect;
        
        CGRect okBtnRect=_okBtn.frame;
        okBtnRect.size.height=30;
        _okBtn.frame=okBtnRect;
        
        CGRect cancelBtnRect=_cancelBtn.frame;
        cancelBtnRect.size.height=30;
        _cancelBtn.frame=cancelBtnRect;
        [self layoutIfNeeded];
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        CGRect rect=self.occupationSelector.frame;
        rect.origin.y=kScreenHeight;
        self.occupationSelector.frame=rect;
        
        CGRect okBtnRect=_okBtn.frame;
        okBtnRect.size.height=0;
        _okBtn.frame=okBtnRect;
        
        CGRect cancelBtnRect=_cancelBtn.frame;
        cancelBtnRect.size.height=0;
        _cancelBtn.frame=cancelBtnRect;
        
        [self layoutIfNeeded];
    } completion:^(BOOL finished) { [self removeFromSuperview]; }];
}

-(void)clickEvent:(UIButton *)sender
{
    if (sender.tag == 1000)
        if (_occupationSelectorBlock)
            _occupationSelectorBlock(self,_contentText);
    [self hide];
}


-(UIButton *)btnWithTitle:(NSString *)title tag:(NSInteger)tag x:(CGFloat )x
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    btn.backgroundColor=[UIColor greenColor];
    btn.layer.cornerRadius=4.f;
    btn.clipsToBounds=YES;
    btn.tag=tag;
    btn.frame=CGRectMake(x, kScreenHeight-200 +10, 44, 0);
    [self addSubview:btn];
    return btn;
}

-(UIPickerView *)occupationSelector
{
    if (!_occupationSelector) {
        _occupationSelector=[[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 200)];
        _occupationSelector.delegate=self;
        _occupationSelector.dataSource=self;
        _occupationSelector.layer.cornerRadius=10.f;
        _occupationSelector.backgroundColor=[UIColor grayColor];
        _occupationSelector.alpha=0.8;
        [self addSubview:_occupationSelector];
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
        //        pickerLabel.font=[UIFont fontWithName:@"Ping Fang" size:20];
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
