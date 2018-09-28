//
//  JYXLessonDistanceViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/22.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXLessonDistanceViewController.h"
#import "HSlider.h"
#import "TakeOrderSettingHandler.h"

@interface JYXLessonDistanceViewController ()<HSliderDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *rangeLabel;
@property (nonatomic, strong) UILabel *minDistanceLabel;
@property (nonatomic, strong) UILabel *maxDistanceLabel;
@property (nonatomic, strong) UIButton *submitBtn;
//@property (nonatomic, strong) HSlider *distanceSlider;
@property (nonatomic, strong) UISlider *distanceSlider;
@end

@implementation JYXLessonDistanceViewController
#pragma mark - lifeCycle                    - Method -

- (void)dealloc
{
    
}

- (void)loadView
{
    [super loadView];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"授课距离设置", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.distanceSlider];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.top.equalTo(self.view).offset(25);
    }];
    
    [self.view addSubview:self.rangeLabel];
    [self.rangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right);
        make.centerY.equalTo(self.titleLabel);
    }];
    
    [self.view addSubview:self.minDistanceLabel];
    [self.minDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.top.equalTo(self.distanceSlider.mas_bottom).offset(40);
    }];
    
    [self.view addSubview:self.maxDistanceLabel];
    [self.maxDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-40);
        make.centerY.equalTo(self.minDistanceLabel);
    }];
    
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-50);
        make.left.equalTo(self.view).offset(17);
        make.right.equalTo(self.view).offset(-17);
        make.height.offset(46);
    }];
}

- (void)loadData
{
    self.distanceSlider.value = self.currentDistance;
    if (self.currentDistance > 99) {
        self.rangeLabel.text = @"（同城不限）";
    } else {
        self.rangeLabel.text = [NSString stringWithFormat:@"（%ldKM）",self.currentDistance];
    }
}

#pragma mark - eventResponse                - Method -
//提交
- (void)submitAction:(UIButton *)btn
{
    if (self.currentDistance >= 99) {
        self.currentDistance = 999;
    }
    [TakeOrderSettingHandler postTeacherLessonRangeWithRangeStr:[NSString stringWithFormat:@"%ld",(long)_currentDistance] prepare:^{
        
    } success:^(id obj) {
        WeakSelf(weakSelf);
        if (self.lessonDistanceBlock) {
            self.lessonDistanceBlock(weakSelf.currentDistance);
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

#pragma mark - customDelegate               - Method -
- (void)HSlider:(HSlider *)hSlider didScrollValue:(int)value
{
    NSLog(@"value==%d",value);
    _currentDistance = value;
}

- (void)sliderValueChanged:(UISlider *)slider
{
    _currentDistance = slider.value;
    if (slider.value > 99) {
        self.rangeLabel.text = @"（同城不限）";
    } else {
        self.rangeLabel.text = [NSString stringWithFormat:@"（%dKM）",(int)slider.value];
    }
}

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = NSLocalizedString(@"理想上课距离", nil);
        _titleLabel.font = FONT_SIZE(14);
        _titleLabel.textColor = [UIColor colorWithHex:0x8d8d8d];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)minDistanceLabel
{
    if (!_minDistanceLabel) {
        _minDistanceLabel = [[UILabel alloc] init];
        _minDistanceLabel.text = NSLocalizedString(@"15KM", nil);
        _minDistanceLabel.font = FONT_SIZE(14);
        _minDistanceLabel.textColor = [UIColor colorWithHex:0xa8a8a8];
        [_minDistanceLabel sizeToFit];
    }
    return _minDistanceLabel;
}

- (UILabel *)maxDistanceLabel
{
    if (!_maxDistanceLabel) {
        _maxDistanceLabel = [[UILabel alloc] init];
        _maxDistanceLabel.text = NSLocalizedString(@"同城不限制", nil);
        _maxDistanceLabel.font = FONT_SIZE(14);
        _maxDistanceLabel.textColor = [UIColor colorWithHex:0xa8a8a8];
        [_maxDistanceLabel sizeToFit];
    }
    return _maxDistanceLabel;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

//- (HSlider *)distanceSlider
//{
//    if (!_distanceSlider) {
//        _distanceSlider = [[HSlider alloc] initWithFrame:CGRectMake(40, 92, SCREEN_WIDTH-80, 5)];
//        _distanceSlider.showTouchView = YES;
//        _distanceSlider.showScrollTextView = YES;
//        _distanceSlider.delegate = self;
//        _distanceSlider.maxValue = 50;
//        _distanceSlider.currentSliderValue = 15;
//    }
//    return _distanceSlider;
//}
- (UISlider *)distanceSlider
{
    if (!_distanceSlider) {
        _distanceSlider = [[UISlider alloc] initWithFrame:CGRectMake(40, 92, SCREEN_WIDTH-80, 5)];
        _distanceSlider.minimumValue = 15;// 设置最小值
        _distanceSlider.maximumValue = 100;// 设置最大值
        _distanceSlider.continuous = YES;
        [_distanceSlider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];// 针对值变化添加响应方法
    }
    return _distanceSlider;
}

- (UILabel *)rangeLabel
{
    if (!_rangeLabel) {
        _rangeLabel = [[UILabel alloc] init];
        _rangeLabel.text = @"（15KM）";
        _rangeLabel.textColor = [UIColor colorWithHex:0x1aabfd];
        _rangeLabel.font = FONT_SIZE(18);
        [_rangeLabel sizeToFit];
    }
    return _rangeLabel;
}

@end
