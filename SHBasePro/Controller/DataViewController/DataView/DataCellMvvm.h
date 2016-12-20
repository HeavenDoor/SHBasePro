//
//  DataCellMvvm.h
//  SHBasePro
//
//  Created by mac on 16/9/4.
//  Copyright © 2016年 ren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PresentableProtocol.h"

@interface DataCellMvvm : UITableViewCell

- (void) updateWithPresenter: (id<PresentableProtocol>) presenter;

@end
