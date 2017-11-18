//
//  MYPickerDateView.m
//  MYCustomDatePicker
//
//  Created by mengdy on 17/11/10.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "MYPickerDateView.h"


@interface MYPickerDateView()<UIPickerViewDataSource, UIPickerViewDelegate>
/** 选择的年 */
@property (nonatomic, assign)NSInteger selectYear;
/** 选择的月 */
@property (nonatomic, assign)NSInteger selectMonth;
/** 选择的日 */
@property (nonatomic, assign)NSInteger selectDay;

/** 现在的年月日 */
@property (nonatomic, assign)NSInteger currentYear;
@property (nonatomic, assign)NSInteger currentMonth;
@property (nonatomic, assign)NSInteger currentDay;

/** 默认的年月日 **/
@property (nonatomic, assign)NSInteger defaultYear;
@property (nonatomic, assign)NSInteger defaultMonth;
@property (nonatomic, assign)NSInteger defaultDay;

@property (nonatomic, assign)NSInteger minShowYear;
//获取展示的总年数
@property (nonatomic, assign)NSInteger yearSum;

@property (nonatomic,strong)NSString   *maxMouth;
@property (nonatomic,strong)NSString   *maxDay;


/** 年，月，日row上面的横线 */
@property (nonatomic,strong)UIView *upYLineView;
@property (nonatomic,strong)UIView *upMLineView;
@property (nonatomic,strong)UIView *upDLineView;

/** 年，月，日对应row下面的横线 */
@property (nonatomic,strong)UIView *downYLineView;
@property (nonatomic,strong)UIView *downMLineView;
@property (nonatomic,strong)UIView *downDLineView;



@end
@implementation MYPickerDateView

- (void)initPickView
{
    [super initPickView];
    _minShowYear = 1980;//最小年份
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 指定获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
    
    _yearSum = comp.year-_minShowYear+1;
    _currentYear=comp.year;
    _currentMonth=comp.month;
    _currentDay=comp.day;
    
    
    _selectYear  = comp.year;
    _selectMonth = comp.month;
    _selectDay   = comp.day;
    
    _defaultYear = comp.year;
    _defaultMonth = comp.month;
    _defaultDay=comp.day;
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    
}
//设置默认显示的数值
-(void)setDefaultTSelectYear:(NSInteger)defaultSelectYear defaultSelectMonth:(NSInteger)defaultSelectMonth defaultSelectDay:(NSInteger)defaultSelectDay{
    
    if (defaultSelectYear!=0) {
        _defaultYear=defaultSelectYear;
    }
    
    if (defaultSelectMonth!=0) {
        _defaultMonth = defaultSelectMonth;
    }
    
    if (defaultSelectDay!=0) {
        _defaultDay=defaultSelectDay;
    }
    
    
    if (defaultSelectYear==-1) {
        _defaultYear=_currentYear+1;
        _defaultMonth=1;
        _defaultDay=1;
    }
    
    NSLog(@"dddddd %ld",_defaultDay);
    [self.pickerView selectRow:(_defaultYear - _minShowYear) inComponent:0 animated:NO];
    //刷新第一列
    [self.pickerView reloadComponent:1];
    [self.pickerView selectRow:(_defaultMonth - 1) inComponent:1 animated:NO];
    if (_isShowDay==YES) {
        [self.pickerView reloadComponent:2];
        [self.pickerView selectRow:(_defaultDay -1)inComponent:2 animated:NO];
    }
    
    [self refreshPickViewData];
    
}
-(void)setIsAddYetSelect:(BOOL)isAddYetSelect{
    _isAddYetSelect = isAddYetSelect;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //判断是否要显示日，如果显示则返回3列，反之返回2列
    if (_isShowDay==YES) {
        return 3;
    }else{
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        if (_isAddYetSelect==YES) {
            //显示至今选项的话，需要比总共要显示的年份多返回一行
            return self.yearSum+1;
            
        }else{
            
            return self.yearSum;
        }
    }else if(component == 1) {
        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.minShowYear;
        if (yearSelected==_currentYear+1) {
            //至今选项的时候月份信息不返回
            return 0;
        }else if (yearSelected == _currentYear){
        //  选择今年
            return _currentMonth;
        }else{
            
            return 12;
        }
    }else {
        NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.minShowYear;
        if (yearSelected==_currentYear+1) {
            //至今选项的时候日信息不返回
            return 0;
        }else if (yearSelected == _currentYear){
        
            return _currentDay;
        }else{
            NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.minShowYear;
            NSInteger monthSelected = [pickerView selectedRowInComponent:1] + 1;
            return  [self getDaysWithYear:yearSelected month:monthSelected];
        }
    }
    
    
}
//根据年、月判断日期天数
- (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month
{
    switch (month) {
        case 1:
            return 31;
            break;
        case 2:
            if (year%400==0 || (year%100!=0 && year%4 == 0)) {
                return 29;
            }else{
                return 28;
            }
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    //每一行的高度
    return 36;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    NSInteger selectYear;
    NSInteger selectMonth;
    
    switch (component) {
        case 0:
            
            [pickerView reloadComponent:1];
            if (_isAddYetSelect==YES) {
                selectYear = row+_minShowYear+1;
            }else{
                selectYear = row+_minShowYear;
            }
            if (_isShowDay==YES) {
                [pickerView reloadComponent:2];
            }
            break;
        case 1:
            selectMonth = row+1;
            if (_isShowDay==YES) {
                [pickerView reloadComponent:2];
            }
        default:
            break;
    }
    
    [self refreshPickViewData];
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    NSString *text;
    if (component == 0) {
        
        if (_isAddYetSelect==YES) {
            
            if (row+_minShowYear==_currentYear+1) {
                text=@"至今";
                
            }else{
                
                text = [NSString stringWithFormat:@"%zd", row + _minShowYear];
            }
            
        }else{
            
            text =  [NSString stringWithFormat:@"%zd", row + _minShowYear];
        }
        
    }else if (component == 1){
        if (_isAddYetSelect==YES) {
            NSInteger yearSelected = [pickerView selectedRowInComponent:0] + self.minShowYear;
            if (yearSelected==_currentYear+1) {
                text =  [NSString stringWithFormat:@""];
            }else{
                text =  [self rowIslLowTen:row];
                
            }
        }else{
            text = [self rowIslLowTen:row];
        }
        
    }else{
        text =  [self rowIslLowTen:row];
    }
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:16];
    label.text = text;
    
    [self clearSpearatorLine];
    
    
    return label;
}

//判断Mouth和day是不是双位数
-(NSString *)rowIslLowTen:(NSInteger )row{
    
    NSString *value = nil;
    if (row < 9) {
        
        value = [NSString stringWithFormat:@"0%zd", row + 1];
    }else{
        
        value = [NSString stringWithFormat:@"%zd", row + 1];
        
    }
    return value;
}




/**
 *  清楚datePicker的分割线
 */
- (void)clearSpearatorLine{
    
    UIView *upView  =  (UIView *)[self.pickerView.subviews objectAtIndex:1];
    UIView *downView = (UIView *)[self.pickerView.subviews objectAtIndex:2];
    
    upView.backgroundColor = [UIColor clearColor];
    downView.backgroundColor = [UIColor clearColor];
    
    [upView addSubview:self.upYLineView];
    [upView addSubview:self.upMLineView];
    [upView addSubview:self.upDLineView];
    [downView addSubview:self.downYLineView];
    [downView addSubview:self.downMLineView];
    [downView addSubview:self.downDLineView];
    
    
}


-(UIView *)upYLineView{
    
    if (!_upYLineView) {
        
        _upYLineView = [[UIView alloc]initWithFrame:CGRectMake(spaceWidth, 0, lineWidth, 1)];
        _upYLineView.backgroundColor = [UIColor colorWithRed:221/255.f green:221/255.f blue:221/255.f alpha:1.0];
    }
    return _upYLineView;
}

-(UIView *)upMLineView{
    
    if (!_upMLineView) {
        
        _upMLineView = [[UIView alloc]initWithFrame:CGRectMake(3*spaceWidth+lineWidth, 0, lineWidth, 1)];
        _upMLineView.backgroundColor = [UIColor colorWithRed:221/255.f green:221/255.f blue:221/255.f alpha:1.0];
    }
    return _upMLineView;
}

-(UIView *)upDLineView{
    
    if (!_upDLineView) {
        
        _upDLineView = [[UIView alloc]initWithFrame:CGRectMake(5*spaceWidth+2*lineWidth, 0, lineWidth, 1)];
        _upDLineView.backgroundColor = [UIColor colorWithRed:221/255.f green:221/255.f blue:221/255.f alpha:1.0];
    }
    return _upDLineView;
}

-(UIView *)downYLineView{
    
    if (!_downYLineView) {
        
        _downYLineView = [[UIView alloc]initWithFrame:CGRectMake(spaceWidth, 0, lineWidth, 1)];
        _downYLineView.backgroundColor = [UIColor colorWithRed:221/255.f green:221/255.f blue:221/255.f alpha:1.0];
    }
    return _downYLineView;
}

-(UIView *)downMLineView{
    
    if (!_downMLineView) {
        
        _downMLineView = [[UIView alloc]initWithFrame:CGRectMake(3*spaceWidth+lineWidth, 0, lineWidth, 1)];
        _downMLineView.backgroundColor = [UIColor colorWithRed:221/255.f green:221/255.f blue:221/255.f alpha:1.0];
    }
    return _downMLineView;
}

-(UIView *)downDLineView{
    
    if (!_downDLineView) {
        
        _downDLineView = [[UIView alloc]initWithFrame:CGRectMake(5*spaceWidth+2*lineWidth, 0, lineWidth, 1)];
        _downDLineView.backgroundColor = [UIColor colorWithRed:221/255.f green:221/255.f blue:221/255.f alpha:1.0];
    }
    return _downDLineView;
}


- (void)clickConfirmButton
{
    
    if ([self.delegate respondsToSelector:@selector(pickerDateView:selectYear:selectMonth:selectDay:)]) {
        
        [self.delegate pickerDateView:self selectYear:self.selectYear selectMonth:self.selectMonth selectDay:self.selectDay];
    }
    
    [super clickConfirmButton];
    
}



- (void)refreshPickViewData
{
    
    self.selectYear  = [self.pickerView selectedRowInComponent:0] + self.minShowYear;
    
    self.selectMonth = [self.pickerView selectedRowInComponent:1] + 1;
    if (_isShowDay==YES) {
        self.selectDay   = [self.pickerView selectedRowInComponent:2] + 1;
    }
    
}


- (void)setYearLeast:(NSInteger)yearLeast
{
    _minShowYear = yearLeast;
}

- (void)setYearSum:(NSInteger)yearSum
{
    _yearSum = yearSum;
}

-(void)setIsShowDay:(BOOL)isShowDay{
    _isShowDay=isShowDay;
}
@end
