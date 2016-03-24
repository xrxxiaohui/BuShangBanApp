

#import "AddressChoicePickerView.h"

@interface AddressChoicePickerView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHegithCons;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) AreaObject *locate;
@property(strong,nonatomic) NSDictionary *areaDic;
@property(strong,nonatomic) NSArray *province;
@property(strong,nonatomic) NSArray *city;
@property(strong,nonatomic) NSArray *district;
@property(strong,nonatomic) NSString *selectedProvince;

@end

@implementation AddressChoicePickerView

- (instancetype)init{
    
    if (self = [super init]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"AddressChoicePickerView" owner:nil options:nil]firstObject];
        self.frame = [UIScreen mainScreen].bounds;
        self.contentView.layer.cornerRadius=20;
        self.contentView.clipsToBounds=YES;
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"plist"];
        self.areaDic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        NSArray *components = [self.areaDic allKeys];
        NSArray *sortedArray = [components sortedArrayUsingComparator: ^(id obj1, id obj2) {
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *provinceTmp = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *tmp = [[self.areaDic objectForKey: index] allKeys];
            [provinceTmp addObject: [tmp objectAtIndex:0]];
        }
        
       self.province = [[NSArray alloc] initWithArray: provinceTmp];
        
        NSString *index = [sortedArray objectAtIndex:0];
        NSString *selected = [self.province objectAtIndex:0];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [[self.areaDic objectForKey:index]objectForKey:selected]];
        
        NSArray *cityArray = [dic allKeys];
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [cityArray objectAtIndex:0]]];
        self.city = [[NSArray alloc] initWithArray: [cityDic allKeys]];
        
        NSString *selectedCity = [self.city objectAtIndex: 0];
        self.district = [[NSArray alloc] initWithArray: [cityDic objectForKey: selectedCity]];
        
        _pickView.dataSource = self;
        _pickView.delegate = self;
        [_pickView selectRow: 0 inComponent: 0 animated: YES];
        self.selectedProvince = [self.province objectAtIndex: 0];
        
        [self customView];
    }
    return self;
}

- (void)customView{
    self.contentViewHegithCons.constant = 0;
    [self layoutIfNeeded];
}

#pragma mark - setter && getter

- (AreaObject *)locate{
    if (!_locate) {
        _locate = [[AreaObject alloc]init];
    }
    return _locate;
}

#pragma mark - action

//选择完成
- (IBAction)finishBtnPress:(UIButton *)sender {
    NSInteger provinceIndex = [self.pickView selectedRowInComponent: PROVINCE_COMPONENT];
    NSInteger cityIndex = [self.pickView selectedRowInComponent: CITY_COMPONENT];
    NSInteger districtIndex = [self.pickView selectedRowInComponent: DISTRICT_COMPONENT];
    
    NSString *provinceStr = [self.province objectAtIndex: provinceIndex];
    NSString *cityStr = [self.city objectAtIndex: cityIndex];
    NSString *districtStr = [self.district objectAtIndex:districtIndex];
    
    if ([provinceStr isEqualToString: cityStr] && [cityStr isEqualToString: districtStr]) {
        cityStr = @"";
        districtStr = @"";
    }
    else if ([cityStr isEqualToString: districtStr]) {
        districtStr = @"";
    }
    self.locate.provinceStr=provinceStr;
    self.locate.cityStr=cityStr;
    self.locate.districtStr=districtStr;
        if (self.block) {
            self.block(self,sender,self.locate);
        }
        [self hide];
}

//隐藏
- (IBAction)dissmissBtnPress:(UIButton *)sender {
    [self hide];
}

#pragma  mark - function

- (void)show
{
    UIWindow *win = [[UIApplication sharedApplication] keyWindow];
    [win addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentViewHegithCons.constant = 250;
        [self layoutIfNeeded];
    }];
}

- (void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.contentViewHegithCons.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [self.province count];
    }
    else if (component == CITY_COMPONENT) {
        return [self.city count];
    }
    else {
        return [self.district count];
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [self.province objectAtIndex: row];
    }
    else if (component == CITY_COMPONENT) {
        return [self.city objectAtIndex: row];
    }
    else {
        return [self.district objectAtIndex: row];
    }
}


#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 8.0;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        self.selectedProvince = [self.province objectAtIndex: row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [self.areaDic objectForKey: [NSString stringWithFormat:@"%ld", row]]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: self.selectedProvince]];
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++) {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        
        self.city = [[NSArray alloc] initWithArray: array];
        
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        self.district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [self.city objectAtIndex: 0]]];
        [self.pickView selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        [self.pickView selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [self.pickView reloadComponent: CITY_COMPONENT];
        [self.pickView reloadComponent: DISTRICT_COMPONENT];
        
    }
    else if (component == CITY_COMPONENT) {
        NSString *provinceIndex = [NSString stringWithFormat: @"%ld", [self.province indexOfObject: self.selectedProvince]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [self.areaDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: self.selectedProvince]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
        self.district = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
        [self.pickView selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        [self.pickView reloadComponent: DISTRICT_COMPONENT];
    }
    
}


@end
