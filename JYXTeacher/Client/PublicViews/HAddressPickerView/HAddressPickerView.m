//
//  HAddressPickerView.m
//  WeLearn
//
//  Created by YXG on 2018/1/11.
//  Copyright © 2018年 WeLearn. All rights reserved.
//

#import "HAddressPickerView.h"
#import "AddressPickerHeader.h"
#import "UIButton+HExtension.h"

#define TOOLBAR_BUTTON_WIDTH H_ScaleWidth(65)

typedef NS_ENUM(NSInteger, HAddressPickerViewButtonType) {
    HAddressPickerViewButtonTypeCancle,
    HAddressPickerViewButtonTypeSure
};

typedef NS_ENUM(NSInteger, HAddressPickerViewType) {
    //只显示省
    HAddressPickerViewTypeProvince = 1,
    //显示省份和城市
    HAddressPickerViewTypeCity,
    //显示省市区，默认
    HAddressPickerViewTypeArea
};

@interface HAddressPickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>
///列数
@property (nonatomic, assign) NSInteger columnCount;
///容器view
@property (nonatomic, weak) UIView *containView;
///
@property(nonatomic, strong) UIPickerView * pickerView;
///省
@property(nonatomic, strong) NSArray * provinceArray;
///市
@property(nonatomic, strong) NSArray * cityArray;
///区
@property(nonatomic, strong) NSArray * areaArray;
///所有数据
@property(nonatomic, strong) NSArray * dataSource;
///记录省选中的位置
@property(nonatomic, assign) NSInteger selectProvinceIndex;
//显示类型
@property (nonatomic, assign) HAddressPickerViewType showType;
///传进来的默认选中的省
@property(nonatomic, copy) NSString * selectProvince;
///传进来的默认选中的市
@property(nonatomic, copy) NSString * selectCity;
///传进来的默认选中的区
@property(nonatomic, copy) NSString * selectArea;
///省份回调
@property (nonatomic, copy) void (^provinceBlock)(NSString *province);
///城市回调
@property (nonatomic, copy) void (^cityBlock)(NSString *province, NSString *city);
///区域回调
@property (nonatomic, copy) void (^areaBlock)(NSString *province, NSString *city, NSString *area);

@end

@implementation HAddressPickerView
/**
 * 只显示省份一级
 * provinceBlock : 回调省份
 */
+ (instancetype)provincePickerViewWithProvinceBlock:(void(^)(NSString *province))provinceBlock {
    return [HAddressPickerView addressPickerViewWithProvince:nil city:nil area:nil provinceBlock:provinceBlock cityBlock:nil areaBlock:nil showType:HAddressPickerViewTypeProvince];
}

/**
 * 显示省份和市级
 * cityBlock : 回调省份和城市
 */
+ (instancetype)cityPickerViewWithCityBlock:(void(^)(NSString *province, NSString *city))cityBlock {
    return [HAddressPickerView addressPickerViewWithProvince:nil city:nil area:nil provinceBlock:nil cityBlock:cityBlock areaBlock:nil showType:HAddressPickerViewTypeCity];
}

/**
 * 显示省份和市级和区域
 * areaBlock : 回调省份城市和区域
 */
+ (instancetype)areaPickerViewWithAreaBlock:(void(^)(NSString *province, NSString *city, NSString *area))areaBlock {
    return [HAddressPickerView addressPickerViewWithProvince:nil city:nil area:nil provinceBlock:nil cityBlock:nil areaBlock:areaBlock showType:HAddressPickerViewTypeArea];
}

/**
 * 只显示省份一级
 * province : 传入了省份自动滚动到省份，没有传或者找不到默认选中第一个
 * provinceBlock : 回调省份
 */
+ (instancetype)provincePickerViewWithProvince:(NSString *)province provinceBlock:(void(^)(NSString *province))provinceBlock {
    return [HAddressPickerView addressPickerViewWithProvince:province city:nil area:nil provinceBlock:provinceBlock cityBlock:nil areaBlock:nil showType:HAddressPickerViewTypeProvince];
}

/**
 * 显示省份和市级
 * province,city : 传入了省份和城市自动滚动到选中的，没有传或者找不到默认选中第一个
 * cityBlock : 回调省份和城市
 */
+ (instancetype)cityPickerViewWithProvince:(NSString *)province city:(NSString *)city cityBlock:(void(^)(NSString *province, NSString *city))cityBlock {
    return [HAddressPickerView addressPickerViewWithProvince:province city:city area:nil provinceBlock:nil cityBlock:cityBlock areaBlock:nil showType:HAddressPickerViewTypeCity];
}

/**
 * 显示省份和市级和区域
 * province,city : 传入了省份和城市和区域自动滚动到选中的，没有传或者找不到默认选中第一个
 * areaBlock : 回调省份城市和区域
 */
+ (instancetype)areaPickerViewWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area areaBlock:(void(^)(NSString *province, NSString *city, NSString *area))areaBlock {
    return [HAddressPickerView addressPickerViewWithProvince:province city:city area:area provinceBlock:nil cityBlock:nil areaBlock:areaBlock showType:HAddressPickerViewTypeArea];
}

+ (instancetype)addressPickerViewWithProvince:(NSString *)province city:(NSString *)city area:(NSString *)area provinceBlock:(void(^)(NSString *province))provinceBlock cityBlock:(void(^)(NSString *province, NSString *city))cityBlock areaBlock:(void(^)(NSString *province, NSString *city, NSString *area))areaBlock  showType:(HAddressPickerViewType)showType{
    
    HAddressPickerView *_view = [[HAddressPickerView alloc] init];
    
    _view.showType = showType;
    
    _view.selectProvince = province;
    
    _view.selectCity = city;
    
    _view.selectArea = area;
    
    _view.provinceBlock = provinceBlock;
    
    _view.cityBlock = cityBlock;
    
    _view.areaBlock = areaBlock;
    
    [_view h_getData];
    
    [_view showView];
    
    return _view;
    
}

- (instancetype)init {
    if (self = [super init]) {
        
        [self h_setView];
        
    }
    return self;
}

- (void)h_setView {
    
    self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    UIView *containView = [[UIView alloc] init];
    containView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, H_ScaleHeight(270));
    [self addSubview:containView];
    self.containView = containView;
    
    
    UIView *toolBar = [[UIView alloc] init];
    toolBar.frame = CGRectMake(0, 0, ScreenWidth, H_ScaleHeight(55));
    toolBar.backgroundColor = HColor(0xf6f6f6);
    [containView addSubview:toolBar];
    
    UIButton *cancleButton = [UIButton h_buttonWithTarget:self action:@selector(buttonClick:) frame:CGRectMake(0, 0, TOOLBAR_BUTTON_WIDTH, toolBar.h_height) titleColor:HColor(0x666666) titleFont:HGlobelNormalFont(18) title:@"取消"];
    cancleButton.tag = HAddressPickerViewButtonTypeCancle;
    [toolBar addSubview:cancleButton];
    
    UIButton *sureButton = [UIButton h_buttonWithTarget:self action:@selector(buttonClick:) frame:CGRectMake(toolBar.h_width - TOOLBAR_BUTTON_WIDTH, 0, TOOLBAR_BUTTON_WIDTH, toolBar.h_height) titleColor:HThemeColor titleFont:HGlobelNormalFont(18) title:@"确定"];
    sureButton.tag = HAddressPickerViewButtonTypeSure;
    [toolBar addSubview:sureButton];
    
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.backgroundColor = HColor(0xffffff);
    pickerView.frame = CGRectMake(0, toolBar.h_bottom, ScreenWidth, containView.h_height - toolBar.h_height);
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [containView addSubview:pickerView];
    self.pickerView = pickerView;
    
}

//获取数据
- (void)h_getData {
    NSString * path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    self.dataSource = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray * tempArray = [NSMutableArray array];
    
    for (NSDictionary * tempDic in self.dataSource) {
        
        for (int i = 0; i < tempDic.allKeys.count; i ++) {
            [tempArray addObject:tempDic.allKeys[i]];
        }
        
    }
    //省
    self.provinceArray = [tempArray copy];
    //市
    self.cityArray = [self getCityNamesFromProvinceIndex:0];
    //区
    self.areaArray = [self getAreaNamesFromProvinceIndex:0 cityIndex:0];
    
    //如果没有传入默认选中的省市区，默认选中各个数组的第一个
    if (!self.selectProvince.length) {
        self.selectProvince = [self.provinceArray firstObject];
    }
    if (!self.selectCity.length) {
        self.selectCity = [self.cityArray firstObject];
    }
    if (!self.selectArea.length) {
        self.selectArea = [self.areaArray firstObject];
    }
    
    
    
    
    
    NSInteger provinceIndex = 0;
    NSInteger cityIndex = 0;
    NSInteger areaIndex = 0;
    
    for (NSInteger p = 0; p < self.provinceArray.count; p++) {
        if ([self.provinceArray[p] isEqualToString:self.selectProvince]) {
            self.selectProvinceIndex = p;
            provinceIndex = p;
            self.cityArray = [self getCityNamesFromProvinceIndex:p];
            
            for (NSInteger c = 0; c < self.cityArray.count; c++) {
                if ([self.cityArray[c] isEqualToString:self.selectCity]) {
                    cityIndex = c;
                    self.areaArray = [self getAreaNamesFromProvinceIndex:p cityIndex:c];
                    
                    for (NSInteger a = 0; a < self.areaArray.count; a++) {
                        if ([self.areaArray[a] isEqualToString:self.selectArea]) {
                            areaIndex = a;
                        }
                    }
                }
            }
        }
    }
    
    
    if (self.showType == HAddressPickerViewTypeProvince) {
        [self.pickerView selectRow:provinceIndex inComponent:0 animated:YES];
    } else if (self.showType == HAddressPickerViewTypeCity) {
        [self.pickerView selectRow:provinceIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:cityIndex inComponent:1 animated:YES];
    } else if (self.showType == HAddressPickerViewTypeArea) {
        [self.pickerView selectRow:provinceIndex inComponent:0 animated:YES];
        [self.pickerView selectRow:cityIndex inComponent:1 animated:YES];
        [self.pickerView selectRow:areaIndex inComponent:2 animated:YES];
    }
    
}

//获取plist区域数组
- (NSArray *)getAreaNamesFromProvinceIndex:(NSInteger)provinceIndex cityIndex:(NSInteger)cityIndex
{
    
    NSDictionary * tempDic = [self.dataSource[provinceIndex] objectForKey:self.provinceArray[provinceIndex]];
    NSArray * array = [NSArray array];
    
    NSDictionary * dic = tempDic.allValues[cityIndex];
    array = [dic objectForKey:self.cityArray[cityIndex]];
    
    return array;
}

//获取plist城市数组
- (NSArray *)getCityNamesFromProvinceIndex:(NSInteger)provinceIndex
{
    NSDictionary * tempDic = [self.dataSource[provinceIndex] objectForKey:self.provinceArray[provinceIndex]];
    NSMutableArray * cityArray = [NSMutableArray array];
    for (NSDictionary * valueDic in tempDic.allValues) {
        
        for (int i = 0; i < valueDic.allKeys.count; i ++) {
            [cityArray addObject:valueDic.allKeys[i]];
        }
    }
    return [cityArray copy];
}

- (void)buttonClick:(UIButton *)sender {
    
    [self hideView];
    
    if (sender.tag == HAddressPickerViewButtonTypeSure) {
        
        if (_provinceBlock) {
            _provinceBlock(self.selectProvince);
        }
        if (_cityBlock) {
            _cityBlock(self.selectProvince, self.selectCity);
        }
        if (_areaBlock) {
            _areaBlock(self.selectProvince, self.selectCity, self.selectArea);
        }
    }
}

#pragma mark -- UIPickerView

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.columnCount;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinceArray.count;
    }else if (component == 1){
        return self.cityArray.count;
    }else if (component == 2){
        return self.areaArray.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width / 3, 30)];
    label.adjustsFontSizeToFitWidth = YES;
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text = self.provinceArray[row];
    }else if (component == 1){
        label.text = self.cityArray[row];
    }else if (component == 2){
        label.text = self.areaArray[row];
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {//选择省
        self.selectProvinceIndex = row;
        
        if (self.showType == HAddressPickerViewTypeProvince) {
            self.selectProvince = self.provinceArray[row];
            self.selectCity = @"";
            self.selectArea = @"";
        } else if (self.showType == HAddressPickerViewTypeCity) {
            self.cityArray = [self getCityNamesFromProvinceIndex:row];
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            
            self.selectProvince = self.provinceArray[row];
            self.selectCity = self.cityArray[0];
            self.selectArea = @"";
        } else if (self.showType == HAddressPickerViewTypeArea) {
            
            self.cityArray = [self getCityNamesFromProvinceIndex:row];
            self.areaArray = [self getAreaNamesFromProvinceIndex:row cityIndex:0];
            
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            
            self.selectProvince = self.provinceArray[row];
            self.selectCity = self.cityArray[0];
            self.selectArea = self.areaArray[0];
        }
    }else if (component == 1){//选择市
        
        if (self.showType == HAddressPickerViewTypeCity) {
            
            self.selectCity = self.cityArray[row];
            self.selectArea = @"";
        } else if (self.showType == HAddressPickerViewTypeArea) {
            
            self.areaArray = [self getAreaNamesFromProvinceIndex:self.selectProvinceIndex cityIndex:row];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
            self.selectCity = self.cityArray[row];
            self.selectArea = self.areaArray[0];
        }
    }else if (component == 2){//选择区
        
        if (self.showType == HAddressPickerViewTypeArea) {
            self.selectArea = self.areaArray[row];
        }
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40.0;
}

- (void)showView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = HRGBColor(0x000000, 0.3);
        self.containView.h_bottom = ScreenHeight;
    }];
}

- (void)hideView {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.containView.h_y = ScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (void)setShowType:(HAddressPickerViewType)showType {
    _showType = showType;
    self.columnCount = showType;
    
    [self.pickerView reloadAllComponents];
}



- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

- (NSArray *)provinceArray
{
    if (!_provinceArray) {
        _provinceArray = [NSArray array];
    }
    return _provinceArray;
}

- (NSArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSArray array];
    }
    return _cityArray;
}

- (NSArray *)areaArray
{
    if (!_areaArray) {
        _areaArray = [NSArray array];
    }
    return _areaArray;
}


@end
