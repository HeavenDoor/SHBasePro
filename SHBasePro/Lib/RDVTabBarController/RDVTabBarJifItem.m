//
//  RDVTabBarJifItem.m
//  SHBasePro
//
//  Created by shenghai on 16/9/1.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "RDVTabBarJifItem.h"
#import "UIImage+GIF.h"
#import "Masonry.h"

@interface RDVTabBarJifItem()

@property (nonatomic, strong) UIImageView* backeGroundImageView;
@property (nonatomic, strong) UIImageView* foreGtoundImageView;
@property (nonatomic, strong) NSArray *gifArray;
@end



@implementation RDVTabBarJifItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self commonInitialization];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self commonInitialization];
    }
    return self;
}

- (void)commonInitialization
{
    // Setup defaults
    self.gifArray = [NSArray arrayWithObjects:
                         [UIImage imageNamed:@"dh1_"],
                         [UIImage imageNamed:@"dh2_"],
                         [UIImage imageNamed:@"dh3_"],
                         [UIImage imageNamed:@"dh4_"],
                         [UIImage imageNamed:@"dh5_"],
                         [UIImage imageNamed:@"dh6_"],
                         [UIImage imageNamed:@"dh7_"],
                         [UIImage imageNamed:@"dh7_"],
                         [UIImage imageNamed:@"dh7_"],
                         [UIImage imageNamed:@"dh7_"],nil];
    
    
    [self setBackgroundColor:[UIColor clearColor]];  // clearColor
    UIImage* backGroundImage = [[UIImage imageNamed:@"yybeibu_"] stretchableImageWithLeftCapWidth:0 topCapHeight:20]; //camback
    self.backeGroundImageView = [[UIImageView alloc] init];
    [self addSubview:self.backeGroundImageView];
    self.backeGroundImageView.image = backGroundImage;
    [self.backeGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom);
        make.width.mas_equalTo(backGroundImage.size.width);
        make.height.mas_equalTo(backGroundImage.size.height);
    }];
//    
    UIImage* foreGroundImage = [UIImage sd_animatedGIFNamed:@"yyqiangdan"];
    NSLog(@"width === %lf", self.width);
    NSLog(@"imgWidth === %lf", foreGroundImage.size.width);
    self.foreGtoundImageView = [[UIImageView alloc] init];
    self.foreGtoundImageView.image = foreGroundImage;// self.width/2 - foreGroundImage.size.width/2
    
    self.foreGtoundImageView.animationImages = self.gifArray;
    self.foreGtoundImageView.animationDuration = 1.4;
    self.foreGtoundImageView.animationRepeatCount = 0;
    
    [self.foreGtoundImageView startAnimating];
    
    [self addSubview:self.foreGtoundImageView];
    [self.foreGtoundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(-2);
        make.width.equalTo(self.mas_height).offset(-5);
        make.height.equalTo(self.mas_height).offset(-5);
    }];
    
    [self bringSubviewToFront:self.foreGtoundImageView];
}

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (void) showJifType
{
    self.foreGtoundImageView.animationImages = self.gifArray;
    self.foreGtoundImageView.animationDuration = 1.4;
    self.foreGtoundImageView.animationRepeatCount = 0;
    
    [self.foreGtoundImageView startAnimating];

    //[self.foreGtoundImageView setImage: foreGroundImage];
}

- (void) showNormalType
{
    [self.foreGtoundImageView stopAnimating];
    [self.foreGtoundImageView setImage:[UIImage imageNamed:@"camHighlight"]];  // yyqiangdan_
}


- (void)drawRect:(CGRect)rect
{

    
}

@end
