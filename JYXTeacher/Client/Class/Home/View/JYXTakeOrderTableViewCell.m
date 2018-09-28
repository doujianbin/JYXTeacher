//
//  JYXTakeOrderTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXTakeOrderTableViewCell.h"
#import "JYXHomeTeacherSearchteacherGrabApi.h"
#import "JYXHomeTeacherSearchRemoveApi.h"

@interface JYXTakeOrderTableViewCell ()
{
    NSDictionary *_cellDictData;
}
@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *countDownLabel;
@property (nonatomic, strong) UIImageView *cutLine;
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UIImageView *locationImg;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *cutLine1;
@property (nonatomic, strong) UIView *functionBarView;
@property (nonatomic, strong) UIImageView *cutLine2;
@property (nonatomic, strong) UILabel *statusLabel;//抢单状态
@property (nonatomic, strong) UIButton *takeOrderBtn;//抢单按钮

@end

@implementation JYXTakeOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(18);
        make.height.offset(14);
        make.right.equalTo(self.contentView).offset(-18);
        make.top.equalTo(self.contentView).offset(13);
    }];
    
    [self.contentView addSubview:self.countDownLabel];
    [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-17);
        make.centerY.equalTo(self.dateLabel);
        make.right.lessThanOrEqualTo(self.dateLabel.mas_right).offset(10);
    }];
    
    [self.contentView addSubview:self.cutLine];
    [self.cutLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateLabel.mas_bottom).offset(13);
        make.height.offset(1);
        make.left.right.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(17);
        make.top.equalTo(self.cutLine.mas_bottom).offset(5);
        make.height.width.equalTo(@50);
    }];
    
    [self.contentView addSubview:self.locationImg];
    [self.locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImg.mas_right).offset(5);
        make.height.offset(13);
        make.width.offset(11);
        make.bottom.equalTo(self.avatarImg.mas_bottom).offset(-6);
    }];
    
    [self.contentView addSubview:self.locationLabel];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.locationImg.mas_right).offset(2);
        make.centerY.equalTo(self.locationImg);
        make.right.equalTo(self.contentView).offset(-17);
    }];
    
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-17);
        make.top.equalTo(self.avatarImg).offset(6);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImg.mas_right).offset(5);
        make.top.equalTo(self.avatarImg).offset(6);
        make.right.lessThanOrEqualTo(self.priceLabel.mas_left).offset(-10);
    }];
    
    [self.contentView addSubview:self.cutLine1];
    [self.cutLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.avatarImg.mas_bottom).offset(5);
        make.height.offset(1);
        make.left.right.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.functionBarView];
    [self.functionBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.offset(44);
        make.top.equalTo(self.cutLine1.mas_bottom);
    }];
    
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.functionBarView).offset(17);
        make.centerY.equalTo(self.functionBarView);
    }];
    
    [self.contentView addSubview:self.takeOrderBtn];
    [self.takeOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.functionBarView).offset(-17);
        make.centerY.equalTo(self.functionBarView);
        make.height.offset(25);
        make.width.offset(50);
    }];
    
    [self.contentView addSubview:self.cutLine2];
    [self.cutLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.functionBarView.mas_bottom);
        make.height.offset(15);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).priorityMedium();
    }];
}

- (void)configTakeOrderCellWithData:(id)model
{
    if (!model) return;
    NSDictionary *dict = model;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:dict[@"head"]] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)]];
    self.dateLabel.text = [[NSDate date] weekdayStringFromDate:dict[@"endtime"]];
    self.locationLabel.text = dict[@"addrinfo"];
    self.statusLabel.text = dict[@"status"];
    if ([dict[@"status"] isEqualToString:@"待抢单"]) {
        [self.takeOrderBtn setTitle:NSLocalizedString(@"抢单", nil) forState:UIControlStateNormal];
    } else if ([dict[@"status"] isEqualToString:@"抢单中"]) {
        [self.takeOrderBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
    }
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@  %@  %@",dict[@"name"], dict[@"grade"], dict[@"subject"]];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@/小时",dict[@"price"]];
    [self downSecondHandle:[[NSDate timeStampWithNowToAppoint:dict[@"endtime"]] integerValue]];
    
    _cellDictData = dict;
}

//抢单
- (void)takeOrderAction:(UIButton *)btn
{
    JYXUser *user = [JYXUserManager shareInstance].user;
    if ([_cellDictData[@"status"] isEqualToString:@"待抢单"]) {//抢单
        JYXHomeTeacherSearchteacherGrabApi *api = [[JYXHomeTeacherSearchteacherGrabApi alloc] initWithUserid:user.userId WithToken:user.token courseId:_cellDictData[@"id"]];
        [SVProgressHUD show];
        [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
            [self.takeOrderBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
            self.statusLabel.text = NSLocalizedString(@"抢单中", nil);
        } failure:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    } else if ([_cellDictData[@"status"] isEqualToString:@"抢单中"]) {//取消抢单
        JYXHomeTeacherSearchRemoveApi *api = [[JYXHomeTeacherSearchRemoveApi alloc] initWithUserid:user.userId WithToken:user.token courseId:_cellDictData[@"id"]];
        [SVProgressHUD show];
        [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
            [self.takeOrderBtn setTitle:NSLocalizedString(@"抢单", nil) forState:UIControlStateNormal];
            self.statusLabel.text = NSLocalizedString(@"待抢单", nil);
        } failure:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
    }
}

//剩余时间倒计时
-(void)downSecondHandle:(NSInteger)aTime{
    if (_timer==nil) {
        __block NSInteger timeout = aTime; //倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            WeakSelf(weakSelf);
            dispatch_source_set_event_handler(_timer, ^{
                StrongSelf(strongSelf);
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(strongSelf.timer);
                    strongSelf.timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"剩余时间：00:00:00"];
                        [AttributedStr addAttribute:NSForegroundColorAttributeName
                                              value:[UIColor colorWithHex:0x6d6d6d]
                                              range:NSMakeRange(0, 5)];
                        strongSelf.countDownLabel.attributedText = AttributedStr;
                    });
                }else{
                    NSInteger days = (timeout/(3600*24));
                    NSInteger hours = ((timeout-days*24*3600)/3600);
                    NSInteger minute = (timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"剩余时间：%ld:%ld:%ld",days*24+hours,minute,second]];
                        [AttributedStr addAttribute:NSForegroundColorAttributeName
                                              value:[UIColor colorWithHex:0x6d6d6d]
                                              range:NSMakeRange(0, 5)];
                        strongSelf.countDownLabel.attributedText = AttributedStr;
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}

#pragma mark-- setter getter method
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        _dateLabel.font = FONT_SIZE(14);
    }
    return _dateLabel;
}

- (UILabel *)countDownLabel
{
    if (!_countDownLabel) {
        _countDownLabel = [[UILabel alloc] init];
        _countDownLabel.font = FONT_SIZE(15);
        _countDownLabel.textColor = [UIColor colorWithHex:0xff6d35];
        [_countDownLabel sizeToFit];
    }
    return _countDownLabel;
}

- (UIImageView *)cutLine
{
    if (!_cutLine) {
        _cutLine = [[UIImageView alloc] init];
        _cutLine.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    }
    return _cutLine;
}

- (UIImageView *)avatarImg
{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] init];
        _avatarImg.contentMode = UIViewContentModeScaleAspectFill;
        JYXViewBorderRadius(_avatarImg, 50/2.0, 0, [UIColor clearColor]);
    }
    return _avatarImg;
}

- (UIImageView *)locationImg
{
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc] init];
        _locationImg.image = [UIImage imageNamed:@"Home_location"];
        [_locationImg sizeToFit];
    }
    return _locationImg;
}

- (UILabel *)locationLabel
{
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        _locationLabel.font = FONT_SIZE(14);
        [_locationLabel sizeToFit];
        
    }
    return _locationLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = [UIColor colorWithHex:0xF7A94D];
        _statusLabel.font = FONT_SIZE(15);
        _statusLabel.textAlignment = NSTextAlignmentRight;
        [_statusLabel sizeToFit];
    }
    return _statusLabel;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = FONT_SIZE(14);
        _nameLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = FONT_SIZE(14);
        _priceLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        [_priceLabel sizeToFit];
    }
    return _priceLabel;
}

- (UIImageView *)cutLine1
{
    if (!_cutLine1) {
        _cutLine1 = [[UIImageView alloc] init];
        _cutLine1.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    }
    return _cutLine1;
}

- (UIView *)functionBarView
{
    if (!_functionBarView) {
        _functionBarView = [[UIView alloc] init];
        
    }
    return _functionBarView;
}

- (UIButton *)takeOrderBtn
{
    if (!_takeOrderBtn) {
        _takeOrderBtn = [[UIButton alloc] init];
        JYXViewBorderRadius(_takeOrderBtn, 13, 1, [UIColor colorWithHex:0x1aabfd]);
        _takeOrderBtn.titleLabel.font = FONT_SIZE(15);
        [_takeOrderBtn setTitleColor:[UIColor colorWithHex:0x1aabfd] forState:UIControlStateNormal];
        [_takeOrderBtn sizeToFit];
        [_takeOrderBtn addTarget:self action:@selector(takeOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _takeOrderBtn;
}

- (UIImageView *)cutLine2
{
    if (!_cutLine2) {
        _cutLine2 = [[UIImageView alloc] init];
        _cutLine2.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    }
    return _cutLine2;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
