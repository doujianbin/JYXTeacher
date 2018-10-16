//
//  JYXWaitLessonTableViewCell.m
//  JYXTeacher
//
//  Created by apple on 2018/8/16.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXWaitLessonTableViewCell.h"
#import "JYXCourseHomeworkViewController.h"
#import "JYXHomeTeacherCourseStatuApi.h"
#import "TeacherWorkHandler.h"

@interface JYXWaitLessonTableViewCell ()
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
@property (nonatomic, strong) UIButton *prepareWorkBtn;//预习作业
@property (nonatomic, strong) UIButton *completeBtn;//完成
@property (nonatomic, strong) UIButton *communicateBtn;//沟通
@property (nonatomic, strong) NSString *address;//终点地址

@end

@implementation JYXWaitLessonTableViewCell

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
        make.width.offset(60);
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
    
    [self.contentView addSubview:self.completeBtn];
    [self.completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.communicateBtn.mas_left).offset(-9);
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

- (void)configWaitLessonCellWithData:(id)model
{
    if (!model) return;
    NSDictionary *dict = model;
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:dict[@"head"]] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)]];
    self.dateLabel.text = dict[@"date"];
    self.locationLabel.text = dict[@"addr"];
    self.statusLabel.text = dict[@"from"];
    self.nameLabel.text = [NSString stringWithFormat:@"%@  %@  %@",dict[@"studentname"], dict[@"grade"], dict[@"subject"]];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@/小时",dict[@"price"]];
    self.address = dict[@"addr"];
    self.dictCellData = dict;
}

//课前作业
- (void)prepareHomeworkAction:(UIButton *)btn
{
    JYXCourseHomeworkViewController *vc = [[JYXCourseHomeworkViewController alloc] init];
    vc.courseId = self.dictCellData[@"id"];
    vc.type = @1;
    [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
}

//完成
- (void)completeAction:(UIButton *)btn
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:NSLocalizedString(@"是否完成？", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
    WeakSelf(weakSelf);
    UIAlertAction *ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        StrongSelf(strongSelf);
        JYXUser *user = [JYXUserManager shareInstance].user;
        JYXHomeTeacherCourseStatuApi *api = [[JYXHomeTeacherCourseStatuApi alloc] initWithUserid:user.userId WithToken:user.token courseId:strongSelf.dictCellData[@"id"] type:@"1"];
        [SVProgressHUD show];
        [api sendRequestWithCompletionBlockWithSuccess:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
            if (self.deleteCellBlock) {
                self.deleteCellBlock(strongSelf.dictCellData);
            }
        } failure:^(__kindof RXBaseRequest *request) {
            [SVProgressHUD dismiss];
        }];
        
    }];
    [alert addAction:cancel];
    [alert addAction:ok];
    [kAppDelegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
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

- (void)addressAction{
    [self openAlert];
}



- (void)openAlert{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"导航功能",@"nav123456",[[self.dictCellData objectForKey:@"lat"] doubleValue],[[self.dictCellData objectForKey:@"long"] doubleValue]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }else{

       CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake([[self.dictCellData objectForKey:@"lat"] doubleValue], [[self.dictCellData objectForKey:@"long"] doubleValue]);

       MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];

       MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];

       toLocation.name = self.address;

       [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:
                                                                                       MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
   }
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
        _locationLabel.textColor = [UIColor colorWithHex:0x000000];
        _locationLabel.font = FONT_SIZE(14);
        [_locationLabel sizeToFit];
        _locationLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *addAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addressAction)];
        [_locationLabel addGestureRecognizer:addAction];
    }
    return _locationLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textColor = [UIColor colorWithHex:0xF7A94D];
        _statusLabel.font = FONT_SIZE(13);
        [_statusLabel sizeToFit];
        [_statusLabel setTextAlignment:NSTextAlignmentRight];
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
        [_prepareWorkBtn setTitle:NSLocalizedString(@"预习作业", nil) forState:UIControlStateNormal];
        _prepareWorkBtn.titleLabel.font = FONT_SIZE(15);
        [_prepareWorkBtn setTitleColor:[UIColor colorWithHex:0x1aabfd] forState:UIControlStateNormal];
        [_prepareWorkBtn sizeToFit];
        [_prepareWorkBtn addTarget:self action:@selector(prepareHomeworkAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _prepareWorkBtn;
}

- (UIButton *)completeBtn
{
    if (!_completeBtn) {
        _completeBtn = [[UIButton alloc] init];
        JYXViewBorderRadius(_completeBtn, 13, 1, [UIColor colorWithHex:0x1aabfd]);
        [_completeBtn setTitle:NSLocalizedString(@"完成", nil) forState:UIControlStateNormal];
        _completeBtn.titleLabel.font = FONT_SIZE(15);
        [_completeBtn setTitleColor:[UIColor colorWithHex:0x1aabfd] forState:UIControlStateNormal];
        [_completeBtn sizeToFit];
        [_completeBtn addTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _completeBtn;
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
