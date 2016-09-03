//
//  MovieModel.m
//  SHBasePro
//
//  Created by shenghai on 16/9/3.
//  Copyright © 2016年 ren. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieExtraModel

@end

@implementation MovieModel

+ (NSDictionary *)objectClassInArray{
    return @{@"cates" : [MovieExtraModel class]};
}

@end

@implementation MovieDatasModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [MovieModel class]};
}

@end



