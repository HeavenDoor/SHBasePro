//
//  QRCodeScanViewController.h
//  QRCodeDemo
//
//  Created by Darsky on 8/15/14.
//  Copyright (c) 2014 Darsky. All rights reserved.
//


#if TARGET_IPHONE_SIMULATOR
#elif TARGET_OS_IPHONE
#define IMPORT_QRCODE_LIB
#endif

#ifdef IMPORT_QRCODE_LIB
#import "ZBarSDK.h"
#import "ZBarReaderViewController.h"

#endif

@protocol QRCodeScanDelegate <NSObject>

- (void)didQRCodeScanCaptureCode:(NSString*)codeString;

@end
#ifdef IMPORT_QRCODE_LIB

@interface QRCodeScanViewController : ZBarReaderViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZBarReaderDelegate>

{
    UIImageView *_image;
    UIButton *_submitButton;
}
@property (nonatomic, strong) UIImageView * line;

#else
@interface QRCodeScanViewController : UIViewController
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    UIButton *_submitButton;
}
@property (nonatomic, strong) UIImageView * line;

#endif
@property (assign, nonatomic) id <QRCodeScanDelegate> delegate;
@end

