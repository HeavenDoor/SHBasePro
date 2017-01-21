//
//  MessageSenderLogic.h
//  SHBasePro
//
//  Created by shenghai on 2017/1/15.
//  Copyright © 2017年 ren. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, MessageSendStrategy) {
    MessageSendStrategyText = 0,
    MessageSendStrategyImage = 1,
    MessageSendStrategyVoice = 2,
    MessageSendStrategyVideo = 3
};

/*@protocol MessageSenderDelegate<NSObject>

@required
- (void)messageSender:(MessageSender *)messageSender didSuccessSendMessage:(BaseMessage *)message strategy:(MessageSendStrategy)strategy;

- (void)messageSender:(MessageSender *)messageSender didFailSendMessage:(BaseMessage *)message strategy:(MessageSendStrategy)strategy error:(NSError *)error;
@end


@interface MessageSenderLogic : NSObject





// 然后对外提供一个这样的接口，同时有一个delegate用来回调
- (void)sendMessage:(BaseMessage *)message withStrategy:(MessageSendStrategy)strategy;

@property (nonatomic, weak) id<MessageSenderDelegate> delegate;
@end*/
