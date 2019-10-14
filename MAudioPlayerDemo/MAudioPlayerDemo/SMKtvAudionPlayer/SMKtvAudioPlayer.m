//
//  SMKtvAudioPlayer.m
//  MAudioPlayerDemo
//
//  Created by mal on 2018/12/19.
//  Copyright © 2018 mal. All rights reserved.
//

#import "SMKtvAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>

///**
// *  判断id是为空
// */
//static inline BOOL IsEmpty(id thing) {
//    return thing == nil || [thing isEqual:[NSNull null]]
//    || ([thing respondsToSelector:@selector(length)]
//        && [(NSData *)thing length] == 0)
//    || ([thing respondsToSelector:@selector(count)]
//        && [(NSArray *)thing count] == 0);
//}

static SMKtvAudioPlayer *audioPlayer = nil;
static int AAPLPlayerViewControllerKVOContext = 0;

@interface SMKtvAudioPlayer ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, copy) NSString *currentPlayUrl;
/** 监控播放当前item播放时间的observer的key */
@property (nonatomic, strong) id timeObserVerToken;
/** 是否注册过通知 */
@property (nonatomic, assign) BOOL isRegisterNotifation;

@end

@implementation SMKtvAudioPlayer

//MARK: - -----------------Public Method
+ (SMKtvAudioPlayer *)defaultPlayer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        audioPlayer = [[SMKtvAudioPlayer alloc] init];
    });
    return audioPlayer;
}

- (void)playWithUrlStr:(NSString *)urlStr
{
    if ([self checkPlayUrl:urlStr])
    {
        [self releasePlayer];
        [self initPlayer];
        NSURL *url = [NSURL fileURLWithPath:urlStr];
        if ([urlStr hasPrefix:@"http://"] || [urlStr hasPrefix:@"https://"])
        {
            url = [NSURL URLWithString:urlStr];
        }
        AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
        [self.player replaceCurrentItemWithPlayerItem:item];
    }
}

//MARK: - init/release
- (void)initPlayer
{
    _player = [[AVPlayer alloc] init];
    [self addObserver];
    [self registerNotifation];
}

- (void)releasePlayer
{
    //移除观察者
    if (self.player.currentItem)
    {
        [self.player pause];
        [self.player cancelPendingPrerolls];
        [self.player.currentItem cancelPendingSeeks];
        [self.player.currentItem.asset cancelLoading];
        [self removeObserver];
        [self.player replaceCurrentItemWithPlayerItem:nil];
    }
    //移除通知
    [self resignNotifation];
    _currentPlayUrl = nil;
    _player = nil;
    _state = SM_KtvAudioPlayerState_UnSet;
}

//MARK: - observer
- (void)addObserver
{
    //当前播放速度
    [self.player addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:&AAPLPlayerViewControllerKVOContext];
    //当前AVPlayerItem记载状况
    [self.player addObserver:self forKeyPath:@"currentItem.status" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:&AAPLPlayerViewControllerKVOContext];
    //加载进度
    [self.player addObserver:self forKeyPath:@"currentItem.loadedTimeRanges" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial context:&AAPLPlayerViewControllerKVOContext];
    
    //监控播放进度
   // __weak SMKtvAudioPlayer *weakSelf = self;
    self.timeObserVerToken = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        double timeElapsed = CMTimeGetSeconds(time);
        NSLog(@"current play time: %.2f", timeElapsed);
    }];
}
//移除observer
- (void)removeObserver
{
    [self.player removeObserver:self forKeyPath:@"rate" context:&AAPLPlayerViewControllerKVOContext];
    [self.player removeObserver:self forKeyPath:@"currentItem.status" context:&AAPLPlayerViewControllerKVOContext];
    [self.player removeObserver:self forKeyPath:@"currentItem.loadedTimeRanges" context:&AAPLPlayerViewControllerKVOContext];
    if (self.timeObserVerToken)
    {
        [self.player removeTimeObserver:self.timeObserVerToken];
        self.timeObserVerToken = nil;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context != &AAPLPlayerViewControllerKVOContext)
    {
        // KVO isn't for us.
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    else if ([keyPath isEqualToString:@"rate"])//当前播放速度
    {
        double newRate = [change[NSKeyValueChangeNewKey] doubleValue];
        _state = SM_KtvAudioPlayerState_Pause;
        if (newRate == 1.0)
        {
            _state = SM_KtvAudioPlayerState_Play;
        }
    }
    else if ([keyPath isEqualToString:@"currentItem.status"])//当前item加载状态
    {
        NSNumber *newStatusAsNumber = change[NSKeyValueChangeNewKey];
        AVPlayerItemStatus newStatus = [newStatusAsNumber isKindOfClass:[NSNumber class]] ? newStatusAsNumber.integerValue : AVPlayerItemStatusUnknown;
        _state = SM_KtvAudioPlayerState_LoadFailure;
        if (newStatus == AVPlayerItemStatusReadyToPlay)
        {
            _state = SM_KtvAudioPlayerState_ReadyToPlay;
            [self.player play];
        }
    }
    else if ([keyPath isEqualToString:@"currentItem.loadedTimeRanges"])//加载进度
    {
        CGFloat loadProgress = [self videoloadProgress];
        NSLog(@"load progress: %.2f", loadProgress);
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

//MARK: - notifation
- (void)registerNotifation
{
    if (self.isRegisterNotifation == NO)
    {
        //播放完成
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemPlayEnd) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        //播放失败
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemPlayFailed) name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
        self.isRegisterNotifation = YES;
    }
}

- (void)resignNotifation
{
    if (self.isRegisterNotifation)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemFailedToPlayToEndTimeNotification object:nil];
        self.isRegisterNotifation = NO;
    }
}

//播放完成
- (void)itemPlayEnd
{
    NSLog(@"");
}

//播放失败
- (void)itemPlayFailed
{
    
}

//MARK: - -----------------Private Method
//获取视频时长
- (double)duration
{
    if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay)
    {
        CMTime newDuration = self.player.currentItem.asset.duration;
        BOOL hasValidDuration = CMTIME_IS_NUMERIC(newDuration) && newDuration.value != 0;
        double newDurationSeconds = hasValidDuration ? CMTimeGetSeconds(newDuration) : 0.0;
        return newDurationSeconds;
    }
    return 0.0f;
}

//获得视频缓存进度
- (CGFloat)videoloadProgress
{
    CGFloat progress = 0.0f;
    AVPlayerItem *item = self.player.currentItem;
    double videoTotalDuration = [self duration];
    if(item && videoTotalDuration > 0)
    {
        NSArray *loadedTimeRanges = [item loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        double loadTime = startSeconds + durationSeconds;// 计算缓冲总进度;
        progress = loadTime / videoTotalDuration;
    }
    return progress;
}

- (BOOL)checkPlayUrl:(NSString *)url
{
//    self.currentPlayUrl = url;
//    if (IsEmpty(url) || ![url isKindOfClass:[NSString class]])
//    {
//        if ([self.m_delegate respondsToSelector:@selector(smKtvAudioPlayer_PlayWithError:)])
//        {
//            [self.m_delegate smKtvAudioPlayer_PlayWithError:SM_ktvAudioPlayerError_UrlInValid];
//        }
//        return NO;
//    }
    return YES;
}


@end
