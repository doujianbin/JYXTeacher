//
//  JYXScheduleTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/23.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXScheduleTableViewCell.h"
@interface JYXScheduleTableViewCell ()
@property (nonatomic, strong) NSDictionary *dictCellData;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *verticalLine;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *dotImg;
@end

@implementation JYXScheduleTableViewCell
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
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.equalTo(self.contentView);
        make.height.offset(1);
    }];
    
    [self.contentView addSubview:self.verticalLine];
    [self.verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.offset(1);
        make.bottom.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-28);
        make.centerX.equalTo(self.contentView).offset(-SCREEN_WIDTH/4);
    }];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(40);
        make.left.equalTo(self.verticalLine).offset(20);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.dateLabel);
    }];
    //点
    [self.contentView addSubview:self.dotImg];
    [self.dotImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(10);
        make.centerX.equalTo(self.verticalLine);
        make.top.equalTo(self.dateLabel).offset(2);
    }];
}

- (void)configScheduleCellWithData:(id)model
{
    if (!model) return;
    NSDictionary *dict = model;
    NSNumber *index = dict[@"index"];
    NSNumber *total = dict[@"total"];
    NSDictionary *data = dict[@"data"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@ 星期%@",data[@"date"],data[@"week"]];
    self.contentLabel.text = [NSString stringWithFormat:@"%@\n%@    %@-%@",data[@"times"],data[@"name"],data[@"grade"],data[@"subject"]];
    
    if (index.integerValue == 0) {
        [self.verticalLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(25);
        }];
    }
    if (index.integerValue == (total.integerValue-1)) {
        [self.verticalLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-25);
        }];
    }
    _dictCellData = data;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = FONT_SIZE(14);
        _dateLabel.textColor = [UIColor colorWithHex:0x555555];
        [_dateLabel sizeToFit];
    }
    return _dateLabel;
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    }
    return _line;
}

- (UIImageView *)verticalLine
{
    if (!_verticalLine) {
        _verticalLine = [[UIImageView alloc] init];
        _verticalLine.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    }
    return _verticalLine;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = FONT_SIZE(14);
        _contentLabel.numberOfLines = 2;
        _contentLabel.textColor = [UIColor colorWithHex:0x555555];
        [_contentLabel sizeToFit];
    }
    return _contentLabel;
}

- (UIImageView *)dotImg
{
    if (!_dotImg) {
        _dotImg = [[UIImageView alloc] init];
        _dotImg.image = [UIImage imageNamed:@"Dot"];
    }
    return _dotImg;
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
