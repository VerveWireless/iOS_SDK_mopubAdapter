//
//  VRVMoPubRewardedViewController.m
//  mopubAdapter
//
//  Created by Sam Boyce on 2/4/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import "VRVMoPubRewardedViewController.h"

@interface VRVMoPubRewardedViewController ()

@property (nonatomic, weak) VRVRewardedVideoCustomEvent *customEvent;

@end

@implementation VRVMoPubRewardedViewController

- (instancetype)initWithCustomEvent:(VRVRewardedVideoCustomEvent *)customEvent {
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

- (void)onRewardedAdClosedForZone:(nonnull NSString *)zone {
    [self.customEvent rewardedAdClosedForZone:zone];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)onRewardedAdFailedForZone:(nonnull NSString *)zone {
    [self.customEvent rewardedAdFailedForZone:zone];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)onRewardedAdReadyForZone:(nonnull NSString *)zone {
    [self.customEvent rewardedAdReadyForZone:zone];
}

- (void)onRewardedAdRewardedForZone:(nonnull NSString *)zone {
    [self.customEvent rewardedAdRewardedForZone:zone];
}

@end
