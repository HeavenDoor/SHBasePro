//
//  HitTestView.h
//  NetWork
//
//  Created by shenghai on 16/5/19.
//  Copyright © 2016年 ren. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ddDelegate <NSObject>

@required
- (void) testDel;

@end


@interface HitTestView : UIView
@property (nonatomic,strong) NSString* abc;
- (void) kk;

@end


@interface ggView : NSObject
@property (nonatomic, assign) id<ddDelegate> delegate;
- (void) mm;
//@property (nonatomic,strong) NSString* defg;
@end