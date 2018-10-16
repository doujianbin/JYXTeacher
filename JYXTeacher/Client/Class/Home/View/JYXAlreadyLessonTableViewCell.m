//
//  JYXAlreadyLessonTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAlreadyLessonTableViewCell.h"
#import "JYXCourseHomeworkViewController.h"
#import "JYXAppraiseViewController.h"
#import "TeacherWorkHandler.h"

@interface JYXAlreadyLessonTableViewCell ()
@property (nonatomic, strong) NSDictionary *dictCellData;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *cutLine;
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UIImageView *locationImg;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *cutLine1;
@property (nonatomic, strong) UIView *functionBarView;
@property (nonatomic, strong) UIImageView *cutLine2;
@property (nonatomic, strong) UIButton *prepareWorkBtn;//课后作业
@property (nonatomic, strong) UIButton *evaluateBtn;//去评价
@property (nonatomic, strong) UIButton *communicateBtn;//沟通

@end

@implementation JYXAlreadyLessonTableViewCell

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
    }];
    
    [self.contentView addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-17);
        make.width.offset(52);
        make.left.equalTo(self.locationLabel.mas_right);
        make.centerY.equalTo(self.locationImg);
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
    
    [self.contentView addSubview:self.prepareWorkBtn];
    [self.prepareWorkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.functionBarView).offset(17);
        make.centerY.equalTo(self.functionBarView);
        make.height.offset(25);
        make.width.offset(70);
    }];
    
    [self.contentView addSubview:self.communicateBtn];
    [self.communicateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.functionBarView).offset(-17);
        make.centerY.equalTo(self.functionBarView);
        make.height.offset(25);
        make.width.offset(50);
    }];
    
    [self.contentView addSubview:self.evaluateBtn];
    [self.evaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.communicateBtn.mas_left).offset(-9);
        make.centerY.equalTo(self.functionBarView);
        make.height.offset(25);
        make.width.offset(55);
    }];
    
    [self.contentView addSubview:self.cutLine2];
    [self.cutLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.functionBarView.mas_bottom);
        make.height.offset(15);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).priorityMedium();
    }];
}

- (void)configAlreadyLessonCellWithData:(id)model
{
    if (!model) return;
    NSDictionary *dict = model;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:dict[@"head"]] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)]];
    self.dateLabel.text = dict[@"date"];
    self.locationLabel.text = dict[@"addr"];
    if ([dict[@"teachercontent"] isEqualToString:@""]) {
        self.statusLabel.text = @"去评价";
        [self.evaluateBtn setHidden:NO];
    }else{
        self.statusLabel.text = @"已完成";
        [self.evaluateBtn setHidden:YES];
    }
    self.nameLabel.text = [NSString stringWithFormat:@"%@  %@  %@",dict[@"studentname"], dict[@"grade"], dict[@"subject"]];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@/小时",dict[@"price"]];
    
    self.dictCellData = dict;
}

//课后作业
- (void)homeworkAction:(UIButton *)btn
{
    JYXCourseHomeworkViewController *vc = [[JYXCourseHomeworkViewController alloc] init];
    vc.courseId = self.dictCellData[@"id"];
    vc.type = @2;
    [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
}

//去评价
- (void)evaluateAction:(UIButton *)btn
{
    JYXAppraiseViewController *vc = [[JYXAppraiseViewController alloc] init];
    [vc setResult:self.dictCellData];
    [[JYXAppraiseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
}

//沟通
- (void)communicateAction:(UIButton *)btn
{
    UIAlertController *actionSheetController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *addoneCAction = [UIAlertAction actionWithTitle:@"电话沟通" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [TeacherWorkHandler selectXuNiPhoneNumWithPhone:[[NSUserDefaults standardUserDefaults] valueForKey:TeacherPhone] otherphone:self.dictCellData[@"phone"] prepare:^{
            
        } success:^(id obj) {
            NSDictionary *dic = (NSDictionary *)obj;
            NSString *str_phone = [[dic objectForKey:@"binding_Relation_response"] objectForKey:@"smbms"];
            NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",str_phone];
            UIWebView * callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self addSubview:callWebview];
        } failed:^(NSInteger statusCode, id json) {
            
        }];
    }];
    
    UIAlertAction *addtwoCAction = [UIAlertAction actionWithTitle:@"在线沟通" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RCConversationViewController *vc = [[RCConversationViewController alloc] init];
        vc.conversationType = ConversationType_PRIVATE;
        vc.targetId = self.dictCellData[@"longid"];
        vc.title = self.dictCellData[@"studentname"];
        [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionSheetController addAction:addoneCAction];
    [actionSheetController addAction:addtwoCAction];
    [actionSheetController addAction:cancelAction];
    [[JYXBaseViewController getCurrentVC] presentViewController:actionSheetController animated:YES completion:nil];
}

#pragma mark-- setter getter method
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor colorWithHex:0x000000];
        _dateLabel.font = FONT_SIZE(14);
    }
    return _dateLabel;
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
        _avatarImg.backgroundColor = [UIColor randomColor];
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
        _locationLabel.textColor = [UIColor colorWithHex:0x000000];
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
        _statusLabel.font = FONT_SIZE(13);
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
        _nameLabel.textColor = [UIColor colorWithHex:0x000000];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = FONT_SIZE(14);
        _priceLabel.textColor = [UIColor colorWithHex:0x000000];
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

- (UIButton *)prepareWorkBtn
{
    if (!_prepareWorkBtn) {
        _prepareWorkBtn = [[UIButton alloc] init];
        JYXViewBorderRadius(_prepareWorkBtn, 13, 1, [UIColor colorWithHex:0x1aabfd]);
        [_prepareWorkBtn setTitle:NSLocalizedString(@"课后作业", nil) forState:UIControlStateNormal];
        _prepareWorkBtn.titleLabel.font = FONT_SIZE(15);
        [_prepareWorkBtn setTitleColor:[UIColor colorWithHex:0x1aabfd] forState:UIControlStateNormal];
        [_prepareWorkBtn sizeToFit];
        [_prepareWorkBtn addTarget:self action:@selector(homeworkAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _prepareWorkBtn;
}

- (UIButton *)evaluateBtn
{
    if (!_evaluateBtn) {
        _evaluateBtn = [[UIButton alloc] init];
        JYXViewBorderRadius(_evaluateBtn, 13, 1, [UIColor colorWithHex:0x1aabfd]);
        [_evaluateBtn setTitle:NSLocalizedString(@"去评价", nil) forState:UIControlStateNormal];
        _evaluateBtn.titleLabel.font = FONT_SIZE(15);
        [_evaluateBtn setTitleColor:[UIColor colorWithHex:0x1aabfd] forState:UIControlStateNormal];
        [_evaluateBtn sizeToFit];
        [_evaluateBtn addTarget:self action:@selector(evaluateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaluateBtn;
}

- (UIButton *)communicateBtn
{
    if (!_communicateBtn) {
        _communicateBtn = [[UIButton alloc] init];
        JYXViewBorderRadius(_communicateBtn, 13, 1, [UIColor colorWithHex:0x1aabfd]);
        [_communicateBtn setTitle:NSLocalizedString(@"沟通", nil) forState:UIControlStateNormal];
        _communicateBtn.titleLabel.font = FONT_SIZE(15);
        [_communicateBtn setTitleColor:[UIColor colorWithHex:0x1aabfd] forState:UIControlStateNormal];
        [_communicateBtn sizeToFit];
        [_communicateBtn addTarget:self action:@selector(communicateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _communicateBtn;
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

