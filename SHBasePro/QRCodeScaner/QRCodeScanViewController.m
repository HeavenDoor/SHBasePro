//
//  QRCodeScanViewController.m
//  QRCodeDemo
//
//  Created by Darsky on 8/15/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//

#import "QRCodeScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface QRCodeScanViewController ()

@end

@implementation QRCodeScanViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:bIsiOS7?@"navi_bg_64.png":@"navi_bg_44.png"] forBarMetrics:0];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:bIsiOS7?@"back_btn_ios7.png":@"back_btn.png"] forState:UIControlStateNormal];
    [backBtn setFrame:CGRectMake(0, 0, 44, 44)];
    [backBtn addTarget:self action:@selector(backBtnPre:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    [self.navigationItem setLeftBarButtonItem:backItem];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:22]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.titleView = titleLabel;
    [self setTitle:@"扫一扫"];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) // ???
    {
        [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"nav_shadow_clear.png"]];
    }
#ifdef IMPORT_QRCODE_LIB
    [self setUpCamera];
#endif
}

- (void)backBtnPre:(id)sender
{
    if ([[[self navigationController] viewControllers] count] > 1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES
                                 completion:^
         {
             
         }];
    }
}

- (void)setTitle:(NSString *)title
{
    UILabel *titleLabel = (UILabel *)[self.navigationItem titleView];
    [titleLabel setText:title];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel sizeToFit]; // ???
}


#pragma mark - 下面为真机时才启用的代码
#ifdef IMPORT_QRCODE_LIB

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        [picker removeFromParentViewController];
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //初始化
    ZBarReaderController * read = [ZBarReaderController new];
    //设置代理
    read.readerDelegate = self;
    CGImageRef cgImageRef = image.CGImage;
    ZBarSymbol * symbol = nil;
    id <NSFastEnumeration> results = [read scanImage:cgImageRef];
    for (symbol in results)
    {
        break;
    }
    NSString * result;
    if ([symbol.data canBeConvertedToEncoding:NSShiftJISStringEncoding])
        
    {
        result = [NSString stringWithCString:[symbol.data cStringUsingEncoding: NSShiftJISStringEncoding]
                                    encoding:NSUTF8StringEncoding];
    }
    else
    {
        result = symbol.data;
    }
    //TODO:得到二维码的处理
//    [MBProgressHUD hideAllHUDsForView:self.cameraOverlayView animated:YES];
    if ([result isEqualToString:@""])
    {
//        [Constants showMessage:@"扫描失败，请重新扫描"];
    }
    else
    {
        AudioServicesPlaySystemSound(1000);
        if ([self.delegate respondsToSelector:@selector(didQRCodeScanCaptureCode:)])
        {
            [self dismissViewControllerAnimated:YES
                                     completion:^
             {
                 
                 [self.delegate didQRCodeScanCaptureCode:result];
             }];
        }
    }

}

- (void)setUpCamera
{
    self.readerDelegate = self;
    //支持界面旋转
    self.supportedOrientationsMask = ZBarOrientationMaskAll;
    self.showsHelpOnFail = NO;
    self.showsZBarControls = NO;
    self.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    self.readerView.frame = CGRectMake(0,
                                       0,
                                       320,
                                       self.view.frame.size.height);
    self.scanCrop = CGRectMake(0.1, 0.2, 0.8, 0.8);//扫描的感应框
    [self.scanner setSymbology:ZBAR_I25
                        config:ZBAR_CFG_ENABLE
                            to:0];
    UIView * view = [[UIView alloc] initWithFrame:self.view.frame];
    view.backgroundColor = [UIColor clearColor];
    self.cameraOverlayView = view;
    
    _image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg"]];
    if ([UIScreen mainScreen].bounds.size.height >480)
    {
        _image.frame = CGRectMake(60, self.view.frame.size.height/2-200/2, 200, 200);
    }
    else
    {
        _image.frame = CGRectMake(60, self.view.frame.size.height/2-200/2-40, 200, 200);
    }
    [view addSubview:_image];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, _image.frame.origin.y-60, 280, 40)];
    label.text = @"请将扫描的二维码至于下面的框内";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 2;
    label.lineBreakMode = 0;
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, _image.frame.size.width-10, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [_image addSubview:_line];
    [self lineMoveAnimation];
}

- (void)lineMoveAnimation
{
    [UIView animateWithDuration:2
                     animations:^
    {
        if (_line.frame.origin.y >= _image.frame.size.height/2)
        {
            _line.frame = CGRectMake(5, 10, _image.frame.size.width-10, 2);
        }
        else
        {
            _line.frame = CGRectMake(5, _image.frame.size.height-10, _image.frame.size.width-10, 2);
        }
    }
                     completion:^(BOOL finished)
    {
        [self lineMoveAnimation];
    }];
}

#else

#endif

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
