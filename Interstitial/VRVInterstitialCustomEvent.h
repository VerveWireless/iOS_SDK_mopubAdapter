//
//  VRVInterstitialCustomEvent.h
//  mopubAdpater
//
//  Created by Sam Boyce on 1/9/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "MPInterstitialCustomEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface VRVInterstitialCustomEvent : MPInterstitialCustomEvent

- (void)interstitialAdClosedForZone:(nonnull NSString *)zone;
- (void)interstitialAdFailedForZone:(nonnull NSString *)zone;
- (void)interstitialAdReadyForZone:(nonnull NSString *)zone;

@end

NS_ASSUME_NONNULL_END
