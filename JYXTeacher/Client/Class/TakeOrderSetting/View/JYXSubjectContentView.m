//
//  JYXSubjectContentView.m
//  JYXTeacher
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 JYX. All rights reserved.
//

#import "JYXSubjectContentView.h"
#import "JYXGradeSubjectCollectionViewCell.h"
#import "JYXGradeSubjectModel.h"

@interface JYXSubjectContentView ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) JYXGradeSubjectModel *dataModel;
@property (nonatomic, strong) UIImageView *verticalBarView;
@property (nonatomic, strong) UILabel *gradeSubjectLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIImageView *line;
@end

@implementation JYXSubjectContentView
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
    [self addSubview:self.verticalBarView];
    [self.verticalBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(17);
        make.top.equalTo(self).offset(15);
        make.height.offset(21);
        make.width.offset(10);
    }];
    
    [self addSubview:self.gradeSubjectLabel];
    [self.gradeSubjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.verticalBarView.mas_right).offset(6);
        make.centerY.equalTo(self.verticalBarView);
    }];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(17);
        make.right.equalTo(self).offset(-17);
        make.top.equalTo(self.verticalBarView.mas_bottom).offset(20);
        make.bottom.equalTo(self).offset(-20).priorityMedium();
    }];
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.offset(1);
    }];
}

- (void)configSubjectViewWithData:(id)model
{
    if (!model) return;
    self.dataModel = model;
    [self.collectionView reloadData];
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(self.collectionView.collectionViewLayout.collectionViewContentSize.height);
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JYXGradeSubjectChildrenModel *model = self.dataModel.children[indexPath.row];
    if (model.isSelected.boolValue) {
        model.isSelected = @0;
    } else {
        model.isSelected = @1;
    }
    //每个年级只能选择一个
    for (JYXGradeSubjectChildrenModel *model in self.dataModel.children) {
        if (model.label != self.dataModel.children[indexPath.row].label) {
            model.isSelected = @0;
        }
    }
    [collectionView reloadData];
    if (self.selectedSubjectBlock) {
        self.selectedSubjectBlock();
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataModel.children.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JYXGradeSubjectCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JYXGradeSubjectCollectionViewCell class]) forIndexPath:indexPath];
    cell.titleLabel.font = FONT_SIZE(14);
    JYXViewBorderRadius(cell.titleLabel, 15, 1, [UIColor colorWithHex:0x1aabfd]);
    JYXGradeSubjectChildrenModel *model = self.dataModel.children[indexPath.row];
    if (!model.isSelected.boolValue) {
        cell.titleLabel.backgroundColor = [UIColor whiteColor];
        cell.titleLabel.textColor = [UIColor colorWithHex:0x1aabfd];
    } else {
        cell.titleLabel.backgroundColor = [UIColor colorWithHex:0x1aabfd];
        cell.titleLabel.textColor = [UIColor whiteColor];
    }
    [cell configGradeSubjectCellWithData:self.dataModel.children[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 30);
}

- (UIImageView *)verticalBarView
{
    if (!_verticalBarView) {
        _verticalBarView = [[UIImageView alloc] init];
        _verticalBarView.image = [UIImage imageNamed:@"VerticalBar"];
    }
    return _verticalBarView;
}

- (UILabel *)gradeSubjectLabel
{
    if (!_gradeSubjectLabel) {
        _gradeSubjectLabel = [[UILabel alloc] init];
        _gradeSubjectLabel.text = @"授课科目";
        _gradeSubjectLabel.font = FONT_SIZE(18);
        _gradeSubjectLabel.textColor = [UIColor colorWithHex:0x1aabfd];
        [_gradeSubjectLabel sizeToFit];
    }
    return _gradeSubjectLabel;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 15;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.allowsMultipleSelection = YES;
        
        [_collectionView registerClass:[JYXGradeSubjectCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JYXGradeSubjectCollectionViewCell class])];
    }
    return _collectionView;
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor colorWithHex:0xf3f3f3];
    }
    return _line;
}

@end
