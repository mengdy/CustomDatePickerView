//
//  MYBasePickerView.m
//  MYCustomDatePicker
//
//  Created by mengdy on 17/11/10.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "MYBasePickerView.h"

@implementation MYBasePickerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _pickerViewHeight      = 210;
        self.bounds = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.64];
        self.layer.opacity = 0.0;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMiss)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.toolView];
        [self.toolView addSubview:self.pickerTitleLabel];
        [self.contentView addSubview:self.pickerView];
        [self.toolView addSubview:self.cancelButton];
        [self.contentView addSubview:self.footView];
        [self.footView addSubview:self.confirmButton];
        
        [self initPickView];
    }
    return self;
}
//初始化选择器内容，创建子类时需实现该父类方法
-(void)initPickView{
    
}
//点击确定按钮
- (void)clickConfirmButton
{
    [self disMiss];
}

//点击取消按钮
- (void) clickCancelButton
{
    [self disMiss];
}

//显示选择器
- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self setCenter:[UIApplication sharedApplication].keyWindow.center];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    
    
    CGRect frame =  self.contentView.frame;
    frame.origin.y -= self.contentView.frame.size.height;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.layer setOpacity:1.0];
        self.contentView.frame = frame;
        
    } completion:^(BOOL finished) {
    }];
    
}

//移除选择器
- (void)disMiss
{
    CGRect frame =  self.contentView.frame;
    frame.origin.y += self.contentView.frame.size.height;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.layer setOpacity:0.0];
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
//设置选择器的高度
- (void)setPickerViewHeight:(CGFloat)pickerViewHeight
{
    _pickerViewHeight = pickerViewHeight;
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, pickerViewHeight+90);
}

- (UIView *)contentView
{
    if (!_contentView) {
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, self.pickerViewHeight+90)];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
    }
    return _contentView;
}

-(UIView *)toolView{
    
    if (!_toolView) {
        
        _toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
        _toolView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, kScreenWidth, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [_toolView addSubview:lineView];
    }
    return _toolView;
}

-(UILabel *)pickerTitleLabel{
    
    if (!_pickerTitleLabel) {
        
        _pickerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, kScreenWidth - 120, 43)];
        _pickerTitleLabel.text = @"选择日期";
        _pickerTitleLabel.textColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0];
        _pickerTitleLabel.font = [UIFont systemFontOfSize:16.f];
        _pickerTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _pickerTitleLabel;
}

- (UIPickerView *)pickerView
{
    if (!_pickerView) {
        
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,  45, self.contentView.frame.size.width, self.pickerViewHeight)];
        [_pickerView setBackgroundColor:[UIColor whiteColor]];
        
    }
    return _pickerView;
}

-(UIView *)footView{
    
    if (!_footView) {
        
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetHeight(self.contentView.frame)-45, kScreenWidth, 40)];
        _footView.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [_footView addSubview:lineView];
    }
    
    return _footView;
}



- (UIButton *)cancelButton
{
    if (!_cancelButton) {
        
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(20,8, 27, 27)];
        [_cancelButton setTitle:@"X" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [_cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_cancelButton addTarget:self action:@selector(clickCancelButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton
{
    if (!_confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0] forState:UIControlStateNormal];
        _confirmButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_confirmButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_confirmButton addTarget:self action:@selector(clickConfirmButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}




@end
