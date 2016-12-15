//
//  DataCell.m
//  SHBasePro
//
//  Created by mac on 16/9/4.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "DataCell.h"
#import "UIImageView+WebCache.h"
#import "masonry.h"

@interface DataCell()
@property (nonatomic, strong) UIImageView* movieImageView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* subTitleLabel;
@end

@implementation DataCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = kColor(150, 150, 150);
    [self configSubViews];
    return self;
}

- (void) setCellData:(MovieModel *)cellData
{
    _cellData = cellData;
    self.titleLabel.text = cellData.title;
    [self.movieImageView sd_setImageWithURL:[NSURL URLWithString:cellData.image] placeholderImage:[UIImage imageNamed:@"picture_"] options:SDWebImageRefreshCached];
}

- (void) configSubViews
{
    self.movieImageView = [[UIImageView alloc] init];
    [self addSubview:self.movieImageView];
    [self.movieImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kUIScaleSize(10));
        make.top.equalTo(self.mas_top).offset(kUIScaleSize(8));
        make.bottom.equalTo(self.mas_bottom).offset(-kUIScaleSize(10));
        make.width.equalTo(self.movieImageView.mas_height).multipliedBy(1.6);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = kColor(40, 40, 40);
    self.titleLabel.font = [UIFont systemFontOfSize:kFontScaleSize(18)];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.movieImageView.mas_right).offset(kUIScaleSize(8));
        make.top.equalTo(self.movieImageView.mas_top);
        make.right.equalTo(self.mas_right).offset(-kUIScaleSize(5));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
