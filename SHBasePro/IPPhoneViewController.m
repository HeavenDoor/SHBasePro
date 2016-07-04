//
//  IPPhoneViewController.m
//  Erp4iOS
//
//  Created by 赵宏 on 15/5/13.
//  Copyright (c) 2015年 成都好房通科技有限公司. All rights reserved.
//

#import "IPPhoneViewController.h"
#import "UIImage+GIF.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+Tool.h"
@interface IPPhoneViewController ()
{
    int _count;//控制下发的闪烁动画
}

//闪光点
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;

//中间图标
@property (weak, nonatomic) IBOutlet UIImageView *centerImageV;

//转接服务
@property (weak, nonatomic) IBOutlet UILabel *zhuanjiefuwuLab;

//先接听来电
@property (weak, nonatomic) IBOutlet UILabel *xianJieTingLab;
//等待接通对方
@property (weak, nonatomic) IBOutlet UILabel *dengDaiJieTingLab;
//接通后收费
@property (weak, nonatomic) IBOutlet UILabel *jieTongShouFeiLab;

@property (weak, nonatomic) IBOutlet UIImageView *ourUserHeadImage;
@property (weak, nonatomic) IBOutlet UIImageView *hisHeadImage;

@end

@implementation IPPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self initAnimation];
    
    _count = 0;
    //初始化动画
    [self initAnimation];
    
    //注册监听用于当接听电话时关闭此界面
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dissToBack) name:@"closeIpAnimation" object:nil];
    
    //动画计时器
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval: 0.3
                                             target: self
                                           selector: @selector(starAnimation)
                                           userInfo: nil
                                            repeats: YES];
    
    NSDictionary *userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoKey];
    
    //设置并获取头像
    self.ourUserHeadImage.layer.cornerRadius = 40;
    [UIImageView scaleImageToFitWithImageView:self.ourUserHeadImage];
    self.ourUserHeadImage.layer.masksToBounds = YES;
  HFTUser *user = [[HFTUser alloc] initWithDictionary:userInfo];

    
    [self.ourUserHeadImage sd_setImageWithURL:[NSURL URLWithString:user.USER_PHOTO] placeholderImage:[UIImage imageNamed:@"拨打动画对方头像"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!error) {
            self.ourUserHeadImage.layer.borderColor = [[UIColor whiteColor]CGColor];
            self.ourUserHeadImage.layer.borderWidth = 2;
        }
    }];
  
    
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}



- (void)dissToBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}





//初始化动画，隐藏所有的东西
- (void)initAnimation
{
    
    
    
  
    
    self.button1.hidden = YES;
    self.button2.hidden = YES;
    self.button3.hidden = YES;
    //self.button4.hidden = YES;
    //self.button5.hidden = YES;
    //self.button6.hidden = YES;
    
    //self.centerImageV.hidden = YES;
    //self.zhuanjiefuwuLab.hidden = YES;
   // self.ourUserHeadImage.hidden = YES;
    //self.dengDaiJieTingLab.hidden = YES;
    //self.xianJieTingLab.hidden = YES;
    
    self.hisHeadImage.hidden = YES;
    self.jieTongShouFeiLab.hidden = YES;
    
   
}


//开始动画
-(void)starAnimation
{
    _count++;
    if (_count>=2&&_count<5) {
        if (self.button4.selected==YES) {
            
            [self animation1];
        }else if (self.button5.selected == YES)
        {
            [self animation2];
        }else{
            
            [self animation3];
        }

    }else if (_count>=5)
    {
        if (self.button4.selected==YES) {
            
            [self animation1];
        }else if (self.button5.selected == YES)
        {
            [self animation2];
        }else{
            
            [self animation3];
        }
  
    }
    

    [self showImageView];
    
    if (_count == 34) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

//动画1
- (void)animation1
{
    self.button3.selected = NO;
    self.button2.selected = YES;
    self.button1.selected = NO;
    
    self.button4.selected = NO;
    self.button5.selected = YES;
    self.button6.selected = NO;

}
//动画2
-(void)animation2
{
    self.button3.selected = NO;
    self.button2.selected = NO;
    self.button1.selected = YES;
    
    self.button4.selected = NO;
    self.button5.selected = NO;
    self.button6.selected = YES;
}
//动画3
- (void)animation3
{
    self.button3.selected = YES;
    self.button2.selected = NO;
    self.button1.selected = NO;
    
    self.button4.selected = YES;
    self.button5.selected = NO;
    self.button6.selected = NO;
}

#pragma mark 显示顶部图片
-(void)showImageView
{
    if (_count == 1) {
        self.centerImageV.hidden = NO;
        self.zhuanjiefuwuLab.hidden = NO;
    }else if (_count == 2)
    {
        self.button4.hidden = NO;
    }
    else if (_count == 3)
    {
        self.button5.hidden = NO;
    }
    else if (_count == 4)
    {
        self.button6.hidden = NO;
        self.ourUserHeadImage.hidden = NO;
        self.xianJieTingLab.hidden = NO;
        self.dengDaiJieTingLab.hidden = NO;
    }
    else if (_count == 5)
    {
        self.button3.hidden = NO;
    }
    else if (_count == 6)
    {
        self.button2.hidden = NO;
    }
    else if (_count == 7)
    {
        self.button1.hidden = NO;
        self.hisHeadImage.hidden = NO;
        self.jieTongShouFeiLab.hidden = NO;
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
