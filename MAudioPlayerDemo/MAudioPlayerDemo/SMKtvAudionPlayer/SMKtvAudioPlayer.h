//
//  SMKtvAudioPlayer.h
//  MAudioPlayerDemo
//
//  Created by mal on 2018/12/19.
//  Copyright © 2018 mal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SMKtvAudioPlayerError){
    
    SM_ktvAudioPlayerError_Null,//没有错误
    SM_ktvAudioPlayerError_UrlInValid,//播放地址无效（空/不是字符串）
};

typedef NS_ENUM(NSInteger, SMKtvAudioPlayerState){
    
    SM_KtvAudioPlayerState_UnSet,
    SM_KtvAudioPlayerState_Play,
    SM_KtvAudioPlayerState_Pause,
    SM_KtvAudioPlayerState_LoadFailure,
    SM_KtvAudioPlayerState_ReadyToPlay,
};

@protocol SMKtvAudioPlayerDelegate <NSObject>

- (void)smKtvAudioPlayer_PlayWithError:(SMKtvAudioPlayerError)errorType;

@end

NS_ASSUME_NONNULL_BEGIN

@interface SMKtvAudioPlayer : NSObject

@property (nonatomic, weak) id<SMKtvAudioPlayerDelegate> m_delegate;
@property (nonatomic, assign, readonly) SMKtvAudioPlayerState state;

+ (SMKtvAudioPlayer *)defaultPlayer;
- (void)playWithUrlStr:(NSString *)urlStr;

@end

NS_ASSUME_NONNULL_END
