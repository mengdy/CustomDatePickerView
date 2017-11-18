//
//  MYPickerDateView.h
//  MYCustomDatePicker
//
//  Created by mengdy on 17/11/10.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "MYBasePickerView.h"
@class MYBasePickerView;
//选择器的选择代理方法
@protocol  PickerDateViewDelegate<NSObject>
- (void)pickerDateView:(MYBasePickerView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day;
@end

@interface MYPickerDateView : MYBasePickerView

@property(nonatomic, weak)id <PickerDateViewDelegate>delegate ;
@property(nonatomic, assign)BOOL isAddYetSelect;//是否增加至今的选项
@property(nonatomic, assign)BOOL isShowDay;//是否显示日
//设置默认显示的值
-(void)setDefaultTSelectYear:(NSInteger)defaultSelectYear defaultSelectMonth:(NSInteger)defaultSelectMonth defaultSelectDay:(NSInteger)defaultSelectDay;


//判断Mouth和day是不是双位数
-(NSString *)rowIslLowTen:(NSInteger )row;

@end
