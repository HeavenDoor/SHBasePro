//
//  SGScanningQRCodeVC.h
//  SGQRCodeExample
//
//  Created by Sorgle on 16/8/25.
//  Copyright © 2016年 Sorgle. All rights reserved.

#import <UIKit/UIKit.h>

/**拍摄完成代理*/
@protocol QRCodeDelegate <NSObject>

@required
- (void)QRCodeFinishWithResult:(NSString*)result;

@end

@interface SGScanningQRCodeVC : UIViewController
/**拍摄完成回调*/
@property(nonatomic, copy) void(^QRCodeFinishWithResult)(NSString*);

@property(nonatomic, weak) id<QRCodeDelegate> delegate;
@end
