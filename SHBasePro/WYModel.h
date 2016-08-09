//
//  WYModel.h
//  M80AttributedLabel
//
//  Created by mac on 16/08/06
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WYModel : NSObject

@property (nonatomic, copy) NSString *url_3w;

@property (nonatomic, copy) NSString *digest;

@property (nonatomic, copy) NSString *ltitle;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, copy) NSString *imgsrc;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *postid;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger priority;

@property (nonatomic, assign) NSInteger votecount;

@property (nonatomic, copy) NSString *lmodify;

@property (nonatomic, copy) NSString *docid;

@property (nonatomic, copy) NSString *boardid;

@property (nonatomic, copy) NSString *ptime;

@property (nonatomic, assign) NSInteger replyCount;

@end