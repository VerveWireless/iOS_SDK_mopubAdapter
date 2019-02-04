//
//  VRVRewardedVideo.h
//  mopubAdpater
//
//  Created by Sam Boyce on 1/8/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "MPRewardedVideoCustomEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface VRVRewardedVideoCustomEvent : MPRewardedVideoCustomEvent

- (void)rewardedAdClosedForZone:(nonnull NSString *)zone;
- (void)rewardedAdFailedForZone:(nonnull NSString *)zone;
- (void)rewardedAdReadyForZone:(nonnull NSString *)zone;
- (void)rewardedAdRewardedForZone:(nonnull NSString *)zone;

@end

NS_ASSUME_NONNULL_END
