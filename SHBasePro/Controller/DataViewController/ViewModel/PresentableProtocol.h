//
//  PresentableProtocol.h
//  SHBasePro
//
//  Created by shenghai on 2016/12/20.
//  Copyright © 2016年 ren. All rights reserved.
//

#ifndef PresentableProtocol_h
#define PresentableProtocol_h

@protocol TitlePresentable;
@protocol ThumbnailPresentable;


@protocol PresentableProtocol <TitlePresentable,ThumbnailPresentable>

@end


@protocol TitlePresentable <NSObject>

@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) UIColor *titleColor;
//@property (nonatomic, copy) UIFont *titleFont;

- (void) updateTitleLabel: (UILabel*) label;

@end


@protocol ThumbnailPresentable <NSObject>

@property (nonatomic, copy) NSString *thumbnailUrl;
- (void) updateImageView: (UIImageView*) imageView;

@end
#endif /* PresentableProtocol_h */
