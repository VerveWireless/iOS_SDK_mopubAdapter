//
//  VRVMoPubInterstitialViewController.h
//  mopubAdapter
//
//  Created by Sam Boyce on 2/4/19.
//  Copyright © 2019 Verve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <verveSDK/VRVInterstitialAd.h>
#import "VRVInterstitialCustomEvent.h"

NS_ASSUME_NONNULL_BEGIN

@interface VRVMoPubInterstitialViewController : UIViewController <VRVInterstitialAdDelegate>

- (instancetype)initWithCustomEvent:(VRVInterstitialCustomEvent *)customEvent;

@end

NS_ASSUME_NONNULL_END
