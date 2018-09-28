//
//  JYXEditAddressViewController.m
//  JYXTeacher
//
//  Created by apple on 2018/8/30.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXEditAddressViewController.h"
#import "HAddressPickerView.h"
#import <CoreLocation/CoreLocation.h>

@interface JYXEditAddressViewController ()
@property (nonatomic, strong) UIView *topBarView;
@property (nonatomic, strong) UIButton *addressSelect;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UITextView *detailAddress;
@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *addressStr;
@end

@implementation JYXEditAddressViewController
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
    self.navigationItem.title = NSLocalizedString(@"修改地址", nil);
    [self loadData];
}

- (void)setupViews
{
    [self.view addSubview:self.topBarView];
    [self.topBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(7);
        make.top.equalTo(self.view).offset(9);
        make.right.equalTo(self.view).offset(-7);
        make.height.offset(108);
    }];
    
    [self.topBarView addSubview:self.addressSelect];
    [self.addressSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.topBarView);
        make.height.offset(42);
    }];
    
    [self.topBarView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topBarView);
        make.height.offset(1);
        make.top.equalTo(self.topBarView).offset(42);
    }];
    
    [self.topBarView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topBarView).offset(22);
        make.top.equalTo(self.topBarView);
        make.height.offset(42);
    }];
    
    [self.topBarView addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topBarView).offset(-15);
        make.centerY.equalTo(self.titleLabel);
        make.height.offset(16);
        make.width.offset(9);
    }];
    
    [self.topBarView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrowImg).offset(-13);
        make.centerY.equalTo(self.titleLabel);
    }];
    
    [self.topBarView addSubview:self.detailAddress];
    [self.detailAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topBarView).offset(22);
        make.top.equalTo(self.line.mas_bottom).offset(10);
        make.right.equalTo(self.topBarView).offset(-22);
        make.bottom.equalTo(self.topBarView).offset(-10);
    }];
    
    [self.view addSubview:self.saveButton];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-15-kAddBottomHeight);
        make.centerX.equalTo(self.view);
        make.width.offset(232);
        make.height.offset(37);
    }];
}

- (void)loadData
{
    
}

#pragma mark - eventResponse                - Method -
- (void)selectAddressAction:(UIButton *)btn
{
    WeakSelf(weakSelf);
    NSArray *array = [self.addressLabel.text componentsSeparatedByString:@" "];
    [HAddressPickerView areaPickerViewWithProvince:array.count>=3?array[0]:nil city:array.count>=3?array[1]:nil area:array.count>=3?array[2]:nil areaBlock:^(NSString *province, NSString *city, NSString *area) {
        NSString *address = [NSString stringWithFormat:@"%@ %@ %@",province, city, area];
        weakSelf.addressLabel.text = address;
    }];
}

- (void)saveAction:(UIButton *)btn
{
    NSString *addressStr = [[NSString stringWithFormat:@"%@%@",self.addressLabel.text, self.detailAddress.text] stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.addressStr = addressStr;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    WeakSelf(weakSelf);
    [SVProgressHUD show];
    [geocoder geocodeAddressString:addressStr completionHandler:^(NSArray *placemarks, NSError *error){
        [SVProgressHUD dismiss];
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            weakSelf.latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
            weakSelf.longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
            if (self.addressEditBlock) {
                self.addressEditBlock(weakSelf.addressStr, weakSelf.latitude, weakSelf.longitude);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } else {
            [WLToast show:@"地址太过模糊！"];
        }
    }];
}

#pragma mark - customDelegate               - Method -

#pragma mark - notification                 - Method -

#pragma mark - privateMethods               - Method -

#pragma mark - objective-cDelegate          - Method -

#pragma mark - getters and setters          - Method -
- (UIView *)topBarView
{
    if (!_topBarView) {
        _topBarView = [[UIView alloc] init];
        _topBarView.backgroundColor = [UIColor whiteColor];
        JYXViewBorderRadius(_topBarView, 5, 0, [UIColor clearColor]);
    }
    return _topBarView;
}

- (UIButton *)addressSelect
{
    if (!_addressSelect) {
        _addressSelect = [[UIButton alloc] init];
        [_addressSelect addTarget:self action:@selector(selectAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addressSelect;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = NSLocalizedString(@"所在地区", nil);
        _titleLabel.font = FONT_SIZE(15);
        _titleLabel.textColor = [UIColor colorWithHex:0x676767];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UILabel *)addressLabel
{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.text = NSLocalizedString(@"北京市 北京市 东城区", nil);
        _addressLabel.font = FONT_SIZE(15);
        _addressLabel.textColor = [UIColor colorWithHex:0x676767];
        [_addressLabel sizeToFit];
    }
    return _addressLabel;
}

- (UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.image = [UIImage imageNamed:@"rightArrow"];
        _arrowImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _arrowImg;
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    }
    return _line;
}

- (UITextView *)detailAddress
{
    if (!_detailAddress) {
        _detailAddress = [[UITextView alloc] init];
        _detailAddress.placeholder = NSLocalizedString(@"请输入详细地址", nil);
        _detailAddress.font = FONT_SIZE(15);
        _detailAddress.textColor = [UIColor colorWithHex:0x676767];
    }
    return _detailAddress;
}

- (UIButton *)saveButton
{
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] init];
        _saveButton.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        [_saveButton setTitle:NSLocalizedString(@"保存", nil) forState:UIControlStateNormal];
        _saveButton.titleLabel.font = FONT_SIZE(18);
        JYXViewBorderRadius(_saveButton, 19, 0, [UIColor clearColor]);
        [_saveButton sizeToFit];
        [_saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

@end
