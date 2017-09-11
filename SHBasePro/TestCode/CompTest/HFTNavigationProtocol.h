//
//  HFTNavigationProtocol.h
//  SHBasePro
//
//  Created by shenghai on 2017/5/25.
//  Copyright © 2017年 ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HFTNavigationProtocol <NSObject>

@required
/**返回上一级*/
- (void)backAction;

@end
