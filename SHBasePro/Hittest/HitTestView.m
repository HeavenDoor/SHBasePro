//
//  HitTestView.m
//  NetWork
//
//  Created by shenghai on 16/5/19.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "HitTestView.h"



@interface ggView()
//@property (nonatomic,strong) NSString* defg;
@end



@implementation ggView

- (void) mm
{
     NSLog(@"test mm");
    if ([self.delegate respondsToSelector:@selector(testDel)])
    {
        [self.delegate testDel];
        [self.delegate testDel];
    }
}
@end



@interface HitTestView()<ddDelegate> //扩展
{
    UIButton* closeBtn;
}
@property (nonatomic,strong) NSString* def;
@end


@implementation HitTestView


- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage* image = [UIImage imageNamed:@"本店"];
        [closeBtn setImage:image forState:UIControlStateNormal];
        
        [closeBtn addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        closeBtn.frame = CGRectMake(frame.size.width - image.size.width/2, -image.size.height/2, image.size.width, image.size.height);
        [self addSubview:closeBtn];
        ggView * view = [[ggView alloc] init];
        view.delegate = self;
        [view mm];
        
    }
    
    return self;
}

- (void) testDel
{
    NSLog(@"test del");
}


- (void) kk
{
    NSLog(@"test kk");
}

- (void) clicked: (UIButton*) sender
{
    NSLog(@"hit...");
    _abc = @"456";
}

- (UIView*) hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView* result = [super hitTest:point withEvent: event];
    CGPoint buttonPoint = [closeBtn convertPoint:point fromView:self];
    if ([closeBtn pointInside:buttonPoint withEvent:event]) {
        return closeBtn;
    }
    
    return result;
    
    
}

- (void) setAbc:(NSString *)abc
{
    
}


- (void) setDef:(NSString *)def
{
    
}

@end
