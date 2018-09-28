//
//  LocationTableViewCell.m
//  GouKuSeller
//
//  Created by 窦建斌 on 2018/5/7.
//  Copyright © 2018年 窦建斌. All rights reserved.
//

#import "LocationTableViewCell.h"

@implementation LocationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.lab_name = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 36)];
        [self.contentView addSubview:self.lab_name];
        [self.lab_name setTextColor:[UIColor colorWithHexString:@"#000000"]];
        [self.lab_name setFont:[UIFont systemFontOfSize:14]];
        
        self.lab_address = [[UILabel alloc]initWithFrame:CGRectMake(15, self.lab_name.bottom - 5, SCREEN_WIDTH - 30, 17)];
        [self.contentView addSubview:self.lab_address];
        [self.lab_address setTextColor:[UIColor colorWithHexString:@"#616161"]];
        [self.lab_address setFont:[UIFont systemFontOfSize:12]];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
