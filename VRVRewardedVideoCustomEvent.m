//
//  VRVRewardedVideo.m
//  mopubAdpater
//
//  Created by Sam Boyce on 1/8/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVRewardedVideoCustomEvent.h"
#import "MPRewardedVideoReward.h"
#import <verveSDK/verveSDK.h>

@interface VRVRewardedVideoCustomEvent () <VRVFSAdDelegate>

@property (nonatomic) NSString *appId;
@property (nonatomic) NSString *zone;
@property (nonatomic) BOOL adLoaded;

@end

@implementation VRVRewardedVideoCustomEvent

- (instancetype)init {
    self = [super init];
    if (self) {
        _appId = @"";
        _zone = @"";
        _adLoaded = NO;
        [[VRVFSAdHandler sharedHandler] setFSAdDelegate:self];
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
            [[VRVFSAdHandler sharedHandler] loadFSAdForZone:self.zone];
        } else {
            NSLog(@"Please ensure that you have added zone in the MoPub Dashboard");
            return;
        }
    } else {
        NSLog(@"Please ensure that you have added the appID and zone in the MoPub Dashboard");
        return;
    }
}

- (void)onFSAdClosedForZone:(nonnull NSString *)zone {
    if ([zone isEqualToString:self.zone]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoWillDisappearForCustomEvent:)]) {
            [self.delegate rewardedVideoWillDisappearForCustomEvent:self];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoDidDisappearForCustomEvent:)]) {
            [self.delegate rewardedVideoDidDisappearForCustomEvent:self];
        }
    }
}

- (void)onFSAdFailedForZone:(nonnull NSString *)zone {
    if ([zone isEqualToString:self.zone]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoDidFailToLoadAdForCustomEvent:error:)]) {
            [self.delegate rewardedVideoDidFailToLoadAdForCustomEvent:self error:nil];
        }
    }
}

- (void)onFSAdReadyForZone:(nonnull NSString *)zone {
    if ([zone isEqualToString:self.zone]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoDidLoadAdForCustomEvent:)]) {
            [self.delegate rewardedVideoDidLoadAdForCustomEvent:self];
        }
        self.adLoaded = YES;
    }
}

- (void)onFSAdRewardedForZone:(NSString *)zone {
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
        [[VRVFSAdHandler sharedHandler] showFSAdForZone:self.zone inViewController:viewController];
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoWillAppearForCustomEvent:)]) {
            [self.delegate rewardedVideoWillAppearForCustomEvent:self];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(rewardedVideoDidAppearForCustomEvent:)]) {
            [self.delegate rewardedVideoDidAppearForCustomEvent:self];
        }
    }
}

@end
