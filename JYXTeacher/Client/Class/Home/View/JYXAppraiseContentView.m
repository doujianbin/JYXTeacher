//
//  JYXAppraiseContentView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/25.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXAppraiseContentView.h"
#import "JYXAppraiseLabelCollectionViewCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "TeacherWorkHandler.h"

@interface JYXAppraiseContentView ()<UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>
{
    NSArray *_labelArray;
}
@property (nonatomic, strong) UIImageView *verticalBarImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *avatarImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *gradeSubjectLabel;
@property (nonatomic, strong) UIButton *goodReputationBtn;//好评
@property (nonatomic, strong) UIButton *mediumReviewBtn;//中评
@property (nonatomic, strong) UIButton *negativeCommentBtn;//差评
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UILabel *wordNumberLabel;
@property (nonatomic, strong) UIButton *submitBtn;

@property (nonatomic, assign) int reviewIndex;          //1好评2中评3差评

@property (nonatomic, strong) NSMutableArray *selectedLabelMArray;
@property (nonatomic, strong) NSString *classId;
@end

@implementation JYXAppraiseContentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    self.reviewIndex = 1;
    [self addSubview:self.verticalBarImg];
    [self.verticalBarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(9);
        make.top.equalTo(self).offset(10);
        make.width.offset(6);
        make.height.offset(17);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verticalBarImg.mas_right).offset(3);
        make.centerY.equalTo(self.verticalBarImg);
    }];
    
    [self addSubview:self.avatarImg];
    [self.avatarImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(Iphone6ScaleWidth(34));
        make.top.equalTo(self.verticalBarImg.mas_bottom).offset(25);
        make.height.width.offset(56);
    }];
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avatarImg.mas_right).offset(Iphone6ScaleHeight(20));
        make.top.equalTo(self.avatarImg);
    }];
    
    [self addSubview:self.gradeSubjectLabel];
    [self.gradeSubjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(Iphone6ScaleWidth(64));
        make.centerY.equalTo(self.nameLabel);
    }];
    
    [self addSubview:self.goodReputationBtn];
    [self.goodReputationBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:2];
    [self.goodReputationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel).offset(-5);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(20);
    }];
    
    [self addSubview:self.mediumReviewBtn];
    [self.mediumReviewBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:2];
    [self.mediumReviewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodReputationBtn.mas_right).offset(Iphone6ScaleWidth(48));
        make.centerY.equalTo(self.goodReputationBtn);
    }];
    
    [self addSubview:self.negativeCommentBtn];
    [self.negativeCommentBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:2];
    [self.negativeCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mediumReviewBtn.mas_right).offset(Iphone6ScaleWidth(48));
        make.centerY.equalTo(self.goodReputationBtn);
    }];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(14);
        make.top.equalTo(self.avatarImg.mas_bottom).offset(48);
        make.right.equalTo(self).offset(-14);
    }];
    
    [self addSubview:self.contentTextView];
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7);
        make.top.equalTo(self.collectionView.mas_bottom).offset(28);
        make.right.equalTo(self).offset(-7);
        make.height.offset(136);
    }];
    
    [self addSubview:self.wordNumberLabel];
    [self.wordNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentTextView).offset(-5);
    }];
    
    [self addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-14-kAddBottomHeight);
        make.centerX.equalTo(self);
        make.height.offset(37);
        make.width.offset(192);
        make.top.equalTo(self.contentTextView.mas_bottom).offset(100);
    }];
}

- (void)configAppraiseViewWithData:(id)model
{
    if (!model) return;
    NSDictionary *dict = model;
    self.nameLabel.text = dict[@"name"];
    self.gradeSubjectLabel.text = [NSString stringWithFormat:@" %@ ",dict[@"gradeSubject"]];
    [self.avatarImg sd_setImageWithURL:[NSURL URLWithString:dict[@"avatar"]] placeholderImage:[UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 200)]];
    self.classId = [dict objectForKey:@"classid"];
    NSArray *labelArray = dict[@"label"];
    _labelArray = labelArray;
    [self.collectionView reloadData];
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(self.collectionView.collectionViewLayout.collectionViewContentSize.height);
    }];
    
}

//提交评价
- (void)submitAction:(UIButton *)btn
{
    //    if (self.submitAppraiseBlock) {
    //        self.submitAppraiseBlock(@{});
    //    }
    if (_selectedLabelMArray.count <= 0) {
        [MBProgressHUD showInfoMessage:@"请选择标签"];
        return;
    }
    if ([self.contentTextView.text isEqualToString:@""]) {
        [MBProgressHUD showInfoMessage:@"请填写评价"];
        return;
    }
    NSString *str_biaoqian = @"";
    for (int i = 0; i < _selectedLabelMArray.count; i++) {
        NSString *str = [[_selectedLabelMArray objectAtIndex:i] objectForKey:@"id"];
        str_biaoqian = [str_biaoqian stringByAppendingString:[NSString stringWithFormat:@"%@,",str]];
    }
    NSLog(@" ===  %@",str_biaoqian);
    
    [TeacherWorkHandler teacherAddReviewWithClassId:self.classId teachercomment:[NSString stringWithFormat:@"%d",self.reviewIndex] teachercontent:self.contentTextView.text teacherlabel:str_biaoqian prepare:^{
        
    } success:^(id obj) {
        [MBProgressHUD showSuccessMessage:@"提交成功!"];
//        WeakSelf(weakSelf);
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0/*延迟执行时间*/ * NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [[JYXBaseViewController getCurrentVC].navigationController popViewControllerAnimated:YES];
        });
    } failed:^(NSInteger statusCode, id json) {
        
    }];
}

//评价
- (void)evaluateAction:(UIButton *)btn
{
    self.goodReputationBtn.selected = NO;
    self.mediumReviewBtn.selected = NO;
    self.negativeCommentBtn.selected = NO;
    
    btn.selected = YES;
    switch (btn.tag) {
        case 1://好评
        {
            self.reviewIndex = 1;
            //            self.goodReputationBtn.selected = YES;
        }
            break;
        case 2://中评
        {
            self.reviewIndex = 2;
            //            self.mediumReviewBtn.selected = YES;
        }
            break;
        case 3://差评
        {
            self.reviewIndex = 3;
            //            self.negativeCommentBtn.selected = YES;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark        textViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""] && range.length > 0) {
        //删除字符肯定是安全的
        return YES;
    } else {
        
        if (textView.text.length - range.length + text.length > 300) {
            [MBProgressHUD showInfoMessage:@"不能超过300个字"];
            return NO;
        } else {
            return YES;
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 300) {
        textView.text = [textView.text substringToIndex:300];
    }
    
    self.wordNumberLabel.text = [NSString stringWithFormat:@"%ld/300",textView.text.length];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JYXAppraiseLabelCollectionViewCell *cell = (JYXAppraiseLabelCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.titleLabel.backgroundColor = [UIColor colorWithHex:0x1aabfd];
    cell.titleLabel.textColor = [UIColor whiteColor];
    [self.selectedLabelMArray addObject:_labelArray[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JYXAppraiseLabelCollectionViewCell *cell = (JYXAppraiseLabelCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.titleLabel.backgroundColor = [UIColor whiteColor];
    cell.titleLabel.textColor = [UIColor colorWithHex:0x1aabfd];
    [self.selectedLabelMArray removeObject:_labelArray[indexPath.row]];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JYXAppraiseLabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JYXAppraiseLabelCollectionViewCell class]) forIndexPath:indexPath];
    [cell configAppraiseLabelCellWithData:_labelArray[indexPath.row]];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _labelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [JYXAppraiseLabelCollectionViewCell cellWithTitle:_labelArray[indexPath.row]];
}

- (UIImageView *)verticalBarImg
{
    if (!_verticalBarImg) {
        _verticalBarImg = [[UIImageView alloc] init];
        _verticalBarImg.image = [UIImage imageNamed:@"VerticalBar"];
    }
    return _verticalBarImg;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = NSLocalizedString(@"学生", nil);
        _titleLabel.font = FONT_SIZE(16);
        _titleLabel.textColor = [UIColor colorWithHex:0x6d6d6d];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UIImageView *)avatarImg
{
    if (!_avatarImg) {
        _avatarImg = [[UIImageView alloc] init];
        _avatarImg.backgroundColor = [UIColor randomColor];
        _avatarImg.contentMode = UIViewContentModeScaleAspectFill;
        JYXViewBorderRadius(_avatarImg, 56/2.0, 0, [UIColor clearColor]);
        [_avatarImg sizeToFit];
    }
    return _avatarImg;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor colorWithHex:0x414141];
        _nameLabel.font = FONT_SIZE(14);
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UILabel *)gradeSubjectLabel
{
    if (!_gradeSubjectLabel) {
        _gradeSubjectLabel = [[UILabel alloc] init];
        _gradeSubjectLabel.textColor = [UIColor colorWithHex:0x1aabfd];
        _gradeSubjectLabel.font = FONT_SIZE(14);
        [_gradeSubjectLabel sizeToFit];
        JYXViewBorderRadius(_gradeSubjectLabel, 5, 1, [UIColor colorWithHex:0x1aabfd]);
    }
    return _gradeSubjectLabel;
}

- (UIButton *)goodReputationBtn
{
    if (!_goodReputationBtn) {
        _goodReputationBtn = [[UIButton alloc] init];
        _goodReputationBtn.selected = YES;
        _goodReputationBtn.tag = 1;
        [_goodReputationBtn setImage:[UIImage imageNamed:@"goodReputation"] forState:UIControlStateNormal];
        [_goodReputationBtn setImage:[UIImage imageNamed:@"goodReputation_Sel"] forState:UIControlStateSelected];
        [_goodReputationBtn setTitle:NSLocalizedString(@"好评", nil) forState:UIControlStateNormal];
        [_goodReputationBtn setTitleColor:[UIColor colorWithHex:0x414141] forState:UIControlStateNormal];
        _goodReputationBtn.titleLabel.font = FONT_SIZE(12);
        [_goodReputationBtn sizeToFit];
        [_goodReputationBtn addTarget:self action:@selector(evaluateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goodReputationBtn;
}

- (UIButton *)mediumReviewBtn
{
    if (!_mediumReviewBtn) {
        _mediumReviewBtn = [[UIButton alloc] init];
        _mediumReviewBtn.tag = 2;
        [_mediumReviewBtn setImage:[UIImage imageNamed:@"mediumReview"] forState:UIControlStateNormal];
        [_mediumReviewBtn setImage:[UIImage imageNamed:@"mediumReview_Sel"] forState:UIControlStateSelected];
        [_mediumReviewBtn setTitle:NSLocalizedString(@"中评", nil) forState:UIControlStateNormal];
        [_mediumReviewBtn setTitleColor:[UIColor colorWithHex:0x414141] forState:UIControlStateNormal];
        _mediumReviewBtn.titleLabel.font = FONT_SIZE(12);
        [_mediumReviewBtn sizeToFit];
        [_mediumReviewBtn addTarget:self action:@selector(evaluateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mediumReviewBtn;
}

- (UIButton *)negativeCommentBtn
{
    if (!_negativeCommentBtn) {
        _negativeCommentBtn = [[UIButton alloc] init];
        _negativeCommentBtn.tag = 3;
        [_negativeCommentBtn setImage:[UIImage imageNamed:@"negativeComment"] forState:UIControlStateNormal];
        [_negativeCommentBtn setImage:[UIImage imageNamed:@"negativeComment_Sel"] forState:UIControlStateSelected];
        [_negativeCommentBtn setTitle:NSLocalizedString(@"差评", nil) forState:UIControlStateNormal];
        [_negativeCommentBtn setTitleColor:[UIColor colorWithHex:0x414141] forState:UIControlStateNormal];
        _negativeCommentBtn.titleLabel.font = FONT_SIZE(12);
        [_negativeCommentBtn sizeToFit];
        [_negativeCommentBtn addTarget:self action:@selector(evaluateAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _negativeCommentBtn;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        layout.minimumLineSpacing = 15;
        layout.minimumInteritemSpacing  = 15;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = YES;
        
        [_collectionView registerClass:[JYXAppraiseLabelCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JYXAppraiseLabelCollectionViewCell class])];
    }
    return _collectionView;
}

- (UITextView *)contentTextView
{
    if (!_contentTextView) {
        _contentTextView = [[UITextView alloc] init];
        _contentTextView.placeholder = NSLocalizedString(@"说说你的上课体验,分享给更多的同学吧。", nil);
        _contentTextView.font = FONT_SIZE(13);
        _contentTextView.textColor = [UIColor colorWithHex:0x414141];
        _contentTextView.backgroundColor = [UIColor colorWithHex:0xF8FDFF];
        JYXViewBorderRadius(_contentTextView, 5, 1, [UIColor colorWithHex:0xeeeeee]);
        _contentTextView.delegate = self;
    }
    return _contentTextView;
}

- (UILabel *)wordNumberLabel
{
    if (!_wordNumberLabel) {
        _wordNumberLabel = [[UILabel alloc] init];
        _wordNumberLabel.text = @"0/300";
        _wordNumberLabel.font = FONT_SIZE(13);
        _wordNumberLabel.textColor = [UIColor colorWithHex:0xc1c1c1];
        [_wordNumberLabel sizeToFit];
    }
    return _wordNumberLabel;
}

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:NSLocalizedString(@"提交评价", nil) forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = FONT_SIZE(18);
        JYXViewBorderRadius(_submitBtn, 10, 0, [UIColor clearColor]);
        [_submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

- (NSMutableArray *)selectedLabelMArray
{
    if (!_selectedLabelMArray) {
        _selectedLabelMArray = [NSMutableArray array];
    }
    return _selectedLabelMArray;
}

@end

