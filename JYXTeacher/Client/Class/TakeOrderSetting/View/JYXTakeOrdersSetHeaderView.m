//
//  JYXTakeOrdersSetHeaderView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/17.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXTakeOrdersSetHeaderView.h"
#import "JYXGradeSubjectViewController.h"
#import "JYXSelectedGradeSubjectCollectionViewCell.h"
#import "UICollectionViewLeftAlignedLayout.h"

@interface JYXTakeOrdersSetHeaderView ()<UICollectionViewDelegate, UICollectionViewDataSource>


@end

@implementation JYXTakeOrdersSetHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self.contentView addSubview:self.gradeSubjectSelectBgView];
    [self.gradeSubjectSelectBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(7);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-7);
        make.height.offset(45);
    }];
    
    [self.gradeSubjectSelectBgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gradeSubjectSelectBgView).offset(15);
        make.centerY.equalTo(self.gradeSubjectSelectBgView);
    }];
    
    [self.gradeSubjectSelectBgView addSubview:self.arrowImg];
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.gradeSubjectSelectBgView).offset(-15);
        make.centerY.equalTo(self.gradeSubjectSelectBgView);
        make.height.offset(14);
        make.width.offset(8);
    }];
    
    [self.contentView addSubview:self.gradeSubjectBgView];
    [self.gradeSubjectBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(7);
        make.top.equalTo(self.gradeSubjectSelectBgView.mas_bottom).offset(2);
        make.right.equalTo(self.contentView).offset(-7);
        make.height.offset(117);
    }];
    
    [self.gradeSubjectBgView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gradeSubjectBgView).offset(20);
        make.top.equalTo(self.gradeSubjectBgView).offset(20);
        make.right.equalTo(self.gradeSubjectBgView).offset(-20);
        make.bottom.equalTo(self.gradeSubjectBgView).offset(-20);
    }];
    
    [self.gradeSubjectBgView addSubview:self.emptyPageLabel];
    [self.emptyPageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.gradeSubjectBgView);
    }];
}

- (void)configTakeOrdersSetHeaderView
{
    self.titleLabel.text = @"授课年级科目（必填）";
}

- (void)contentCellWithDataArr:(NSArray *)arr{
    self.dataArray = arr;
    if (self.dataArray.count > 0) {
        self.emptyPageLabel.hidden = YES;
    } else {
        self.emptyPageLabel.hidden = NO;
    }
    [self.collectionView reloadData];
}

//授课年级科目选择
- (void)gradeSubjectAction:(UITapGestureRecognizer *)tap
{
    JYXGradeSubjectViewController *vc = [[JYXGradeSubjectViewController alloc] init];
    WeakSelf(weakSelf);
    [vc setSelectedGradeSubjectBlock:^(NSArray *array, NSString *jsonString) {
        weakSelf.jsonString = jsonString;
        weakSelf.dataArray = array;
        [weakSelf.collectionView reloadData];
        if (array.count > 0) {
            weakSelf.emptyPageLabel.hidden = YES;
        } else {
            weakSelf.emptyPageLabel.hidden = NO;
        }
    }];
    [[JYXBaseViewController getCurrentVC].navigationController pushViewController:vc animated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JYXSelectedGradeSubjectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JYXSelectedGradeSubjectCollectionViewCell class]) forIndexPath:indexPath];
    [cell configSelectedGradeSubjectCellWithData:self.dataArray[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [JYXSelectedGradeSubjectCollectionViewCell cellWithTitle:_dataArray[indexPath.row]];
}

- (UIView *)gradeSubjectSelectBgView
{
    if (!_gradeSubjectSelectBgView) {
        _gradeSubjectSelectBgView = [[UIView alloc] init];
        _gradeSubjectSelectBgView.backgroundColor = [UIColor whiteColor];
        JYXViewBorderRadius(_gradeSubjectSelectBgView, 5, 0, [UIColor clearColor]);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gradeSubjectAction:)];
        [_gradeSubjectSelectBgView addGestureRecognizer:tap];
    }
    return _gradeSubjectSelectBgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = FONT_SIZE(17);
        _titleLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] init];
        _arrowImg.contentMode = UIViewContentModeScaleAspectFit;
        _arrowImg.image = [UIImage imageNamed:@"rightArrow"];
    }
    return _arrowImg;
}

- (UIView *)gradeSubjectBgView
{
    if (!_gradeSubjectBgView) {
        _gradeSubjectBgView = [[UIView alloc] init];
        _gradeSubjectBgView.backgroundColor = [UIColor whiteColor];
        JYXViewBorderRadius(_gradeSubjectBgView, 5, 0, [UIColor clearColor]);
    }
    return _gradeSubjectBgView;
}

- (UILabel *)emptyPageLabel
{
    if (!_emptyPageLabel) {
        _emptyPageLabel = [[UILabel alloc] init];
        _emptyPageLabel.text = @"未选择年级科目";
        _emptyPageLabel.font = FONT_SIZE(15);
        _emptyPageLabel.textColor = [UIColor colorWithHex:0x5d5d5d];
        [_emptyPageLabel sizeToFit];
    }
    return _emptyPageLabel;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
        layout.minimumLineSpacing  = 12;
        layout.minimumInteritemSpacing  = 12;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[JYXSelectedGradeSubjectCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JYXSelectedGradeSubjectCollectionViewCell class])];
    }
    return _collectionView;
}

@end

