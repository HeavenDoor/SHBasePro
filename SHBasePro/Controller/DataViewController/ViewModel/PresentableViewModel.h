//
//  PresentableViewModel.h
//  SHBasePro
//
//  Created by shenghai on 2016/12/20.
//  Copyright © 2016年 ren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PresentableProtocol.h"
#import "MovieModel.h"

@interface PresentableViewModel : NSObject <PresentableProtocol>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *thumbnailUrl;

- (instancetype) initWithData: (MovieModel*) data;

@end
