//
//  VRVInterstitialCustomEvent.m
//  mopubAdpater
//
//  Created by Sam Boyce on 1/9/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVInterstitialCustomEvent.h"
#import <verveSDK/VRVFSAdHandler.h>

@interface VRVInterstitialCustomEvent () <VRVFSAdDelegate>

@property (nonatomic) NSString *appId;
@property (nonatomic) NSString *zone;
@property (nonatomic) BOOL adLoaded;

@end

@implementation VRVInterstitialCustomEvent

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

- (void)requestInterstitialWithCustomEventInfo:(NSDictionary *)info {
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
        if (self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEventWillDisappear:)]) {
            [self.delegate interstitialCustomEventWillDisappear:self];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEventDidDisappear:)]) {
            [self.delegate interstitialCustomEventDidDisappear:self];
        }
    }
}

- (void)onFSAdFailedForZone:(nonnull NSString *)zone {
    if ([zone isEqualToString:self.zone]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEvent:didFailToLoadAdWithError:)]) {
            [self.delegate interstitialCustomEvent:self didFailToLoadAdWithError:nil];
        }
    }
}

- (void)onFSAdReadyForZone:(nonnull NSString *)zone {
    if ([zone isEqualToString:self.zone]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEvent:didLoadAd:)]) {
            [self.delegate interstitialCustomEvent:self didLoadAd:nil];
        }
        self.adLoaded = YES;
    }
}

- (void)showInterstitialFromRootViewController:(UIViewController *)rootViewController {
    if (self.adLoaded) {
        [[VRVFSAdHandler sharedHandler] showFSAdForZone:self.zone inViewController:rootViewController];
        if (self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEventWillAppear:)]) {
            [self.delegate interstitialCustomEventWillAppear:self];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(interstitialCustomEventDidAppear:)]) {
            [self.delegate interstitialCustomEventDidAppear:self];
        }
    } else {
        NSLog(@"Verve SDK: 'showInterstitialFromRootViewController:' was called before interstitial ad was ready");
    }
}

@end
