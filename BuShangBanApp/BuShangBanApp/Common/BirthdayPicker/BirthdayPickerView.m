//
//  BirthdayPickerView.m
//  BuShangBanApp
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "BirthdayPickerView.h"

@interface BirthdayPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UIView *backgroundView;
@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,weak)UIPickerView *birthdaySelector;

@property(nonatomic,strong)NSMutableArray *yearArray;
@property(nonatomic,strong)NSMutableArray *monthArray;
@property(nonatomic,strong)NSMutableArray *dayArray;

@property(nonatomic,strong)UIButton *okBtn;

@property(nonatomic,strong)UIButton *cancelBtn;

@property(nonatomic,copy)NSString *yearText;
@property(nonatomic,copy)NSString *monthText;
@property(nonatomic,copy)NSString *dayText;
@end

@implementation BirthdayPickerView
{
    NSString* _currentYear;
    NSString* _currentMonth;
    NSString* _currentDay;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(0,0, kScreenWidth, kScreenHeight);
        self.backgroundColor=[UIColor clearColor];
        self.bgView=[[UIView alloc]initWithFrame:self.bounds];
        self.bgView.backgroundColor=[UIColor blackColor];
        self.bgView.alpha=0.4;
        [self addSubview:self.bgView];
        
        self.backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-240, kScreenWidth, 240)];
        self.backgroundView.backgroundColor=[UIColor whiteColor];
        self.backgroundView.layer.cornerRadius=10.f;
        [self addSubview:self.backgroundView];
        
        [self __dataSource];
        
        [self.occupationSelector selectRow:INT32_C(self.yearArray.count/2) inComponent:0 animated:YES];
        [self.occupationSelector selectRow:[_currentMonth integerValue] inComponent:1 animated:YES];
        [self.occupationSelector selectRow:[_currentDay integerValue] inComponent:2 animated:YES];
        
        _cancelBtn= [self __btnWithTitle:@"取 消" tag:1001 x:10];
        _okBtn = [self __btnWithTitle:@"确 定" tag:1000 x:kScreenWidth-44-10];
    }
    return self;
}

-(void)__dataSource
{
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy,MM,dd"];
    NSString *dateTime = [formatter stringFromDate:date];
    NSArray *dateArr=[dateTime componentsSeparatedByString:@","];
    _currentYear=dateArr[0];
    _currentMonth=dateArr[1];
    _currentDay=dateArr[2];
    
    self.yearArray=[NSMutableArray array];
    self.monthArray=[NSMutableArray array];
    self.dayArray=[NSMutableArray array];
    
    for (int i=1900; i<=[_currentYear integerValue]; i++)
        [self.yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    for (int i=1; i<=12; i++)
        [self.monthArray addObject:[NSString stringWithFormat:@"%d",i]];
    for (int i=1; i<=31; i++)
        [self.dayArray addObject:[NSString stringWithFormat:@"%d",i]];
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
        self.occupationSelector.top=200;
        _okBtn.height=0;
        _cancelBtn.height=0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)clickEvent:(UIButton *)sender
{
    if (sender.tag == 1000)
        _contentString=[NSString stringWithFormat:@"%@.%@.%@",_yearText,_monthText,_dayText];
    if (_birthdayPickerBlock)
        _birthdayPickerBlock(self,_contentString);
    [self hide];
}


-(UIButton *)__btnWithTitle:(NSString *)title tag:(NSInteger)tag x:(CGFloat )x
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
    [btn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:15];
    btn.layer.cornerRadius=4.f;
    btn.clipsToBounds=YES;
    btn.tag=tag;
    btn.frame=CGRectMake(x, 5, 44, 0);
    [self.backgroundView addSubview:btn];
    return btn;
}

-(UIPickerView *)occupationSelector
{
    if (!_birthdaySelector) {
        UIPickerView *pickView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 200)];
        pickView.delegate=self;
        pickView.dataSource=self;
        pickView.layer.cornerRadius=10.f;
        pickView.backgroundColor=[UIColor clearColor];
        _birthdaySelector=pickView;
        [self.backgroundView addSubview:_birthdaySelector];
    }
    return _birthdaySelector;
}

#pragma mark  ----  delegate  ----

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
        return self.yearArray.count;
    else if (component == 1)
        return self.monthArray.count;
    else
        return self.dayArray.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return self.width/3-5;
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
    if (component == 0)
        return self.yearArray[row];
    else if(component == 1)
        return self.monthArray[row];
    else
        return self.dayArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        _yearText = self.yearArray[row];
        if ([_yearText isEqualToString:_currentYear]) {
            [self.monthArray removeAllObjects];
            for (int i=1; i<=[_currentMonth integerValue]; i++)
                [self.monthArray addObject:[NSString stringWithFormat:@"%d",i]];
            [pickerView reloadComponent:1];
        }
    }
    else if(component == 1)
    {
        _monthText = self.monthArray[row];
        
        NSInteger day;
        if ([_monthText isEqualToString:_currentMonth]) {
            day=[_currentDay integerValue];
        }
        else
        {
            NSInteger month=[self.monthArray[row] integerValue];
            if (month ==1 || month == 3 || month == 5 || month == 7 || month == 8 || month== 10 || month ==12)
                day=31;
            else if(month ==4 || month == 6 || month == 9 || month == 11)
                day=30;
            else if (month%4 == 0 && month%100 == 0)
                day=29;
            else
                day=28;
        }
        [_dayArray removeAllObjects];
        for (int i=1; i<=day; i++)
            [_dayArray addObject:[NSString stringWithFormat:@"%d",i]];
        [pickerView reloadComponent:2];
    }
    else if(component == 2)
    {
        _dayText = self.dayArray[row];
    }
}

@end
