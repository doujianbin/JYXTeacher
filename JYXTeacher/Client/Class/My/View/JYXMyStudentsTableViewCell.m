//
//  JYXMyStudentsTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/19.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXMyStudentsTableViewCell.h"
#import "TeacherWorkHandler.h"

@interface JYXMyStudentsTableViewCell ()
{
    NSDictionary *_dataModel;
}
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *idNumberLabel;
@property (nonatomic, strong) UIImageView *creditImgView;
@property (nonatomic, strong) UILabel *creditLabel;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) UIButton *callNumberBtn;
@property (nonatomic, strong) UIButton *onlineChatBtn;
@end

@implementation JYXMyStudentsTableViewCell
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
    [self.contentView addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(27);
        make.top.equalTo(self.contentView).offset(15);
        make.width.height.offset(47);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImg.mas_right).offset(25);
        make.top.equalTo(self.avatarImg);
    }];
    
    [self.contentView addSubview:self.idNumberLabel];
    [self.idNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.avatarImg);
    }];
    
    [self.contentView addSubview:self.creditImgView];
    [self.creditImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.idNumberLabel.mas_right).offset(23);
        make.centerY.equalTo(self.idNumberLabel);
        make.height.offset(14);
        make.width.offset(13);
    }];
    
    [self.contentView addSubview:self.creditLabel];
    [self.creditLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREEN_WIDTH / 2 + 50);
        make.centerY.equalTo(self.creditImgView);
    }];
    
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.offset(1);
        make.top.equalTo(self.avatarImg.mas_bottom).offset(15);
    }];
    
    [self.contentView addSubview:self.callNumberBtn];
    [self.callNumberBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [self.callNumberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(-SCREEN_WIDTH/4);
        make.top.equalTo(self.line.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.onlineChatBtn];
    [self.onlineChatBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [self.onlineChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(SCREEN_WIDTH/4);
        make.top.equalTo(self.line.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)configMyStudentsCellWithData:(id)model
{
    if (!model) return;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:model[@"head"]] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)]];
    self.nameLabel.text = model[@"name"];
    self.idNumberLabel.text = [NSString stringWithFormat:@"ID:%@",model[@"studentid"]];
    self.creditLabel.text = [NSString stringWithFormat:@"信用:%@",model[@"credit"]];
    
    _dataModel = model;
}

//在线沟通
- (void)communicateAction:(UIButton *)btn
{
    RCConversationViewController *vc = [[RCConversationViewController alloc] init];
    vc.conversationType = ConversationType_PRIVATE;
    vc.targetId = _dataModel[@"longid"];
    vc.title = _dataModel[@"name"];
    [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
}
//电话沟通
- (void)tellAction{
    
    [TeacherWorkHandler selectXuNiPhoneNumWithPhone:[[NSUserDefaults standardUserDefaults] valueForKey:TeacherPhone] otherphone:_dataModel[@"phone"] prepare:^{
        
    } success:^(id obj) {
        NSDictionary *dic = (NSDictionary *)obj;
        NSString *str_phone = [[dic objectForKey:@"binding_Relation_response"] objectForKey:@"smbms"];
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",str_phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self addSubview:callWebview];
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

- (void)setFrame:(CGRect)frame{
    frame.origin.y += 5;
    frame.size.height -= 5;
    [super setFrame:frame];
}

- (UIImageView *)avatarImg
{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] init];
        _avatarImg.contentMode = UIViewContentModeScaleAspectFill;
        JYXViewBorderRadius(_avatarImg, 47/2.0, 0, [UIColor clearColor]);
    }
    return _avatarImg;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHex:0x797979];
        _nameLabel.font = FONT_SIZE(16);
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)idNumberLabel
{
    if (!_idNumberLabel) {
        _idNumberLabel = [[UILabel alloc] init];
        _idNumberLabel.textColor = [UIColor colorWithHex:0xa0a0a0];
        _idNumberLabel.font = FONT_SIZE(14);
        [_idNumberLabel sizeToFit];
    }
    return _idNumberLabel;
}

- (UIImageView *)creditImgView
{
    if (!_creditImgView) {
        _creditImgView = [[UIImageView alloc] init];
//        _creditImgView.image = [UIImage imageNamed:@"credit"];
        _creditImgView.image = nil;
        _creditImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _creditImgView;
}

- (UILabel *)creditLabel
{
    if (!_creditLabel) {
        _creditLabel = [[UILabel alloc] init];
        _creditLabel.textColor = [UIColor colorWithHex:0xa0a0a0];
        _creditLabel.font = FONT_SIZE(14);
        [_creditLabel sizeToFit];
    }
    return _creditLabel;
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    }
    return _line;
}

- (UIButton *)callNumberBtn
{
    if (!_callNumberBtn) {
        _callNumberBtn = [[UIButton alloc] init];
        [_callNumberBtn setTitle:NSLocalizedString(@"电话沟通", nil) forState:UIControlStateNormal];
        [_callNumberBtn setImage:[UIImage imageNamed:@"phoneCall"] forState:UIControlStateNormal];
        _callNumberBtn.titleLabel.font = FONT_SIZE(11);
        [_callNumberBtn setTitleColor:[UIColor colorWithHex:0xa0a0a0] forState:UIControlStateNormal];
        [_callNumberBtn sizeToFit];
        [_callNumberBtn addTarget:self action:@selector(tellAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callNumberBtn;
}

- (UIButton *)onlineChatBtn
{
    if (!_onlineChatBtn) {
        _onlineChatBtn = [[UIButton alloc] init];
        [_onlineChatBtn setTitle:NSLocalizedString(@"在线沟通", nil) forState:UIControlStateNormal];
        [_onlineChatBtn setImage:[UIImage imageNamed:@"onLine"] forState:UIControlStateNormal];
        _onlineChatBtn.titleLabel.font = FONT_SIZE(11);
        [_onlineChatBtn setTitleColor:[UIColor colorWithHex:0xa0a0a0] forState:UIControlStateNormal];
        [_onlineChatBtn sizeToFit];
        [_onlineChatBtn addTarget:self action:@selector(communicateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _onlineChatBtn;
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
