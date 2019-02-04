//
//  VRVMoPubInterstitialViewController.m
//  mopubAdapter
//
//  Created by Sam Boyce on 2/4/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVMoPubInterstitialViewController.h"

@interface VRVMoPubInterstitialViewController ()

@property (nonatomic, weak) VRVInterstitialCustomEvent *customEvent;

@end

@implementation VRVMoPubInterstitialViewController

- (instancetype)initWithCustomEvent:(VRVInterstitialCustomEvent *)customEvent {
    self = [super init];
    if (self) {
        _customEvent = customEvent;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)onInterstitialAdClosedForZone:(nonnull NSString *)zone {
    [self.customEvent interstitialAdClosedForZone:zone];
    [self removeFromParentViewController];
}

- (void)onInterstitialAdFailedForZone:(nonnull NSString *)zone {
    [self.customEvent interstitialAdFailedForZone:zone];
    [self removeFromParentViewController];
}

- (void)onInterstitialAdReadyForZone:(nonnull NSString *)zone {
    [self.customEvent interstitialAdReadyForZone:zone];
}

@end
