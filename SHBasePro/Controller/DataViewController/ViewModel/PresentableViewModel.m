//
//  PresentableViewModel.m
//  SHBasePro
//
//  Created by shenghai on 2016/12/20.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "PresentableViewModel.h"

@implementation PresentableViewModel


- (instancetype) initWithData: (MovieModel*) data {
    if (self = [super init]) {
        self.title = [self dealLogicTitle: data.title];
        self.thumbnailUrl = data.image;
    }
    return self;
}

- (NSString*) dealLogicTitle: (NSString*) titleStr {
    NSString* dealdTitle = [@"sheng " stringByAppendingString: titleStr];
    return dealdTitle;
}

- (void) updateTitleLabel: (UILabel*) label {
    label.text = self.title;
}

- (void) updateImageView:(UIImageView *)imageView {
    [imageView sd_setImageWithURL: [NSURL URLWithString: self.thumbnailUrl] placeholderImage: [UIImage imageNamed:@"picture_"] options:SDWebImageCacheMemoryOnly];
}

@end
