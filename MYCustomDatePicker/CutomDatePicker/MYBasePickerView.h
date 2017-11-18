//
//  MYBasePickerView.h
//  MYCustomDatePicker
//
//  Created by mengdy on 17/11/10.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import <UIKit/UIKit.h>

/*-------------------- 屏幕适配 -----------------------------*/
/** 屏幕高度 */
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
/** 高度比例 */
#define kScreen_H_Scale (kScreenHeight*1.0/667)
/** 宽度比例 */
#define kScreen_W_Scale (kScreenWidth/375)

/** 日期距离边的距离*/
#define    spaceWidth   20*kScreen_W_Scale

/** 日期的宽度*/
#define    lineWidth   (kScreenWidth - 120*kScreen_W_Scale)/3.f



@interface MYBasePickerView : UIView


@property (nonatomic, strong) UIView *contentView;

//选择器
@property (nonatomic, strong)UIPickerView *pickerView;
//取消按钮
@property (nonatomic, strong)UIButton *cancelButton;
//确定按钮
@property (nonatomic, strong)UIButton *confirmButton;
//头部视图
@property (nonatomic,strong)UIView    *toolView;
//title
@property (nonatomic,strong)UILabel   *pickerTitleLabel;
//尾部
@property (nonatomic,strong)UIView    *footView;


//选择器每一列的高度
@property (nonatomic, assign)CGFloat pickerViewHeight;

/**
 *  创建视图,初始化视图时初始数据
 */
- (void)initPickView;

/**
 *  确认按钮的点击事件
 */
- (void)clickConfirmButton;

/**
 *  pickerView的显示
 */
- (void)show;

/**
 *  移除pickerView
 */
- (void)disMiss;



@end
