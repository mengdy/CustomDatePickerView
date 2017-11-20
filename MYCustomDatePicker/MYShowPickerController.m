//
//  MYShowPickerController.m
//  MYCustomDatePicker
//
//  Created by mengdy on 17/11/10.
//  Copyright © 2017年 mengdy. All rights reserved.
//

#import "MYShowPickerController.h"
#import "MYPickerDateView.h"
#import "MYBasePickerView.h"
@interface MYShowPickerController ()<PickerDateViewDelegate>

@property (nonatomic,strong)UILabel *brithLabel;


@end

@implementation MYShowPickerController

-(UILabel *)brithLabel{
    
    if (!_brithLabel) {
        
        _brithLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 40)];
        _brithLabel.font = [UIFont systemFontOfSize:16.f];
        _brithLabel.textColor = [UIColor blackColor];
        _brithLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _brithLabel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    //设置title
    self.navigationItem.title = @"自定义DatePicker";
    
    [self rightBarBtnForAddPickerView];
    [self.view addSubview:self.brithLabel];
    
    
    
}

-(void)pickerDateView:(MYBasePickerView *)pickerDateView selectYear:(NSInteger)year selectMonth:(NSInteger)month selectDay:(NSInteger)day{
    NSLog(@"选择的日期是：%ld %ld %ld",year,month,day);
    
    self.brithLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld",year,month,day];
    
}




-(void)rightBarBtnForAddPickerView{
    
    
    UIImageView *addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [addImageView setImage:[UIImage imageNamed:@"add"]];
    addImageView.layer.cornerRadius = 20;
    addImageView.contentMode = UIViewContentModeScaleAspectFit;
    addImageView.layer.masksToBounds = YES;
    addImageView.userInteractionEnabled = YES;
    //添加手势
    UITapGestureRecognizer *addTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addPickerView)];
    [addImageView addGestureRecognizer:addTap];
    
    UIBarButtonItem *rightImage = [[UIBarButtonItem alloc]initWithCustomView:addImageView];
    /*
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    [rightBtn setTitle:@"添加时间" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blueColor]  forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [rightBtn addTarget:self action:@selector(addPickerView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBatBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
     */
    self.navigationItem.rightBarButtonItems = @[rightImage];
    
}

-(void)addPickerView{
    
    
    MYPickerDateView *pickerDate = [[MYPickerDateView alloc]init];
    [pickerDate setIsAddYetSelect:NO];//是否显示至今选项
    [pickerDate setIsShowDay:YES];//是否显示日信息
    [pickerDate setDefaultTSelectYear:1 defaultSelectMonth:-9 defaultSelectDay:24];//设定默认显示的日期
    //    [pickerDate setValidTime:2010];
    
    [pickerDate setDelegate:self];
    
    [pickerDate show];
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
