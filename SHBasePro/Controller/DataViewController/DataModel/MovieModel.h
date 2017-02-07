//
//  MovieModel.h
//  SHBasePro
//
//  Created by shenghai on 16/9/3.
//  Copyright © 2016年 ren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieExtraModel : NSObject
@property (nonatomic, copy) NSString* cateid;
@property (nonatomic, copy) NSString* catename;
@end

@interface MovieModel : NSObject
@property (nonatomic, copy) NSString* postid;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* pid;
@property (nonatomic, copy) NSString* app_fu_title;
@property (nonatomic, copy) NSString* is_xpc;
@property (nonatomic, copy) NSString* is_promote;
@property (nonatomic, copy) NSString* is_xpc_zp;
@property (nonatomic, copy) NSString* is_xpc_cp;
@property (nonatomic, copy) NSString* is_xpc_fx;
@property (nonatomic, copy) NSString* is_album;
@property (nonatomic, copy) NSString* tags;
@property (nonatomic, copy) NSString* recent_hot;
@property (nonatomic, copy) NSString* discussion;
@property (nonatomic, copy) NSString* image;
@property (nonatomic, copy) NSString* rating;
@property (nonatomic, copy) NSString* duration;
@property (nonatomic, copy) NSString* publish_time;
@property (nonatomic, copy) NSString* like_num;
@property (nonatomic, copy) NSString* share_num;
@property (nonatomic, strong) MovieExtraModel* cates;
@property (nonatomic, copy) NSString* request_url;
@end

// 列表外层
@interface MovieDatasModel : NSObject
@property (nonatomic, copy) NSString* status;
@property (nonatomic, copy) NSString* msg;
@property (nonatomic, strong) NSMutableArray<MovieModel*>* data;
@end
