//
//  VRVBannerCustomEvent.m
//  mopubAdpater
//
//  Created by Sam Boyce on 1/9/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVBannerCustomEvent.h"
#import <verveSDK/VRVBannerAdView.h>

@interface VRVBannerCustomEvent () <VRVBannerAdDelegate>

@property (nonatomic) NSString *appId;
@property (nonatomic) NSString *zone;
@property (nonatomic) VRVBannerAdView *bannerAd;

@end

@implementation VRVBannerCustomEvent

- (instancetype)init {
    self = [super init];
    if (self) {
        _appId = @"";
        _zone = @"";
        _bannerAd = nil;
    }
    return self;
}

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info {
    if(info) {
        if([info objectForKey:@"appID"]) {
            self.appId = info[@"appID"];
        } else {
            NSLog(@"Please ensure that you have added appID in the MoPub Dashboard");
            return;
        }
        if([info objectForKey:@"zone"]) {
            self.zone = info[@"zone"];
            VRVBannerAdSize bannerSize = [self calculateBannerSizeFromCGSize:size];
            VRVBannerAdView *bannerAd = [[VRVBannerAdView alloc] initWithDelegate:self bannerSize:bannerSize andRootVC:[UIViewController new]];
            self.bannerAd = bannerAd;
        } else {
            NSLog(@"Please ensure that you have added zone in the MoPub Dashboard");
            return;
        }
    } else {
        NSLog(@"Please ensure that you have added the appID and zone in the MoPub Dashboard");
        return;
    }
}

- (VRVBannerAdSize)calculateBannerSizeFromCGSize:(CGSize)size {
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    if (width == 320 && height == 50) {
        return VRVBannerSizeBanner;
    } else if (width == 728 && height == 90) {
        return VRVBannerSizeTabletBanner;
    } else if (width == 300 && height == 250) {
        return VRVBannerSizeMedRectangle;
    } else {
        return VRVBannerSizeBanner;
    }
}

- (void)onBannerAd:(nonnull VRVBannerAdView *)bannerAd closedForZone:(nonnull NSString *)zone {
}

- (void)onBannerAd:(nonnull VRVBannerAdView *)bannerAd failedForZone:(nonnull NSString *)zone {
    if ([zone isEqualToString:self.zone]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(bannerCustomEvent:didFailToLoadAdWithError:)]) {
            [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:nil];
        }
    }
}

- (void)onBannerAd:(nonnull VRVBannerAdView *)bannerAd readyForZone:(nonnull NSString *)zone {
    if ([zone isEqualToString:self.zone]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(bannerCustomEvent:didLoadAd:)]) {
            [self.delegate bannerCustomEvent:self didLoadAd:self.bannerAd];
        }
    }
}

@end
