/*******************************************************************************
 # File        : SHRefreshHeader.m
 # Project     : SHBasePro
 # Author      : shenghai
 # Created     : 2017/3/8
 # Corporation : 成都好房通科技股份有限公司
 # Description :
 Description Logs
 -------------------------------------------------------------------------------
 # Date        : Change Date
 # Author      : Change Author
 # Notes       :
 Change Logs
 ******************************************************************************/

#import "SHRefreshHeader.h"

@interface SHRefreshHeader ()

@property (nonatomic, strong) UIImageView *image;
@property (strong, nonatomic) UIActivityIndicatorView *loadingView;
@end

@implementation SHRefreshHeader


- (void)prepare{
    [super prepare];
    self.automaticallyChangeAlpha = YES;
    _image = [[UIImageView alloc] initWithFrame:CGRectMake(150, 0, SCREEN_WIDTH - 200, 40)];
    [_image setImage:[UIImage imageNamed:@"refresh"]];
    [self addSubview:_image];
    
    _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _loadingView.hidesWhenStopped = YES;
    [self addSubview:_loadingView];
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
            }];
        } else {
            [self.loadingView stopAnimating];
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
    }
}

- (void)placeSubviews
{
    [super placeSubviews];
    CGFloat arrowCenterX = self.mj_w * 0.25;
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
}


@end
