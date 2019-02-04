//
//  VRVRewardedVideo.m
//  mopubAdpater
//
//  Created by Sam Boyce on 1/8/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVRewardedVideoCustomEvent.h"
#import "MPRewardedVideoReward.h"
#import "VRVMoPubRewardedViewController.h"
#import <verveSDK/VRVRewardedAd.h>

@interface VRVRewardedVideoCustomEvent ()

@property (nonatomic) NSString *appId;
@property (nonatomic) NSString *zone;
@property (nonatomic) BOOL adLoaded;
@property (nonatomic) VRVMoPubRewardedViewController *viewController;

@end

@implementation VRVRewardedVideoCustomEvent

- (instancetype)init {
    self = [super init];
    if (self) {
        _appId = @"";
        _zone = @"";
        _adLoaded = NO;
        _viewController = [[VRVMoPubRewardedViewController alloc] initWithCustomEvent:self];
        [VRVRewardedAd setRewardedAdDelegate:_viewController];
    }
    return self;
}

- (void)requestRewardedVideoWithCustomEventInfo:(NSDictionary *)info {
    if(info) {
        if([info objectForKey:@"appID"]) {
            self.appId = info[@"appID"];
        } else {
            NSLog(@"Please ensure that you have added appID in the MoPub Dashboard");
            return;
        }
        if([info objectForKey:@"zone"]) {
            self.zone = info[@"zone"];
            [VRVRewardedAd loadRewardedAdForZone:self.zone];
        } else {
            NSLog(@"Please ensure that you have added zone in the MoPub Dashboard");
            return;
        }
    } else {
        NSLog(@"Please ensure that you have added the appID and zone in the MoPub Dashboard");
        return;
    }
}

- (void)rewardedAdClosedForZone:(nonnull NSString *)zone {
    if ([zone isEqualToString:self.zone]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoWillDisappearForCustomEvent:)]) {
            [self.delegate rewardedVideoWillDisappearForCustomEvent:self];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoDidDisappearForCustomEvent:)]) {
            [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
        }
    }
}

- (void)rewardedAdFailedForZone:(nonnull NSString *)zone {
    if ([zone isEqualToString:self.zone]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoDidFailToLoadAdForCustomEvent:error:)]) {
            [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:nil];
        }
    }
}

- (void)rewardedAdReadyForZone:(nonnull NSString *)zone {
    if ([zone isEqualToString:self.zone]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoDidLoadAdForCustomEvent:)]) {
            [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
        }
        self.adLoaded = YES;
    }
}

- (void)rewardedAdRewardedForZone:(nonnull NSString *)zone {
    if ([zone isEqualToString:self.zone]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoShouldRewardUserForCustomEvent:reward:)]) {
            MPRewardedVideoReward *reward = [[MPRewardedVideoReward alloc] initWithCurrencyType:kMPRewardedVideoRewardCurrencyTypeUnspecified
                                                                                         amount:@(0)];
            [self.delegate rewardedVideoShouldRewardUserForCustomEvent:self reward:reward];
        }
    }
}

- (BOOL)hasAdAvailable {
    return self.adLoaded;
}

- (void)presentRewardedVideoFromViewController:(UIViewController *)viewController {
    if (self.adLoaded) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoWillAppearForCustomEvent:)]) {
            [self.delegate rewardedVideoWillAppearForCustomEvent:self];
        }
        [viewController presentViewController:self.viewController animated:NO completion:^{
            [VRVRewardedAd showRewardedAdForZone:self.zone];
            if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoDidAppearForCustomEvent:)]) {
                [self.delegate rewardedVideoDidAppearForCustomEvent:self];
            }
        }];
    } else {
        NSLog(@"Verve SDK: 'presentRewardedVideoFromViewController:' was called before rewarded ad was ready");
    }
}

@end
